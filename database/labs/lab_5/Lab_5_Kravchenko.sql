--Заполнение данными

-- Заполнение таблицы Предыдущие_места_работы
INSERT INTO Предыдущие_места_работы (ID, Сотрудник_ID, Место_работы, Должность)
VALUES (1, 1, 'ООО "БелДорСтрой"', 'Менеджер'),
       (2, 2, 'ООО "Рога и копыта"', 'Лесник'),
       (3, 3, 'ООО "Медведь и лиса"', 'Помощник егеря'),
       (4, 3, 'ООО "Смачны падарунак"', 'Программист'),
       (5, 4, 'ООО "Делай добро"', 'Бухгалтер');

-- Заполнение таблицы Льготы
INSERT INTO Льготы (ID, Сотрудник_ID, Льгота)
VALUES (1, 1, 'Льготное проездное'),
       (2, 2, 'Льготное лечение'),
       (3, 4, 'Льготное проездное');

-- Заполнение таблицы Справки
INSERT INTO Справки (ID, Сотрудник_ID, Состояние_здоровья)
VALUES (1, 1, 'Здоров'),
       (2, 2, 'Здоров'),
       (3, 3, 'Здоров'),
       (4, 4, 'Здоров');

-- Заполнение таблицы Отпуска
INSERT INTO Отпуска (ID, Сотрудник_ID, Вид_отпуска, Дата_начала, Дата_окончания)
VALUES (1, 1, 'Ежегодный', '2023-07-01', '2023-07-31'),
       (2, 1, 'Ежегодный', '2023-06-06', '2023-07-06'),
       (3, 2, 'Дополнительный', '2023-07-01', '2023-07-31'),
       (4, 2, 'Ежегодный', '2023-02-02', '2023-03-02'),
       (5, 3, 'Дополнительный', '2023-07-01', '2023-07-10'),
       (6, 4, 'Дополнительный', '2023-06-05', '2023-06-22'),
       (7, 4, 'Ежегодный', '2023-08-01', '2023-08-31');

-- Заполнение таблицы Зарплаты
DECLARE @i INT = 1;
DECLARE @month INT = 1;
DECLARE @year INT = 2023;
DECLARE @employee INT = 1;

WHILE @i <= 48
BEGIN
    -- Добавляем некоторую случайность в зарплату
    DECLARE @random FLOAT = RAND() * 10000; -- Генерируем случайное число от 0 до 10000
    DECLARE @salary DECIMAL(10, 2) = 50000 + (@employee - 1) * 10000 + @random; -- Добавляем случайное число к зарплате

    INSERT INTO Зарплаты (ID, Сотрудник_ID, Зарплата, Дата)
    VALUES (@i, @employee, @salary, DATEFROMPARTS(@year, @month, 1));

    SET @employee = @employee + 1;
    IF @employee > 4
    BEGIN
        SET @employee = 1;
        SET @month = @month + 1;
    END

    IF @month > 12
    BEGIN
        SET @month = 1;
        SET @year = @year + 1;
    END

    SET @i = @i + 1;
END;


-- Заполнение таблицы Командировки
INSERT INTO Командировки (ID, Сотрудник_ID, Место, Дата_начала, Дата_окончания)
VALUES (1, 1, 'Новая Зеландия', '2023-02-01', '2023-02-07'),
       (2, 1, 'Франция', '2023-04-01', '2023-04-07'),
       (3, 2, 'Лесхоз "Дружба"', '2023-11-01', '2023-11-07'),
       (4, 3, 'Англия', '2023-01-11', '2023-01-17'),
       (5, 4, 'Украина', '2023-03-01', '2023-03-07');

-- Заполнение таблицы Больничные
INSERT INTO Больничные (ID, Сотрудник_ID, Дата_начала, Дата_окончания)
VALUES (1, 1, '2023-04-01', '2023-04-07'),
       (2, 2, '2023-05-01', '2023-05-07');

-- Заполнение таблицы Поощрения_и_наказания
INSERT INTO Поощрения_и_наказания (ID, Сотрудник_ID, Тип, Описание)
VALUES (1, 1, 'Поощрение', 'Отличная работа'),
       (2, 2, 'Наказание', 'Несоблюдение рабочего графика');


-- Заполнение таблицы Должности
INSERT INTO Должности (ID, Название, Описание)
VALUES (1, 'Менеджер', 'Управление проектами и командой'),
       (2, 'Бухгалтер', 'Учет финансов и бюджета'),
       (3, 'Аналитик', 'Анализ данных и составление отчетов'),
       (4, 'Программист', 'Разработка и тестирование программного обеспечения'),
       (5, 'Администратор баз данных', 'Управление и обслуживание баз данных');

-- Заполнение таблицы Отделы
INSERT INTO Отделы (ID, Название, Описание)
VALUES (1, 'Отдел продаж', 'Продажа продуктов и услуг компании'),
       (2, 'Отдел маркетинга', 'Продвижение продуктов и услуг компании'),
       (3, 'Отдел разработки', 'Разработка программного обеспечения'),
       (4, 'Отдел поддержки', 'Поддержка клиентов и решение технических проблем'),
       (5, 'Отдел управления проектами', 'Планирование и управление проектами');

