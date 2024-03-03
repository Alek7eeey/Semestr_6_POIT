use BD_Lab_2;

-- 1. Добавление столбца данных иерархического типа
ALTER TABLE Сотрудники
ADD ManagerHierarchy hierarchyid

-- 2. Создание процедуры для отображения подчиненных узлов
CREATE PROCEDURE dbo.GetSubordinates
    @manager hierarchyid
AS
BEGIN
    SELECT
        ID,
        Имя,
        Фамилия,
        ManagerHierarchy.ToString() as HierarchyString,
        ManagerHierarchy.GetLevel() as HierarchyLevel
    FROM
        Сотрудники
    WHERE
        ManagerHierarchy.IsDescendantOf(@manager) = 1
    ORDER BY
        ManagerHierarchy
END

-- 3. Создание процедуры для добавления подчиненного узла
CREATE PROCEDURE dbo.AddSubordinate
    @manager hierarchyid,
    @subordinateId int
AS
BEGIN
    DECLARE @nextSubordinate hierarchyid
    SELECT @nextSubordinate = MAX(ManagerHierarchy)
    FROM Сотрудники
    WHERE ManagerHierarchy.GetAncestor(1) = @manager

    UPDATE Сотрудники
    SET ManagerHierarchy = @manager.GetDescendant(@nextSubordinate, NULL)
    WHERE ID = @subordinateId
END

-- 4. Создание процедуры для перемещения подчиненных
CREATE PROCEDURE dbo.MoveSubordinates
    @oldManagerId int,
    @newManagerId int
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Сотрудники WHERE ID = @oldManagerId)
        RAISERROR ('PARM1 | Сотрудник с id %s не существует', 16, 1, NULL);

    IF NOT EXISTS(SELECT 1 FROM Сотрудники WHERE ID = @newManagerId)
        RAISERROR ('PARM2 | Сотрудник с id %s не существует', 16, 1, NULL);

    DECLARE @oldHierarchy HIERARCHYID = NULL;
    DECLARE @newHierarchy HIERARCHYID = NULL;

    SELECT @oldHierarchy = ManagerHierarchy FROM Сотрудники WHERE ID = @oldManagerId;
    SELECT @newHierarchy = ManagerHierarchy FROM Сотрудники WHERE ID = @newManagerId;

    UPDATE Сотрудники
    SET ManagerHierarchy = @newHierarchy.GetDescendant(@oldHierarchy.GetAncestor(1), NULL)
    WHERE ManagerHierarchy.GetAncestor(1) = @oldHierarchy
END
GO

--drop procedure dbo.MoveSubordinates

/*CREATE PROCEDURE dbo.MoveSubordinates
    @oldManagerId INT,
    @newManagerId INT
AS
BEGIN
    DECLARE @oldManager hierarchyid, @newManager hierarchyid
    SELECT @oldManager = ManagerHierarchy FROM Сотрудники WHERE ID = @oldManagerId
    SELECT @newManager = ManagerHierarchy FROM Сотрудники WHERE ID = @newManagerId

    -- Сохраняем иерархию старого менеджера
    DECLARE @oldManagerHierarchy hierarchyid = (SELECT ManagerHierarchy FROM Сотрудники WHERE ID = @oldManagerId)

    -- Перемещаем старого менеджера под нового
    EXEC dbo.AddSubordinate @newManager, @oldManagerId

    -- Перемещаем всех подчиненных старого менеджера под нового менеджера
    DECLARE @oldManagerSubordinates TABLE (ID int, OldHierarchy hierarchyid)
    INSERT INTO @oldManagerSubordinates
    SELECT ID, ManagerHierarchy
    FROM Сотрудники
    WHERE ManagerHierarchy.GetAncestor(1) = @oldManagerHierarchy

    DECLARE @maxNewManagerSubordinate hierarchyid
    SELECT @maxNewManagerSubordinate = MAX(ManagerHierarchy)
    FROM Сотрудники
    WHERE ManagerHierarchy.GetAncestor(1) = @newManager

    DECLARE @id int, @oldHierarchy hierarchyid, @newHierarchy hierarchyid
    DECLARE cur CURSOR FOR SELECT ID, OldHierarchy FROM @oldManagerSubordinates
    OPEN cur
    FETCH NEXT FROM cur INTO @id, @oldHierarchy
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @newHierarchy = @newManager.GetDescendant(@maxNewManagerSubordinate, NULL)
        UPDATE Сотрудники
        SET ManagerHierarchy = ManagerHierarchy.GetReparentedValue(@oldHierarchy, @newHierarchy)
        WHERE ManagerHierarchy.IsDescendantOf(@oldHierarchy) = 1
        SET @maxNewManagerSubordinate = @newHierarchy
        FETCH NEXT FROM cur INTO @id, @oldHierarchy
    END
    CLOSE cur
    DEALLOCATE cur
END
*/

-- Заполнение таблицы Сотрудники
INSERT INTO Сотрудники (ID, Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол, ManagerHierarchy)
VALUES (1, 'Иван', 'Иванов', 2, 'Женат', 3, 'Мужской', hierarchyid::GetRoot()),
       (2, 'Мария', 'Петрова', 3, 'Не замужем', 2, 'Женский', '/1/'),
       (3, 'Алексей', 'Кравченко', 3, 'Холост', 2, 'Мужской', '/2/'),
       (4, 'Дмитрий', 'Гайков', 3, 'Женат', 2, 'Мужской', '/2/2/');
delete from Сотрудники where ID<5;

-- Заполнение таблицы Образование
INSERT INTO Образование (ID, Уровень, Специальность, Учебное_заведение)
VALUES (2, 'Высшее', 'Информационные технологии', 'МГУ'),
       (3, 'Среднее специальное', 'Бухгалтерия', 'Минский колледж');
delete from Образование where ID<4;

-- Заполнение таблицы Страховой_полюс
INSERT INTO Страховой_полюс (ID, Номер_полюса, Страховая_компания)
VALUES (2, '1234567890', 'Росгосстрах'),
       (3, '0987654321', 'Согаз');
delete from Страховой_полюс where ID<4;

-- Добавление подчиненного узла
DECLARE @manager hierarchyid, @subordinateId int
SELECT @manager = ManagerHierarchy FROM Сотрудники WHERE ID = 1
SET @subordinateId = 3
EXEC dbo.AddSubordinate @manager, @subordinateId

--вывод сотрудников
DECLARE @manager hierarchyid
SELECT @manager = ManagerHierarchy FROM Сотрудники WHERE ID = 1
EXEC dbo.GetSubordinates @manager

-- Перемещение всех подчиненных
EXEC dbo.MoveSubordinates 1,4
