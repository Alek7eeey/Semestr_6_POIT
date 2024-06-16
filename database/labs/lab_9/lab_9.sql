--associative array
-- Создаем коллекцию для сотрудников
CREATE OR REPLACE TYPE EmployeeCollection AS TABLE OF EmployeeType;
-- Создаем коллекцию для отпусков
CREATE OR REPLACE TYPE HolidaysCollection AS TABLE OF HolidaysType;

--1 задание
CREATE OR REPLACE TYPE EmployeeWithHolidaysType AS OBJECT (
    employee EmployeeType,
    holidays HolidaysCollection
);

CREATE OR REPLACE TYPE EmployeeWithHolidaysCollection AS TABLE OF EmployeeWithHolidaysType;

DECLARE
    emp_collection EmployeeCollection;
    emp_id NUMBER := 1;

BEGIN
    SELECT CAST(MULTISET(
               SELECT EmployeeType(id, ИМЯ, ФАМИЛИЯ, ОБРАЗОВАНИЕ_ID, СЕМЕЙНОЕ_ПОЛОЖЕНИЕ, СТРАХОВОЙ_ПОЛЮС_ID, ПОЛ)
               FROM Сотрудники) AS EmployeeCollection)
    INTO emp_collection
    FROM dual;

    FOR i IN 1..emp_collection.COUNT LOOP
        IF emp_collection(i).id = emp_id THEN
            DBMS_OUTPUT.PUT_LINE('Сотрудник найден!');
            EXIT;
        END IF;
    END LOOP;
END;

--Найти пустые коллекции:
DECLARE
    emp_collection EmployeeCollection := EmployeeCollection();
BEGIN
    SELECT CAST(MULTISET(
               SELECT EmployeeType(id, ИМЯ, ФАМИЛИЯ, ОБРАЗОВАНИЕ_ID, СЕМЕЙНОЕ_ПОЛОЖЕНИЕ, СТРАХОВОЙ_ПОЛЮС_ID, ПОЛ)
               FROM Сотрудники) AS EmployeeCollection)
    INTO emp_collection
    FROM dual;

    IF emp_collection.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Коллекция сотрудников пуста.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Коллекция сотрудников не пуста.');
    END IF;
END;

--***************
DECLARE
    emp_collection EmployeeCollection;
    holidays_collection HolidaysCollection;
BEGIN
    SELECT CAST(MULTISET(
               SELECT EmployeeType(id, ИМЯ, ФАМИЛИЯ, ОБРАЗОВАНИЕ_ID, СЕМЕЙНОЕ_ПОЛОЖЕНИЕ, СТРАХОВОЙ_ПОЛЮС_ID, ПОЛ)
               FROM Сотрудники) AS EmployeeCollection)
    INTO emp_collection
    FROM dual;

    SELECT CAST(MULTISET(
               SELECT HolidaysType(id, СОТРУДНИК_ID, ДАТА_НАЧАЛА,ВИД_ОТПУСКА, ДАТА_ОКОНЧАНИЯ)
               FROM Отпуска) AS HolidaysCollection)
    INTO holidays_collection
    FROM dual;

    FOR i IN 1..emp_collection.COUNT LOOP
        DECLARE
            holiday_count NUMBER;
        BEGIN
            SELECT COUNT(*)
            INTO holiday_count
            FROM TABLE(holidays_collection)
            WHERE employee_id  = emp_collection(i).id;

            IF holiday_count = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Сотрудник ' || emp_collection(i).id || ' не имеет отпуска.');
            END IF;

             IF holiday_count != 0 THEN
                DBMS_OUTPUT.PUT_LINE('Сотрудник ' || emp_collection(i).id || ' имеет отпуск.');
            END IF;
        END;
    END LOOP;
END;

--Преобразовать коллекцию к другому виду:
DECLARE
    emp_collection EmployeeCollection;
    hol_collection HolidaysCollection := HolidaysCollection(); -- Инициализация коллекции отпусков
BEGIN
    SELECT CAST(MULTISET(
               SELECT EmployeeType(id, ИМЯ, ФАМИЛИЯ, ОБРАЗОВАНИЕ_ID, СЕМЕЙНОЕ_ПОЛОЖЕНИЕ, СТРАХОВОЙ_ПОЛЮС_ID, ПОЛ)
               FROM Сотрудники) AS EmployeeCollection)
    INTO emp_collection
    FROM dual;

    FOR i IN 1..emp_collection.COUNT LOOP
        hol_collection.EXTEND;
        hol_collection(i) := HolidaysType(
                                emp_collection(i).id,
                                emp_collection(i).id,
                                SYSDATE,
                                'Плановый отпуск',
                                SYSDATE + 14
                             );
    END LOOP;
END;

--реляционная бд
CREATE TABLE Отпуска_тест (
    ID NUMBER PRIMARY KEY,
    Сотрудник_ID NUMBER,
    Дата_начала DATE,
    Вид_отпуска NVARCHAR2(100),
    Дата_окончания DATE,
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);


DECLARE
    emp_collection EmployeeCollection;
    hol_collection HolidaysCollection := HolidaysCollection(); -- Инициализация коллекции отпусков
BEGIN
    SELECT CAST(MULTISET(
               SELECT EmployeeType(id, ИМЯ, ФАМИЛИЯ, ОБРАЗОВАНИЕ_ID, СЕМЕЙНОЕ_ПОЛОЖЕНИЕ, СТРАХОВОЙ_ПОЛЮС_ID, ПОЛ)
               FROM Сотрудники) AS EmployeeCollection)
    INTO emp_collection
    FROM dual;

    FOR i IN 1..emp_collection.COUNT LOOP
        hol_collection.EXTEND;
        hol_collection(i) := HolidaysType(
                                emp_collection(i).id,
                                emp_collection(i).id,
                                SYSDATE,
                                'Плановый отпуск',
                                SYSDATE + 14
                             );
    END LOOP;

    FORALL i IN 1..hol_collection.COUNT
        INSERT INTO Отпуска_тест (ID, СОТРУДНИК_ID, ДАТА_НАЧАЛА, ДАТА_ОКОНЧАНИЯ, ВИД_ОТПУСКА)
        VALUES (hol_collection(i).id, hol_collection(i).employee_id, hol_collection(i).start_date, hol_collection(i).end_date, hol_collection(i).vacation_type);
END;

--Применение BULK операций:
CREATE TABLE Test_table (
    first_name NVARCHAR2(100),
    last_name NVARCHAR2(100)
);

DECLARE
    emp_collection EmployeeCollection;
BEGIN
    SELECT CAST(MULTISET(
               SELECT EmployeeType(id, ИМЯ, ФАМИЛИЯ, ОБРАЗОВАНИЕ_ID, СЕМЕЙНОЕ_ПОЛОЖЕНИЕ, СТРАХОВОЙ_ПОЛЮС_ID, ПОЛ)
               FROM Сотрудники) AS EmployeeCollection)
    INTO emp_collection
    FROM dual;

    FORALL i IN 1..emp_collection.COUNT
        INSERT INTO Test_table VALUES (emp_collection(i).first_name, emp_collection(i).last_name);
END;

select *
from Test_table;
