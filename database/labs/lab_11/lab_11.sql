CREATE PROCEDURE GetVacationData
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT Сотрудники.Имя, Сотрудники.Фамилия, Отпуска.Вид_отпуска, Отпуска.Дата_начала, Отпуска.Дата_окончания
    FROM Сотрудники
    INNER JOIN Отпуска ON Сотрудники.ID = Отпуска.Сотрудник_ID
    WHERE Отпуска.Дата_начала >= @StartDate AND Отпуска.Дата_окончания <= @EndDate
END

--EXEC GetVacationData @StartDate = '2024-01-01', @EndDate = '2024-12-31'

select *
from result_table;

--oracle
CREATE OR REPLACE FUNCTION GetVacationData(p_start_date IN DATE, p_end_date IN DATE)
RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT Сотрудники.Имя, Сотрудники.Фамилия, Отпуска.Вид_отпуска, Отпуска.Дата_начала, Отпуска.Дата_окончания
    FROM Сотрудники
    INNER JOIN Отпуска ON Сотрудники.ID = Отпуска.Сотрудник_ID
    WHERE Отпуска.Дата_начала >= p_start_date AND Отпуска.Дата_окончания <= p_end_date;
    RETURN v_cursor;
END GetVacationData;
/


