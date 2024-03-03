BEGIN
    INSERT INTO Сотрудники (ID, Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол)
    VALUES (1, 'Иван', 'Иванов', 2, 'Женат', 3, 'Мужской');

    INSERT INTO Сотрудники (ID, Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол)
    VALUES (2, 'Мария', 'Петрова', 3, 'Не замужем', 2, 'Женский');

    INSERT INTO Сотрудники (ID, Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол)
    VALUES (3, 'Алексей', 'Кравченко', 3, 'Холост', 2, 'Мужской');

    INSERT INTO Сотрудники (ID, Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол)
    VALUES (4, 'Дмитрий', 'Гайков', 3, 'Женат', 2, 'Мужской');
END;

BEGIN
    INSERT INTO Образование (ID, Уровень, Специальность, Учебное_заведение)
    VALUES (2, 'Высшее', 'Информационные технологии', 'МГУ');

    INSERT INTO Образование (ID, Уровень, Специальность, Учебное_заведение)
    VALUES (3, 'Среднее специальное', 'Бухгалтерия', 'Минский колледж');
end;

BEGIN
    INSERT INTO Страховой_полюс (ID, Номер_полюса, Страховая_компания)
    VALUES (2, '1234567890', 'Росгосстрах');

    INSERT INTO Страховой_полюс (ID, Номер_полюса, Страховая_компания)
    VALUES (3, '0987654321', 'Согаз');
end;

--********************
ALTER TABLE Сотрудники
ADD (Родительский_ID NUMBER);

--********************
BEGIN
    UPDATE Сотрудники SET Родительский_ID = NULL WHERE ID = 1;

    UPDATE Сотрудники SET Родительский_ID = 1 WHERE ID IN (2, 3);
    UPDATE Сотрудники SET Родительский_ID = 2 WHERE ID IN (4);
END;

--1
CREATE OR REPLACE PROCEDURE display_hierarchy(p_node_id IN NUMBER) IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('ID | Level');
    FOR rec IN (
        SELECT ID, LEVEL
        FROM Сотрудники
        START WITH ID = p_node_id
        CONNECT BY PRIOR ID = Родительский_ID
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.ID || ' | ' || rec.LEVEL);
    END LOOP;
END;

--2
CREATE OR REPLACE PROCEDURE add_child_node(p_parent_node_id IN NUMBER, p_child_node_id IN NUMBER) IS
BEGIN
    UPDATE Сотрудники SET Родительский_ID = p_parent_node_id WHERE ID = p_child_node_id;
END;

--3
CREATE OR REPLACE PROCEDURE move_children(p_old_parent_node_id IN NUMBER, p_new_parent_node_id IN NUMBER) IS
BEGIN
    UPDATE Сотрудники SET Родительский_ID = p_new_parent_node_id WHERE Родительский_ID = p_old_parent_node_id;
END;

--4
BEGIN
    display_hierarchy(1);
END;

--5
BEGIN
    add_child_node(3, 2);
END;

--6
BEGIN
    move_children(3, 4);
END;

select *
from СОТРУДНИКИ;