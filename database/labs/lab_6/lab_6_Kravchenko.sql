--заполнение данными необходимых таблиц

--сотрудники
INSERT INTO Сотрудники (ID, Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол)
VALUES (1, 'Иван', 'Иванов', 2, 'Женат', 2, 'М');

INSERT INTO Сотрудники (ID, Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол)
VALUES (2, 'Петр', 'Петров', 3, 'Не женат', 3, 'М');

INSERT INTO Сотрудники (ID, Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол)
VALUES (3, 'Мария', 'Мариева', 2, 'Не замужем', 2, 'Ж');

INSERT INTO Сотрудники (ID, Имя, Фамилия, Образование_ID, Семейное_положение, Страховой_полюс_ID, Пол)
VALUES (4, 'Анна', 'Аннова', 3, 'Замужем', 3, 'Ж');
select *
from СОТРУДНИКИ;
--отпуска
INSERT INTO Отпуска (ID, Сотрудник_ID, Вид_отпуска, Дата_начала, Дата_окончания)
VALUES (1, 1, 'Ежегодный', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-07-31', 'YYYY-MM-DD'));

INSERT INTO Отпуска (ID, Сотрудник_ID, Вид_отпуска, Дата_начала, Дата_окончания)
VALUES (2, 1, 'Ежегодный', TO_DATE('2023-06-06', 'YYYY-MM-DD'), TO_DATE('2023-07-06', 'YYYY-MM-DD'));

INSERT INTO Отпуска (ID, Сотрудник_ID, Вид_отпуска, Дата_начала, Дата_окончания)
VALUES (3, 2, 'Дополнительный', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-07-31', 'YYYY-MM-DD'));

INSERT INTO Отпуска (ID, Сотрудник_ID, Вид_отпуска, Дата_начала, Дата_окончания)
VALUES (4, 2, 'Ежегодный', TO_DATE('2023-02-02', 'YYYY-MM-DD'), TO_DATE('2023-03-02', 'YYYY-MM-DD'));

INSERT INTO Отпуска (ID, Сотрудник_ID, Вид_отпуска, Дата_начала, Дата_окончания)
VALUES (5, 3, 'Дополнительный', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-07-10', 'YYYY-MM-DD'));

INSERT INTO Отпуска (ID, Сотрудник_ID, Вид_отпуска, Дата_начала, Дата_окончания)
VALUES (6, 4, 'Дополнительный', TO_DATE('2023-06-05', 'YYYY-MM-DD'), TO_DATE('2023-06-22', 'YYYY-MM-DD'));

INSERT INTO Отпуска (ID, Сотрудник_ID, Вид_отпуска, Дата_начала, Дата_окончания)
VALUES (7, 4, 'Ежегодный', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-31', 'YYYY-MM-DD'));

select *
from ОТПУСКА;

-- Заполнение таблицы Зарплаты
DECLARE
    i INT := 1;
    month INT := 1;
    year INT := 2023;
    employee INT := 1;
    random FLOAT;
    salary DECIMAL;
BEGIN
    WHILE i <= 48 LOOP
        -- Добавляем некоторую случайность в зарплату
        random := DBMS_RANDOM.VALUE(0, 10000); -- Генерируем случайное число от 0 до 10000
        salary := 50000 + (employee - 1) * 10000 + random; -- Добавляем случайное число к зарплате

        INSERT INTO Зарплаты (ID, Сотрудник_ID, Зарплата, Дата)
        VALUES (i, employee, salary, TO_DATE(year || '-' || month || '-01', 'YYYY-MM-DD'));

        employee := employee + 1;
        IF employee > 4 THEN
            employee := 1;
            month := month + 1;
        END IF;

        IF month > 12 THEN
            month := 1;
            year := year + 1;
        END IF;

        i := i + 1;
    END LOOP;
END;
select *
from ЗАРПЛАТЫ;

--заполнение таблицы Должности
INSERT INTO Должности (ID, Название, Описание)
VALUES (1, 'Менеджер', 'Управление проектами и командой');

INSERT INTO Должности (ID, Название, Описание)
VALUES (2, 'Бухгалтер', 'Учет финансов и бюджета');

INSERT INTO Должности (ID, Название, Описание)
VALUES (3, 'Аналитик', 'Анализ данных и составление отчетов');

INSERT INTO Должности (ID, Название, Описание)
VALUES (4, 'Программист', 'Разработка и тестирование программного обеспечения');

INSERT INTO Должности (ID, Название, Описание)
VALUES (5, 'Администратор баз данных', 'Управление и обслуживание баз данных');

select *
from ДОЛЖНОСТИ;

-- Заполнение таблицы Отделы
INSERT INTO Отделы (ID, Название, Описание)
VALUES (1, 'Отдел продаж', 'Продажа продуктов и услуг компании');

INSERT INTO Отделы (ID, Название, Описание)
VALUES (2, 'Отдел маркетинга', 'Продвижение продуктов и услуг компании');

INSERT INTO Отделы (ID, Название, Описание)
VALUES (3, 'Отдел разработки', 'Разработка программного обеспечения');

INSERT INTO Отделы (ID, Название, Описание)
VALUES (4, 'Отдел поддержки', 'Поддержка клиентов и решение технических проблем');

INSERT INTO Отделы (ID, Название, Описание)
VALUES (5, 'Отдел управления проектами', 'Планирование и управление проектами');

select *
from ОТДЕЛЫ;

-- Заполнение таблицы Передвижения_по_должностям

INSERT INTO Передвижения_по_должностям (ID, Сотрудник_ID, Должность_ID, Дата_начала, Дата_окончания)
VALUES (1, 1, 3, TO_DATE('2023-07-02', 'YYYY-MM-DD'), NULL);

INSERT INTO Передвижения_по_должностям (ID, Сотрудник_ID, Должность_ID, Дата_начала, Дата_окончания)
VALUES (2, 2, 1, TO_DATE('2023-04-01', 'YYYY-MM-DD'), NULL);

INSERT INTO Передвижения_по_должностям (ID, Сотрудник_ID, Должность_ID, Дата_начала, Дата_окончания)
VALUES (3, 3, 5, TO_DATE('2023-12-01', 'YYYY-MM-DD'), NULL);

INSERT INTO Передвижения_по_должностям (ID, Сотрудник_ID, Должность_ID, Дата_начала, Дата_окончания)
VALUES (4, 4, 2, TO_DATE('2023-11-01', 'YYYY-MM-DD'), NULL);

select *
from ПЕРЕДВИЖЕНИЯ_ПО_ДОЛЖНОСТЯМ;

-- Заполнение таблицы Передвижение_по_отделам
INSERT INTO Передвижение_по_отделам (ID, Сотрудник_ID, Отдел_ID, Дата_начала, Дата_окончания)
VALUES (1, 1, 1, TO_DATE('2023-02-02', 'YYYY-MM-DD'), NULL);

INSERT INTO Передвижение_по_отделам (ID, Сотрудник_ID, Отдел_ID, Дата_начала, Дата_окончания)
VALUES (2, 2, 1, TO_DATE('2023-11-02', 'YYYY-MM-DD'), NULL);

INSERT INTO Передвижение_по_отделам (ID, Сотрудник_ID, Отдел_ID, Дата_начала, Дата_окончания)
VALUES (3, 3, 1, TO_DATE('2023-05-01', 'YYYY-MM-DD'), NULL);

INSERT INTO Передвижение_по_отделам (ID, Сотрудник_ID, Отдел_ID, Дата_начала, Дата_окончания)
VALUES (4, 4, 2, TO_DATE('2023-10-02', 'YYYY-MM-DD'), NULL);

select *
from ПЕРЕДВИЖЕНИЕ_ПО_ОТДЕЛАМ;

-- Вычисление итогов заработной платы
-- и численности помесячно, за квартал, за полгода, за год.
WITH ЗарплатыReport AS (
    SELECT
        Сотрудник_ID,
        EXTRACT(YEAR FROM Дата) AS Год,
        EXTRACT(MONTH FROM Дата) AS Месяц,
        CASE
            WHEN EXTRACT(MONTH FROM Дата) <= 6 THEN 1
            ELSE 2
        END AS Полугодие,
        TO_NUMBER(TO_CHAR(Дата, 'Q')) AS Квартал,
        SUM(Зарплата) OVER (PARTITION BY Сотрудник_ID, EXTRACT(YEAR FROM Дата), EXTRACT(MONTH FROM Дата)) AS Зарплата_за_месяц,
        SUM(Зарплата) OVER (PARTITION BY Сотрудник_ID, EXTRACT(YEAR FROM Дата), TO_NUMBER(TO_CHAR(Дата, 'Q'))) AS Зарплата_за_квартал,
        SUM(Зарплата) OVER (PARTITION BY Сотрудник_ID, EXTRACT(YEAR FROM Дата), CASE WHEN EXTRACT(MONTH FROM Дата) <= 6 THEN 1 ELSE 2 END) AS Зарплата_за_полугодие,
        SUM(Зарплата) OVER (PARTITION BY Сотрудник_ID, EXTRACT(YEAR FROM Дата)) AS Зарплата_за_год
    FROM Зарплаты
    WHERE Сотрудник_ID = 2
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

/*
Вычисление итогов заработной платы и численности за определенный период:
•	средняя заработная плата;
•	сравнение заработной платы с одинаковыми по рангу сотрудниками;
•	сравнение заработной платы с сотрудниками этого же отдела.
*/
/*WITH СредняяЗарплатаОбщая AS (
        SELECT ROUND(AVG(z.Зарплата), 2) AS СредняяОбщая
        FROM Зарплаты z
        WHERE z.Дата >= TO_DATE('2023-01-01', 'YYYY-MM-DD') AND z.Дата <= TO_DATE('2023-12-31', 'YYYY-MM-DD')
    ),
    СредняяЗарплатаСотрудника AS (
    SELECT ROUND(AVG(z.Зарплата), 2) AS СредняяСотрудника
    FROM Зарплаты z
    --Сотрудник_ID_current vvv (4)
    WHERE Z.СОТРУДНИК_ID = 4 AND z.Дата >= TO_DATE('2023-01-01', 'YYYY-MM-DD') AND z.Дата <= TO_DATE('2023-12-31', 'YYYY-MM-DD')
    ),
    ТекущаяДолжность AS (
    SELECT Должность_ID
    FROM Передвижения_по_должностям
    WHERE Сотрудник_ID = 4
    AND Дата_окончания IS NULL
    ),
    СредняяЗарплатаПоРангу AS (
        SELECT p.Должность_ID, ROUND(AVG(z.Зарплата),2) AS СредняяЗарплатаПоРангу
        FROM Зарплаты z
        JOIN Передвижения_по_должностям p ON z.Сотрудник_ID = p.Сотрудник_ID
        WHERE p.Должность_ID IN (SELECT Должность_ID FROM ТекущаяДолжность)
        GROUP BY p.Должность_ID
    ),
    ТекущийОтдел AS (
    SELECT ОТДЕЛ_ID
    FROM ПЕРЕДВИЖЕНИЕ_ПО_ОТДЕЛАМ
    WHERE Сотрудник_ID = 4
    AND Дата_окончания IS NULL
    ),
    СредняяЗарплатаПоОтделу AS (
        SELECT p.Отдел_ID, ROUND(AVG(z.Зарплата),2) AS СредняяЗарплатаПоОтделу
        FROM Зарплаты z
        JOIN Передвижение_по_отделам p ON z.Сотрудник_ID = p.Сотрудник_ID
        where p.ОТДЕЛ_ID in(select ТекущийОтдел.ОТДЕЛ_ID from ТекущийОтдел)
        GROUP BY p.Отдел_ID
    ),
    ЗарплатыReport AS (
        SELECT s.Имя,
               COUNT(*) AS Количество
        FROM Зарплаты z
        JOIN Сотрудники s ON z.Сотрудник_ID = s.ID
        JOIN Передвижение_по_отделам p ON z.Сотрудник_ID = p.Сотрудник_ID
        --Сотрудник_ID_current vvv (4)
        WHERE z.Сотрудник_ID =  4 AND z.Дата >= TO_DATE('2023-01-01', 'YYYY-MM-DD') AND z.Дата <= TO_DATE('2023-12-31', 'YYYY-MM-DD')
        GROUP BY s.Имя
    )
    SELECT Имя,
            (SELECT * FROM СредняяЗарплатаОбщая) AS "Средняя зарплата в компании",
       (SELECT * FROM СредняяЗарплатаСотрудника) AS "Средняя зарплата сотрудника",
       (SELECT СредняяЗарплатаПоРангу FROM СредняяЗарплатаПоРангу WHERE ROWNUM = 1) AS "СредняяЗарплатаПоРангу",
       (SELECT СредняяЗарплатаПоОтделу FROM СредняяЗарплатаПоОтделу WHERE ROWNUM = 1) AS "СредняяЗарплатаПоОтделу",
       ROUND(((SELECT * FROM СредняяЗарплатаСотрудника) - (SELECT СредняяЗарплатаПоОтделу FROM СредняяЗарплатаПоОтделу WHERE ROWNUM = 1)) / (SELECT СредняяЗарплатаПоОтделу FROM СредняяЗарплатаПоОтделу WHERE ROWNUM = 1) * 100, 2) AS "Разница с отделом (%)",
       ROUND(((SELECT * FROM СредняяЗарплатаСотрудника) - (SELECT СредняяЗарплатаПоРангу FROM СредняяЗарплатаПоРангу WHERE ROWNUM = 1)) / (SELECT СредняяЗарплатаПоРангу FROM СредняяЗарплатаПоРангу WHERE ROWNUM = 1) * 100, 2) AS "Разница с рангом (%)"
FROM ЗарплатыReport;*/

SELECT DISTINCT
    Сотрудники.ID,
    Сотрудники.Имя,
    ROUND(AVG(Зарплаты.Зарплата) OVER (PARTITION BY Сотрудники.ID),2) AS Средняя_зарплата_сотрудника,
    ROUND(AVG(Зарплаты.Зарплата) OVER (),2) AS Средняя_зарплата_по_компании,
    ROUND(AVG(Зарплаты.Зарплата) OVER (PARTITION BY Передвижения_по_должностям.Должность_ID),2) AS Средняя_зарплата_по_должности,
    ROUND(AVG(Зарплаты.Зарплата) OVER (PARTITION BY Передвижение_по_отделам.Отдел_ID),2) AS Средняя_зарплата_по_отделу
FROM
    Сотрудники
JOIN
    Зарплаты ON Сотрудники.ID = Зарплаты.Сотрудник_ID AND Зарплаты.Дата BETWEEN ADD_MONTHS(SYSDATE, -12) AND SYSDATE
LEFT JOIN
    Передвижения_по_должностям ON Сотрудники.ID = Передвижения_по_должностям.Сотрудник_ID
LEFT JOIN
    Передвижение_по_отделам ON Сотрудники.ID = Передвижение_по_отделам.Сотрудник_ID
GROUP BY
    Сотрудники.ID, Сотрудники.Имя, Передвижения_по_должностям.Должность_ID, Передвижение_по_отделам.Отдел_ID, Зарплаты.Зарплата
ORDER BY
    Сотрудники.ID;

/*
Вернуть для каждого отдела суммы зарплат сотрудников за последние 6 месяцев помесячно.
*/
WITH MonthlySalaries AS
(
    SELECT
        P.Отдел_ID,
        EXTRACT(YEAR FROM Z.Дата) AS Year,
        EXTRACT(MONTH FROM Z.Дата) AS Month,
        SUM(Z.Зарплата) AS TotalSalary
    FROM
        Зарплаты Z
    JOIN
        Сотрудники S ON Z.Сотрудник_ID = S.ID
    JOIN
        Передвижение_по_отделам P ON S.ID = P.Сотрудник_ID
    WHERE
        Z.Дата BETWEEN ADD_MONTHS(SYSDATE, -6) AND SYSDATE
    GROUP BY
        P.Отдел_ID, EXTRACT(YEAR FROM Z.Дата), EXTRACT(MONTH FROM Z.Дата)
)
SELECT
    Отдел_ID,
    Year,
    Month,
    TotalSalary,
    SUM(TotalSalary) OVER (PARTITION BY Отдел_ID ORDER BY Year, Month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeSalary
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
