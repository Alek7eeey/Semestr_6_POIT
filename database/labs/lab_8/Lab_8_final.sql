-- Создание объектного типа данных для сотрудника
CREATE OR REPLACE TYPE EmployeeType AS OBJECT (
    id NUMBER,
    first_name NVARCHAR2(100),
    last_name NVARCHAR2(100),
    education_id NUMBER,
    marital_status NVARCHAR2(100),
    insurance_policy_id NUMBER,
    gender NVARCHAR2(10),
    CONSTRUCTOR FUNCTION EmployeeType(first_name NVARCHAR2) RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION EmployeeType(
        id NUMBER,
        first_name NVARCHAR2,
        last_name NVARCHAR2,
        education_id NUMBER,
        marital_status NVARCHAR2,
        insurance_policy_id NUMBER,
        gender NVARCHAR2
    ) RETURN SELF AS RESULT,
    MEMBER FUNCTION compareType(other IN EmployeeType) RETURN VARCHAR2,
    MEMBER FUNCTION getInfo RETURN NVARCHAR2,
    MEMBER PROCEDURE printInfo
);

-- Создание объектного типа данных для отпуска
CREATE OR REPLACE TYPE WeekendsType AS OBJECT (
    id NUMBER,
    employee_id NUMBER,
    start_date DATE,
    vacation_type NVARCHAR2(100),
    end_date DATE,
    CONSTRUCTOR FUNCTION WeekendsType(vacation_type NVARCHAR2) RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION WeekendsType(
        id NUMBER,
        employee_id NUMBER,
        start_date DATE,
        vacation_type NVARCHAR2,
        end_date DATE
    ) RETURN SELF AS RESULT,
    MEMBER FUNCTION compareType(other IN WeekendsType) RETURN VARCHAR2,
    MEMBER FUNCTION getInfo RETURN NVARCHAR2,
    MEMBER PROCEDURE printInfo,
    MAP MEMBER FUNCTION calculateDuration RETURN NUMBER DETERMINISTIC
);

