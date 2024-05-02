create table REPORT (
    id int primary key,
    xml XMLTYPE
);

CREATE TABLE path_table_name (
    path_id NUMBER PRIMARY KEY,
    path_string VARCHAR2(4000)
);

select *
from REPORT;

DELETE FROM REPORT;

COMMIT;

DECLARE
    xml XMLTYPE;
BEGIN
    SELECT XMLELEMENT("Lab_12",
           XMLElement("employees",
               XMLAgg(
                   XMLElement("employee",
                       XMLForest(
                           Сотрудники.ID AS "employee_id",
                           Сотрудники.Имя AS "name_employee",
                           Сотрудники.Фамилия AS "surname_employee"
                       )
                   )
               )
           ),

           XMLElement("vacations",
               XMLAgg(
                   XMLElement("vacation",
                       XMLForest(
                           Отпуска.ID AS "vacation_id",
                           Отпуска.Дата_начала AS "start_vacation",
                           Отпуска.Вид_отпуска AS "type_vacation",
                           Отпуска.Дата_окончания AS "finish_vocation"
                       )
                   )
               )
           ),

           XMLElement("Salaries",
               XMLAgg(
                   XMLElement("Salary",
                       XMLForest(
                           Зарплаты.ID AS "salary_id",
                           Зарплаты.Зарплата AS "salary",
                           Зарплаты.Дата AS "date"
                       )
                   )
               )
           )
       )AS "XML_Data"
    INTO xml FROM ЗАРПЛАТЫ, Отпуска, Сотрудники;

    INSERT INTO REPORT (id, xml) values (5, xml);

    COMMIT;
end;

SELECT data.id, data.имя, data.Фамилия FROM REPORT,
              XMLTable('/Lab_12/employees/employee'
                       PASSING xml
                       COLUMNS
                           id int PATH 'employee_id',
                           имя NVARCHAR2(100) PATH 'name_employee',
                           Фамилия NVARCHAR2(100) PATH 'surname_employee') data
                       GROUP BY DATA.id, data.имя, data.Фамилия;

SELECT data.id, data.Дата_начала, data.Вид_отпуска, data.Дата_окончания FROM REPORT,
              XMLTable('/Lab_12/vacations/vacation'
                       PASSING xml
                       COLUMNS
                           id int PATH 'vacation_id',
                           Дата_начала DATE PATH 'start_vacation',
                           Вид_отпуска NVARCHAR2(100) PATH 'type_vacation',
                           Дата_окончания DATE PATH 'finish_vocation') data
                           GROUP BY data.id, data.Дата_начала, data.Вид_отпуска, data.Дата_окончания;

SELECT data.id, data.Зарплата, data.Дата FROM REPORT,
              XMLTable('/Lab_12/Salaries/Salary'
                       PASSING xml
                       COLUMNS
                           id int PATH 'salary_id',
                           Зарплата NVARCHAR2(100) PATH 'salary',
                           Дата NVARCHAR2(500) PATH 'date') data
                        group by data.id, data.Зарплата, data.Дата;

------------------------------ SQL SERVER ------------------------------
CREATE TABLE Report (
    id INT PRIMARY KEY IDENTITY,
    xml_data XML
);

CREATE OR ALTER PROCEDURE GenerateXMLReport
AS
BEGIN
    DECLARE @xml XML;

    SET @xml = (
        SELECT
            GETDATE() AS [Timestamp],
            (
                SELECT
                    *,
                    (
                        SELECT
                            Вид_отпуска, Дата_начала, Дата_окончания
                        FROM Отпуска AS O
                        WHERE O.Сотрудник_ID = S.ID
                        FOR XML PATH('Отпуск'), TYPE
                    ) AS Отпуска,
                    (
                        SELECT
                            Зарплата, Дата
                        FROM Зарплаты AS Z
                        WHERE Z.Сотрудник_ID = S.ID
                        FOR XML PATH('Зарплата'), TYPE
                    ) AS Зарплаты
                FROM Сотрудники AS S
                FOR XML PATH('Сотрудник'), ROOT('Сотрудники'), TYPE
            )
        FOR XML PATH(''), ROOT('Report')
    );

    INSERT INTO Report (xml_data) VALUES (@xml);
END;

EXEC GenerateXMLReport;

SELECT * FROM Report;

CREATE PRIMARY XML INDEX IX_Report_xml_data ON Report(xml_data);

DROP PROCEDURE ExtractXMLValue;

CREATE OR ALTER PROCEDURE ExtractXMLValue
    @element_name NVARCHAR(100)
AS
BEGIN
    DECLARE @xml XML;
	DECLARE @str NVARCHAR(MAX);
    DECLARE @result NVARCHAR(MAX);

    -- Получаем XML-данные из таблицы Report
    SELECT @xml = xml_data
    FROM Report;

    SET @str = CONCAT('(/Report/', @element_name);
	SET @str = CONCAT(@str, ')[1]');
    SELECT @result = @xml.value(@str, 'NVARCHAR(MAX)');

    -- Выводим результат
    SELECT @result AS ExtractedValue;
END;

DECLARE @xml XML;

SELECT @xml = xml_data
    FROM Report;
SELECT @xml.value('(/Report/Сотрудники/Сотрудник/ID)[2]', 'NVARCHAR(MAX)');

EXEC ExtractXMLValue 'Timestamp';