-- Заполнение таблицы Передвижения_по_должностям
INSERT INTO Передвижения_по_должностям (ID, Сотрудник_ID, Должность_ID, Дата_начала, Дата_окончания)
VALUES (1, 1, 2, '2023-06-01', '2023-07-01'),
       (2, 1, 3, '2023-07-02', NULL),
       (3, 2, 1, '2023-04-01', NULL),
       (4, 3, 4, '2023-01-01', '2023-12-01'),
       (5, 3, 5, '2023-12-01', NULL),
       (6, 4, 2, '2023-11-01', NULL);

INSERT INTO Передвижение_по_отделам (ID, Сотрудник_ID, Отдел_ID, Дата_начала, Дата_окончания)
VALUES (1, 1, 1, '2023-01-01', '2023-02-01'),
       (2, 1, 1, '2023-02-02', NULL),
       (3, 2, 1, '2023-03-01', '2023-11-01'),
       (4, 2, 1, '2023-11-02', NULL),
       (5, 3, 1, '2023-05-01', NULL),
       (6, 4, 1, '2023-06-01', '2023-10-01'),
       (7, 4, 2, '2023-10-02', NULL);

-- Заполнение таблицы Повышение_квалификации
INSERT INTO Повышение_квалификации (ID, Сотрудник_ID, Курс, Дата_начала, Дата_окончания)
VALUES (1, 1, 'Курс повышения квалификации', '2023-06-01', '2023-06-30'),
       (2, 2, 'Курс повышения квалификации', '2023-07-01', '2023-07-31');

-- Заполнение таблицы Паспорт
INSERT INTO Паспорт (ID, сотрудник_ID, Серия, Номер, Кем_выдано, Дата_выдачи)
VALUES (1, 1, 'MP', '993456', 'МВД РБ', '2010-01-01'),
       (2, 2, 'MP', '123256', 'МВД РБ', '2013-01-01'),
       (3, 3, 'MP', '223456', 'МВД РБ', '2012-01-01'),
       (4, 4, 'MP', '654321', 'МВД РБ', '2011-01-01');

-- Вычисление итогов заработной платы
-- и численности помесячно, за квартал, за полгода, за год.

DECLARE @Сотрудник_ID INT = 2; -- Замените на ID сотрудника, для которого вы хотите получить данные

WITH ЗарплатыReport AS (
    SELECT
        Сотрудник_ID,
        DATEPART(YEAR, Дата) AS Год,
        DATEPART(MONTH, Дата) AS Месяц,
        CASE
            WHEN DATEPART(MONTH, Дата) <= 6 THEN 1
            ELSE 2
        END AS Полугодие,
        DATEPART(QUARTER, Дата) AS Квартал,
        SUM(Зарплата) OVER (PARTITION BY Сотрудник_ID, DATEPART(YEAR, Дата), DATEPART(MONTH, Дата)) AS Зарплата_за_месяц,
        SUM(Зарплата) OVER (PARTITION BY Сотрудник_ID, DATEPART(YEAR, Дата), DATEPART(QUARTER, Дата)) AS Зарплата_за_квартал,
        SUM(Зарплата) OVER (PARTITION BY Сотрудник_ID, DATEPART(YEAR, Дата), CASE WHEN DATEPART(MONTH, Дата) <= 6 THEN 1 ELSE 2 END) AS Зарплата_за_полугодие,
        SUM(Зарплата) OVER (PARTITION BY Сотрудник_ID, DATEPART(YEAR, Дата)) AS Зарплата_за_год
    FROM Зарплаты
    WHERE Сотрудник_ID = @Сотрудник_ID
)

SELECT
    Год,
    Месяц,
    Квартал,
    Полугодие,
    MAX(Зарплата_за_месяц) AS Зарплата_за_месяц,
    MAX(Зарплата_за_квартал) AS Зарплата_за_квартал,
    MAX(Зарплата_за_полугодие) AS Зарплата_за_полугодие,
    MAX(Зарплата_за_год) AS Зарплата_за_год
FROM ЗарплатыReport
GROUP BY Год, Месяц, Квартал, Полугодие
ORDER BY Год, Месяц, Квартал, Полугодие;

select *
from зарплаты;

/*
    Вычисление итогов заработной платы и численности за определенный период:
•	средняя заработная плата;
•	сравнение заработной платы с одинаковыми по рангу сотрудниками (в %);
•	сравнение заработной платы с сотрудниками этого же отдела (в %).
*/

DECLARE @Сотрудник_ID INT = 1; -- Замените на ID сотрудника, для которого вы хотите получить данные
DECLARE @Дата_начала DATE = '2023-01-01';
DECLARE @Дата_окончания DATE = '2023-12-31';