-- Создание тела объектного типа данных для сотрудника
CREATE OR REPLACE TYPE BODY EmployeeType AS
    CONSTRUCTOR FUNCTION EmployeeType(first_name NVARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
        SELF.first_name := first_name;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION EmployeeType(
        id NUMBER,
        first_name NVARCHAR2,
        last_name NVARCHAR2,
        education_id NUMBER,
        marital_status NVARCHAR2,
        insurance_policy_id NUMBER,
        gender NVARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.id := id;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        SELF.education_id := education_id;
        SELF.marital_status := marital_status;
        SELF.insurance_policy_id := insurance_policy_id;
        SELF.gender := gender;
        RETURN;
    END;

    MEMBER FUNCTION compareType(other IN EmployeeType) RETURN VARCHAR2 IS
    BEGIN
        RETURN CASE WHEN self.first_name = other.first_name THEN 'EQUAL'
                    ELSE 'NOT EQUAL' END;
    END;

    MEMBER FUNCTION getInfo RETURN NVARCHAR2 IS
    BEGIN
        RETURN self.first_name || ' ' || self.last_name;
    END;

    MEMBER PROCEDURE printInfo IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(self.getInfo);
    END;
END;

-- Создание тела объектного типа данных для отпуска
CREATE OR REPLACE TYPE BODY WeekendsType AS
    CONSTRUCTOR FUNCTION WeekendsType(vacation_type NVARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
        SELF.vacation_type := vacation_type;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION WeekendsType(
        id NUMBER,
        employee_id NUMBER,
        start_date DATE,
        vacation_type NVARCHAR2,
        end_date DATE
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.id := id;
        SELF.employee_id := employee_id;
        SELF.start_date := start_date;
        SELF.vacation_type := vacation_type;
        SELF.end_date := end_date;
        RETURN;
    END;

    MEMBER FUNCTION compareType(other IN WeekendsType) RETURN VARCHAR2 IS
    BEGIN
        RETURN CASE WHEN self.vacation_type = other.vacation_type THEN 'EQUAL'
                    ELSE 'NOT EQUAL' END;
    END;

    MEMBER FUNCTION getInfo RETURN NVARCHAR2 IS
    BEGIN
        RETURN 'Type: ' || self.vacation_type || ', Start Date: ' || TO_CHAR(self.start_date, 'YYYY-MM-DD') || ', End Date: ' || TO_CHAR(self.end_date, 'YYYY-MM-DD');
    END;

    MEMBER PROCEDURE printInfo IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(self.getInfo);
    END;

    MAP MEMBER FUNCTION calculateDuration RETURN NUMBER DETERMINISTIC
    IS
    BEGIN
        RETURN self.end_date - self.start_date;
    END;
END;

--**************************************************************
-- Создание таблицы для хранения объектов "Отпуска"
CREATE TABLE HolidayTable (
    vacation_obj WeekendsType
);
drop table HolidayTable;

select *
from HolidayTable;

delete from HolidayTable v where v.vacation_obj.ID != -1;

-- Заполнение таблицы объектами "Отпуска" из таблицы "Отпуска"
DECLARE
    vacation_obj WeekendsType;
BEGIN
    FOR vacation_rec IN (SELECT id, Сотрудник_ID, Дата_начала, Вид_отпуска, Дата_окончания FROM Отпуска) LOOP
        vacation_obj := WeekendsType(vacation_rec.id, vacation_rec.Сотрудник_ID, vacation_rec.Дата_начала, vacation_rec.Вид_отпуска, vacation_rec.Дата_окончания);
        INSERT INTO HolidayTable VALUES (vacation_obj);
    END LOOP;
END;

-- Создание представления сотрудников
CREATE OR REPLACE VIEW EmployeeView AS
SELECT s.ID,
       s.Имя AS first_name,
       s.Фамилия AS last_name,
       s.Образование_ID AS education_id,
       s.Семейное_положение AS marital_status,
       s.Страховой_полюс_ID AS insurance_policy_id,
       s.Пол AS gender
FROM Сотрудники s;

select *
from EmployeeView;

-- Пример запроса, использующего методы объектов
DECLARE
    employee_obj EmployeeType;
    vacation_obj WeekendsType;
BEGIN
    SELECT EmployeeType(ID, first_name, last_name, education_id, marital_status, insurance_policy_id, gender) INTO employee_obj
    FROM EmployeeView
    WHERE first_name = 'Анна';

    IF employee_obj IS NOT NULL THEN
        employee_obj.printInfo;
        -- Получение отпусков сотрудника
        FOR vacation_rec IN (SELECT * FROM HolidayTable v where v.vacation_obj.EMPLOYEE_ID = employee_obj.ID) LOOP
            vacation_obj := vacation_rec.vacation_obj;
            IF vacation_obj IS NOT NULL THEN
                vacation_obj.printInfo;
            ELSE
                DBMS_OUTPUT.PUT_LINE('Отпуск для сотрудника не найден.');
            END IF;
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Сотрудник с именем "Иван" не найден.');
    END IF;
END;

DECLARE
    empl1 EmployeeType := EmployeeType(1, 'John', 'Doe', 2, 'Не женат', 1, 'M');
    empl2 EmployeeType := EmployeeType(2, 'Ann', 'Dirna', 1, 'Замужем', 21, 'Д');
    vocation1 WeekendsType := WeekendsType(1, 1, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Ежегодный', TO_DATE('2024-08-01', 'YYYY-MM-DD'));
    vocation2 WeekendsType := WeekendsType(2, 2, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Дополнительный', TO_DATE('2024-08-01', 'YYYY-MM-DD'));
BEGIN

    empl1.printInfo;
    empl2.printInfo;

    vocation1.printInfo;
    vocation2.printInfo;

    DBMS_OUTPUT.PUT_LINE(empl1.compareType(empl2));
    DBMS_OUTPUT.PUT_LINE(vocation1.compareType(vocation1));
    DBMS_OUTPUT.PUT_LINE(vocation1.CALCULATEDURATION());
END;

CREATE INDEX vacation_idx_emplId ON HolidayTable v(v.vacation_obj.EMPLOYEE_ID);
drop INDEX vacation_idx_emplId;
SELECT * FROM HolidayTable c where c.vacation_obj.EMPLOYEE_ID = 1;

CREATE INDEX vacation_employee_id_idx ON HolidayTable (VALUE(vacation_obj).employee_id);

--order by count(*)
SELECT c.vacation_obj.EMPLOYEE_ID, count(*) as count_holidays FROM HolidayTable c group by c.vacation_obj.EMPLOYEE_ID order by count(*);

--view
CREATE OR REPLACE VIEW vacation_view AS
SELECT c.id, c.СОТРУДНИК_ID, c.ВИД_ОТПУСКА,
       TO_DATE(c.ДАТА_НАЧАЛА, 'YYYY-MM-DD') AS ДАТА_НАЧАЛА,
       TO_DATE(c.ДАТА_ОКОНЧАНИЯ, 'YYYY-MM-DD') AS ДАТА_ОКОНЧАНИЯ
FROM ОТПУСКА c;

create or replace view vacation_view of WeekendsType
with object identifier (id) as
select c.id, c.СОТРУДНИК_ID,c.ДАТА_НАЧАЛА,
       c.ВИД_ОТПУСКА, c.ДАТА_ОКОНЧАНИЯ
from ОТПУСКА c;

select * from vacation_view;

drop view vacation_view;

CREATE bitmap INDEX vacation_duration_idx ON HolidayTable (vacation_obj.calculateDuration());
drop index vacation_duration_idx;
SELECT v.vacation_obj.calculateDuration() as res FROM HolidayTable v WHERE v.vacation_obj.calculateDuration() > 5;

DECLARE
    vacation_duration NUMBER;
BEGIN
    -- Получаем продолжительность отпуска для первого сотрудника
    SELECT v.vacation_obj.calculateDuration() INTO vacation_duration
    FROM HolidayTable v
    WHERE v.vacation_obj.employee_id =3;

    -- Выводим продолжительность отпуска
    DBMS_OUTPUT.PUT_LINE('Продолжительность отпуска для сотрудника с id = 3: ' || vacation_duration || ' дней.');
END;

select h.vacation_obj.CALCULATEDURATION() from HolidayTable h order by h.vacation_obj.EMPLOYEE_ID
--map or order
--index with plans +