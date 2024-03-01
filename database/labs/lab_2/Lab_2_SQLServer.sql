use BD_Lab_2;

CREATE TABLE Сотрудники (
    ID INT PRIMARY KEY,
    Имя NVARCHAR(100),
    Фамилия NVARCHAR(100),
    Образование_ID INT,
    Семейное_положение NVARCHAR(100),
    Страховой_полюс_ID INT,
    Пол NVARCHAR(10),
    FOREIGN KEY (Образование_ID) REFERENCES Образование(ID),
    FOREIGN KEY (Страховой_полюс_ID) REFERENCES Страховой_полюс(ID)
);

CREATE TABLE Образование (
    ID INT PRIMARY KEY,
    Уровень NVARCHAR(100),
    Специальность NVARCHAR(100),
    Учебное_заведение NVARCHAR(100)
);

CREATE TABLE Страховой_полюс (
    ID INT PRIMARY KEY,
    Номер_полюса NVARCHAR(50),
    Страховая_компания NVARCHAR(100)
);

CREATE TABLE Предыдущие_места_работы (
    ID INT PRIMARY KEY,
    Сотрудник_ID INT,
    Место_работы NVARCHAR(100),
    Должность NVARCHAR(100),
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Льготы (
    ID INT PRIMARY KEY,
    Сотрудник_ID INT,
    Льгота NVARCHAR(100),
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Справки (
    ID INT PRIMARY KEY,
    Сотрудник_ID INT,
    Состояние_здоровья NVARCHAR(100),
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Отпуска (
    ID INT PRIMARY KEY,
    Сотрудник_ID INT,
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Командировки (
    ID INT PRIMARY KEY,
    Сотрудник_ID INT,
    Место NVARCHAR(100),
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Больничные (
    ID INT PRIMARY KEY,
    Сотрудник_ID INT,
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Поощрения_и_наказания (
    ID INT PRIMARY KEY,
    Сотрудник_ID INT,
    Тип NVARCHAR(100),
    Описание NVARCHAR(100),
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Передвижения_по_должностям (
    ID INT PRIMARY KEY,
    Сотрудник_ID INT,
    Должность_ID INT,
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Должность_ID) REFERENCES Должности(ID),
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Передвижение_по_отделам (
    ID INT PRIMARY KEY,
    Сотрудник_ID INT,
    Отдел_ID INT,
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Отдел_ID) references Отделы(ID),
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Повышение_квалификации (
    ID INT PRIMARY KEY,
    Сотрудник_ID INT,
    Курс NVARCHAR(100),
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Должности (
    ID INT PRIMARY KEY,
    Название NVARCHAR(100),
    Описание NVARCHAR(100)
);

CREATE TABLE Отделы (
    ID INT PRIMARY KEY,
    Название NVARCHAR(100),
    Описание NVARCHAR(100)
);

CREATE TABLE Паспорт (
    ID INT PRIMARY KEY,
    сотрудник_ID INT,
    Серия NVARCHAR(50),
    Номер NVARCHAR(50),
    Кем_выдано NVARCHAR(100),
    Дата_выдачи DATE,
    FOREIGN KEY (сотрудник_ID) REFERENCES Сотрудники(ID)
);

/* Indexes, sequences, views */
-- Для таблицы Сотрудники
CREATE INDEX idx_Сотрудники_Имя ON Сотрудники (Имя);
CREATE VIEW v_Сотрудники AS SELECT ID, Имя, Фамилия FROM Сотрудники;
CREATE SEQUENCE seq_Сотрудники START WITH 1 INCREMENT BY 1;

-- Для таблицы Образование
CREATE INDEX idx_Образование_Уровень ON Образование (Уровень);
CREATE VIEW v_Образование AS SELECT ID, Уровень, Специальность FROM Образование;
CREATE SEQUENCE seq_Образование START WITH 1 INCREMENT BY 1;

-- Для таблицы Страховой_полюс
CREATE INDEX idx_Страховой_полюс_Номер_полюса ON Страховой_полюс (Номер_полюса);
CREATE VIEW v_Страховой_полюс AS SELECT ID, Номер_полюса, Страховая_компания FROM Страховой_полюс;
CREATE SEQUENCE seq_Страховой_полюс START WITH 1 INCREMENT BY 1;

-- Для таблицы Предыдущие_места_работы
CREATE INDEX idx_Предыдущие_места_работы_Сотрудник_ID ON Предыдущие_места_работы (Сотрудник_ID);
CREATE VIEW v_Предыдущие_места_работы AS SELECT ID, Сотрудник_ID, Место_работы, Должность FROM Предыдущие_места_работы;
CREATE SEQUENCE seq_Предыдущие_места_работы START WITH 1 INCREMENT BY 1;

-- Для таблицы Льготы
CREATE INDEX idx_Льготы_Сотрудник_ID ON Льготы (Сотрудник_ID);
CREATE VIEW v_Льготы AS SELECT ID, Сотрудник_ID, Льгота FROM Льготы;
CREATE SEQUENCE seq_Льготы START WITH 1 INCREMENT BY 1;

-- Для таблицы Справки
CREATE INDEX idx_Справки_Сотрудник_ID ON Справки (Сотрудник_ID);
CREATE VIEW v_Справки AS SELECT ID, Сотрудник_ID, Состояние_здоровья FROM Справки;
CREATE SEQUENCE seq_Справки START WITH 1 INCREMENT BY 1;

-- Для таблицы Отпуска
CREATE INDEX idx_Отпуска_Сотрудник_ID ON Отпуска (Сотрудник_ID);
CREATE VIEW v_Отпуска AS SELECT ID, Сотрудник_ID, Дата_начала, Дата_окончания FROM Отпуска;
CREATE SEQUENCE seq_Отпуска START WITH 1 INCREMENT BY 1;

-- Для таблицы Командировки
CREATE INDEX idx_Командировки_Сотрудник_ID ON Командировки (Сотрудник_ID);
CREATE VIEW v_Командировки AS SELECT ID, Сотрудник_ID, Место, Дата_начала, Дата_окончания FROM Командировки;
CREATE SEQUENCE seq_Командировки START WITH 1 INCREMENT BY 1;

-- Для таблицы Больничные
CREATE INDEX idx_Больничные_Сотрудник_ID ON Больничные (Сотрудник_ID);
CREATE VIEW v_Больничные AS SELECT ID, Сотрудник_ID, Дата_начала, Дата_окончания FROM Больничные;
CREATE SEQUENCE seq_Больничные START WITH 1 INCREMENT BY 1;

-- Для таблицы Поощрения_и_наказания
CREATE INDEX idx_Поощрения_и_наказания_Сотрудник_ID ON Поощрения_и_наказания (Сотрудник_ID);
CREATE VIEW v_Поощрения_и_наказания AS SELECT ID, Сотрудник_ID, Тип, Описание FROM Поощрения_и_наказания;
CREATE SEQUENCE seq_Поощрения_и_наказания START WITH 1 INCREMENT BY 1;

-- Для таблицы Передвижения_по_должностям
CREATE INDEX idx_Передвижения_по_должностям_Сотрудник_ID ON Передвижения_по_должностям (Сотрудник_ID);
CREATE VIEW v_Передвижения_по_должностям AS SELECT ID, Сотрудник_ID, Должность_ID, Дата_начала, Дата_окончания FROM Передвижения_по_должностям;
CREATE SEQUENCE seq_Передвижения_по_должностям START WITH 1 INCREMENT BY 1;

-- Для таблицы Передвижение_по_отделам
CREATE INDEX idx_Передвижение_по_отделам_Сотрудник_ID ON Передвижение_по_отделам (Сотрудник_ID);
CREATE VIEW v_Передвижение_по_отделам AS SELECT ID, Сотрудник_ID, Отдел_ID, Дата_начала, Дата_окончания FROM Передвижение_по_отделам;
CREATE SEQUENCE seq_Передвижение_по_отделам START WITH 1 INCREMENT BY 1;

-- Для таблицы Повышение_квалификации
CREATE INDEX idx_Повышение_квалификации_Сотрудник_ID ON Повышение_квалификации (Сотрудник_ID);
CREATE VIEW v_Повышение_квалификации AS SELECT ID, Сотрудник_ID, Курс, Дата_начала, Дата_окончания FROM Повышение_квалификации;
CREATE SEQUENCE seq_Повышение_квалификации START WITH 1 INCREMENT BY 1;

-- Для таблицы Должности
CREATE INDEX idx_Должности_Название ON Должности (Название);
CREATE VIEW v_Должности AS SELECT ID, Название, Описание FROM Должности;
CREATE SEQUENCE seq_Должности START WITH 1 INCREMENT BY 1;

-- Для таблицы Отделы
CREATE INDEX idx_Отделы_Название ON Отделы (Название);
CREATE VIEW v_Отделы AS SELECT ID, Название, Описание FROM Отделы;
CREATE SEQUENCE seq_Отделы START WITH 1 INCREMENT BY 1;

-- Для таблицы Паспорт
CREATE INDEX idx_Паспорт_сотрудник_ID ON Паспорт (сотрудник_ID);
CREATE VIEW v_Паспорт AS SELECT ID, сотрудник_ID, Серия, Номер, Кем_выдано, Дата_выдачи FROM Паспорт;
CREATE SEQUENCE seq_Паспорт START WITH 1 INCREMENT BY 1;

/* Functions and procedures*/

-- Функция для добавления нового сотрудника
CREATE PROCEDURE ДобавитьСотрудника
    @newID INT,
    @Имя NVARCHAR(100),
    @Фамилия NVARCHAR(100),
    @Образование_ID INT,
    @Семейное_положение NVARCHAR(100),
    @Страховой_полюс_ID INT,
    @Пол NVARCHAR(10)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Сотрудники WHERE Имя = @Имя AND Фамилия = @Фамилия)
    BEGIN
        INSERT INTO Сотрудники (ID, Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол)
        VALUES (@newID, @Имя, @Фамилия, @Образование_ID, @Семейное_положение, @Страховой_полюс_ID, @Пол);
    END
    ELSE
    BEGIN
        PRINT 'Сотрудник с таким именем и фамилией уже существует.';
    END
END;

-- Процедура для удаления сотрудника
CREATE PROCEDURE УдалитьСотрудника
    @ID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Сотрудники WHERE ID = @ID)
    BEGIN
        DELETE FROM Предыдущие_места_работы WHERE Сотрудник_ID = @ID;
        DELETE FROM Льготы WHERE Сотрудник_ID = @ID;
        DELETE FROM Справки WHERE Сотрудник_ID = @ID;
        DELETE FROM Отпуска WHERE Сотрудник_ID = @ID;
        DELETE FROM Командировки WHERE Сотрудник_ID = @ID;
        DELETE FROM Больничные WHERE Сотрудник_ID = @ID;
        DELETE FROM Поощрения_и_наказания WHERE Сотрудник_ID = @ID;
        DELETE FROM Передвижения_по_должностям WHERE Сотрудник_ID = @ID;
        DELETE FROM Передвижение_по_отделам WHERE Сотрудник_ID = @ID;
        DELETE FROM Повышение_квалификации WHERE Сотрудник_ID = @ID;
        DELETE FROM Паспорт WHERE сотрудник_ID = @ID;
        DELETE FROM Сотрудники WHERE ID = @ID;
    END
    ELSE
    BEGIN
        PRINT 'Сотрудник с таким ID не существует.';
    END
END;

-- Функция для получения количества сотрудников с определенным образованием
CREATE FUNCTION Количество_Сотрудников_с_Образованием (@Образование_ID INT)
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(*) FROM Сотрудники WHERE Образование_ID = @Образование_ID);
END;
GO


-- Процедура для обновления сотрудника
CREATE PROCEDURE ОбновитьСотрудника
    @ID INT,
    @НовоеИмя NVARCHAR(100),
    @НоваяФамилия NVARCHAR(100),
    @НовоеОбразование_ID INT,
    @НовоеСемейное_положение NVARCHAR(100),
    @НовыйСтраховой_полюс_ID INT,
    @НовыйПол NVARCHAR(10)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Сотрудники WHERE ID = @ID)
    BEGIN
        UPDATE Сотрудники
        SET Имя = @НовоеИмя,
            Фамилия = @НоваяФамилия,
            Образование_ID = @НовоеОбразование_ID,
            Семейное_положение = @НовоеСемейное_положение,
            Страховой_полюс_ID = @НовыйСтраховой_полюс_ID,
            Пол = @НовыйПол
        WHERE ID = @ID;
    END
    ELSE
    BEGIN
        PRINT 'Сотрудник с таким ID не существует.';
    END
END;
GO

-- Представления
CREATE VIEW Сотрудники_Образование AS
SELECT С.Имя, С.Фамилия, О.Уровень, О.Специальность, О.Учебное_заведение
FROM Сотрудники С
JOIN Образование О ON С.Образование_ID = О.ID;

CREATE VIEW Сотрудники_Страховой_полюс AS
SELECT С.Имя, С.Фамилия, П.Номер_полюса, П.Страховая_компания
FROM Сотрудники С
JOIN Страховой_полюс П ON С.Страховой_полюс_ID = П.ID;

-- Триггер
CREATE TRIGGER Триггер_Проверка_Отдела
ON Отделы
AFTER INSERT
AS
BEGIN
    DECLARE @Количество_Сотрудников INT;
    SELECT @Количество_Сотрудников = COUNT(*) FROM Передвижение_по_отделам по WHERE по.Отдел_ID = (SELECT ID FROM inserted);

    IF @Количество_Сотрудников >= 100
    BEGIN
        THROW 51000, 'В одном отделе не может быть более 100 сотрудников.', 1;
    END
END;
GO

insert into СТРАХОВОЙ_ПОЛЮС(id, номер_полюса, страховая_компания)
values (1, '54545', 'Belgosstrakh');

insert into ОБРАЗОВАНИЕ(ID, УРОВЕНЬ, СПЕЦИАЛЬНОСТЬ, УЧЕБНОЕ_ЗАВЕДЕНИЕ)
values (1, 'Высшее', 'ИТ', 'БГТУ');

-- Вызов процедуры ДобавитьСотрудника
EXEC ДобавитьСотрудника @newID = 1, @Имя = N'Иван', @Фамилия = N'Иванов', @Образование_ID = 1, @Семейное_положение = N'Женат', @Страховой_полюс_ID = 1, @Пол = N'М';

-- Вызов процедуры УдалитьСотрудника
EXEC УдалитьСотрудника @ID = 1;

-- Вызов функции Количество_Сотрудников_с_Образованием
DECLARE @Образование_ID INT;
DECLARE @Количество INT;
SET @Образование_ID = 1;
SET @Количество = dbo.Количество_Сотрудников_с_Образованием(@Образование_ID);
PRINT @Количество;

-- Вызов процедуры ОбновитьСотрудника
EXEC ОбновитьСотрудника @ID = 1, @НовоеИмя = N'Петр', @НоваяФамилия = N'Петров', @НовоеОбразование_ID = 1, @НовоеСемейное_положение = N'Не женат', @НовыйСтраховой_полюс_ID = 1, @НовыйПол = N'М';

select *
from Сотрудники_Образование;


