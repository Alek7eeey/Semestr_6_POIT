CREATE TABLE Сотрудники (
    ID NUMBER PRIMARY KEY,
    Имя NVARCHAR2(100),
    Фамилия NVARCHAR2(100),
    Образование_ID NUMBER,
    Семейное_положение NVARCHAR2(100),
    Страховой_полюс_ID NUMBER,
    Пол NVARCHAR2(10)
);

CREATE TABLE Образование (
    ID NUMBER PRIMARY KEY,
    Уровень NVARCHAR2(100),
    Специальность NVARCHAR2(100),
    Учебное_заведение NVARCHAR2(100)
);

CREATE TABLE Страховой_полюс (
    ID NUMBER PRIMARY KEY,
    Номер_полюса NVARCHAR2(50),
    Страховая_компания NVARCHAR2(100)
);

CREATE TABLE Предыдущие_места_работы (
    ID NUMBER PRIMARY KEY,
    Сотрудник_ID NUMBER,
    Место_работы NVARCHAR2(100),
    Должность NVARCHAR2(100),
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Льготы (
    ID NUMBER PRIMARY KEY,
    Сотрудник_ID NUMBER,
    Льгота NVARCHAR2(100),
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Справки (
    ID NUMBER PRIMARY KEY,
    Сотрудник_ID NUMBER,
    Состояние_здоровья NVARCHAR2(100),
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Отпуска (
    ID NUMBER PRIMARY KEY,
    Сотрудник_ID NUMBER,
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Командировки (
    ID NUMBER PRIMARY KEY,
    Сотрудник_ID NUMBER,
    Место NVARCHAR2(100),
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Больничные (
    ID NUMBER PRIMARY KEY,
    Сотрудник_ID NUMBER,
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Поощрения_и_наказания (
    ID NUMBER PRIMARY KEY,
    Сотрудник_ID NUMBER,
    Тип NVARCHAR2(100),
    Описание NVARCHAR2(100),
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Передвижения_по_должностям (
    ID NUMBER PRIMARY KEY,
    Сотрудник_ID NUMBER,
    Должность NVARCHAR2(100),
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Передвижение_по_отделам (
    ID NUMBER PRIMARY KEY,
    Сотрудник_ID NUMBER,
    Отдел NVARCHAR2(100),
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Повышение_квалификации (
    ID NUMBER PRIMARY KEY,
    Сотрудник_ID NUMBER,
    Курс NVARCHAR2(100),
    Дата_начала DATE,
    Дата_окончания DATE,
    FOREIGN KEY (Сотрудник_ID) REFERENCES Сотрудники(ID)
);

CREATE TABLE Должности (
    ID NUMBER PRIMARY KEY,
    Название NVARCHAR2(100),
    Описание NVARCHAR2(100)
);

CREATE TABLE Отделы (
    ID NUMBER PRIMARY KEY,
    Название NVARCHAR2(100),
    Описание NVARCHAR2(100)
);

CREATE TABLE Паспорт (
    ID NUMBER PRIMARY KEY,
    сотрудник_ID NUMBER,
    Серия NVARCHAR2(50),
    Номер NVARCHAR2(50),
    Кем_выдано NVARCHAR2(100),
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
CREATE VIEW v_Передвижения_по_должностям AS SELECT ID, Сотрудник_ID, Должность, Дата_начала, Дата_окончания FROM Передвижения_по_должностям;
CREATE SEQUENCE seq_Передвижения_по_должностям START WITH 1 INCREMENT BY 1;

-- Для таблицы Передвижение_по_отделам
CREATE INDEX idx_Передвижение_по_отделам_Сотрудник_ID ON Передвижение_по_отделам (Сотрудник_ID);
CREATE VIEW v_Передвижение_по_отделам AS SELECT ID, Сотрудник_ID, Отдел, Дата_начала, Дата_окончания FROM Передвижение_по_отделам;
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
-- Процедура для добавления нового сотрудника
CREATE OR REPLACE PROCEDURE ДобавитьСотрудника (
    Имя IN NVARCHAR2,
    Фамилия IN NVARCHAR2,
    Образование_ID IN NUMBER,
    Семейное_положение IN NVARCHAR2,
    Страховой_полюс_ID IN NUMBER,
    Пол IN NVARCHAR2
) AS
BEGIN
    INSERT INTO Сотрудники (Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол)
    VALUES (Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол);
END;
/

-- Процедура для удаления сотрудника
CREATE OR REPLACE PROCEDURE УдалитьСотрудника (
    ID IN NUMBER
) AS
BEGIN
    DELETE FROM Сотрудники WHERE ID = ID;
END;
/

-- Функция для получения количества сотрудников с определенным образованием
CREATE OR REPLACE FUNCTION Количество_Сотрудников_с_Образованием (
    Образование_ID IN NUMBER
) RETURN NUMBER IS
    Количество NUMBER;
BEGIN
    SELECT COUNT(*) INTO Количество FROM Сотрудники WHERE Образование_ID = Образование_ID;
    RETURN Количество;
END;
/