WITH СредняяЗарплата AS (
    SELECT avg(z.Зарплата) AS [Средняя]
    FROM Зарплаты z
    JOIN Передвижение_по_отделам p ON z.Сотрудник_ID = p.Сотрудник_ID
    WHERE z.Дата >= @Дата_начала AND z.Дата <= @Дата_окончания
),
СредняяЗарплатаПоРангу AS (
    SELECT p.Должность_ID, avg(z.Зарплата) AS [CредняяЗарплатаПоРангу]
    FROM Зарплаты z
    JOIN Передвижения_по_должностям p ON p.Сотрудник_ID = z.Сотрудник_ID
    WHERE p.Сотрудник_ID = @Сотрудник_ID
    GROUP BY p.Должность_ID
),

СредняяЗарплатаПоОтделу AS (
    SELECT p.Отдел_ID, avg(z.Зарплата) AS [CредняяЗарплатаПоОтделу]
    FROM Зарплаты z
    JOIN Передвижение_по_отделам p ON p.Сотрудник_ID = z.Сотрудник_ID
    WHERE p.Сотрудник_ID = @Сотрудник_ID
    GROUP BY p.Отдел_ID
),

ЗарплатыReport AS (
    SELECT s.Имя,
           COUNT(*) AS [Количество]
    FROM Зарплаты z
    JOIN Сотрудники s ON z.Сотрудник_ID = s.ID
    JOIN Передвижение_по_отделам p ON z.Сотрудник_ID = p.Сотрудник_ID
    WHERE z.Сотрудник_ID = @Сотрудник_ID AND z.Дата >= @Дата_начала AND z.Дата <= @Дата_окончания
    GROUP BY s.Имя
)
SELECT [Имя],
       (SELECT * FROM СредняяЗарплата) [Средняя зарплата],
       (SELECT Top(1)[CредняяЗарплатаПоРангу] FROM СредняяЗарплатаПоРангу) [СредняяЗарплатаПоРангу],
       (SELECT Top(1)[CредняяЗарплатаПоОтделу] FROM  СредняяЗарплатаПоОтделу) [CредняяЗарплатаПоОтделу]
FROM ЗарплатыReport;

/*
 5.	Продемонстрируйте применение функции ранжирования ROW_NUMBER()
 для разбиения результатов запроса на страницы (по 20 строк на каждую страницу).
*/

DECLARE @PageNumber AS INT = 1; -- Укажите номер страницы, которую вы хотите получить
DECLARE @RowsPerPage AS INT = 20; -- Количество строк на страницу

WITH SalaryPagination AS
(
    SELECT
        ROW_NUMBER() OVER (ORDER BY Зарплата DESC) AS RowNum,
        ID,
        Сотрудник_ID,
        Зарплата,
        Дата
    FROM
        Зарплаты
)
SELECT
    ID,
    Сотрудник_ID,
    Зарплата,
    Дата
FROM
    SalaryPagination
WHERE
    RowNum BETWEEN ((@PageNumber - 1) * @RowsPerPage + 1) AND (@PageNumber * @RowsPerPage)
ORDER BY
    RowNum;

/*
6.	Продемонстрируйте применение функции ранжирования ROW_NUMBER() для удаления дубликатов.
*/

WITH DuplicateRanks AS
(
    SELECT
        ROW_NUMBER() OVER (PARTITION BY Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол ORDER BY ID) AS RowNum,
        ID
    FROM
        Сотрудники
)
DELETE FROM Сотрудники WHERE ID IN (SELECT ID FROM DuplicateRanks WHERE RowNum > 1);

/*
Вернуть для каждого отдела суммы зарплат сотрудников за последние 6 месяцев помесячно.
*/

WITH MonthlySalaries AS
(
    SELECT
        P.Отдел_ID,
        YEAR(Z.Дата) AS Year,
        MONTH(Z.Дата) AS Month,
        SUM(Z.Зарплата) AS TotalSalary
    FROM
        Зарплаты Z
    JOIN
        Сотрудники S ON Z.Сотрудник_ID = S.ID
    JOIN
        Передвижение_по_отделам P ON S.ID = P.Сотрудник_ID
    WHERE
        Z.Дата BETWEEN '2023-01-01' AND '2023-06-01'
    GROUP BY
        P.Отдел_ID, YEAR(Z.Дата), MONTH(Z.Дата)
)
SELECT
    Отдел_ID,
    Year,
    Month,
    SUM(TotalSalary) OVER (PARTITION BY Отдел_ID ORDER BY Year, Month) AS CumulativeSalary
FROM
    MonthlySalaries
ORDER BY
    Отдел_ID, Year, Month;

/*
Какой сотрудник получил наибольшее число отпусков определенного вида?
Вернуть для всех видов.
*/
WITH VacationCounts AS
(
    SELECT
        O.Сотрудник_ID,
        O.Вид_отпуска,
        COUNT(*) AS Количество_отпусков,
        ROW_NUMBER() OVER (PARTITION BY O.Вид_отпуска ORDER BY COUNT(*) DESC) AS Rank
    FROM
        Отпуска O
    GROUP BY
        O.Сотрудник_ID, O.Вид_отпуска
)
SELECT
    VC.Вид_отпуска,
    S.Имя,
    S.Фамилия,
    VC.Количество_отпусков
FROM
    VacationCounts VC
JOIN
    Сотрудники S ON VC.Сотрудник_ID = S.ID
WHERE
    VC.Rank = 1;
