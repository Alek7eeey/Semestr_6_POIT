CREATE or replace TYPE Employee_Type AS OBJECT (
    ID NUMBER,
    First_Name NVARCHAR2(100),
    Last_Name NVARCHAR2(100),
    Education_ID NUMBER,
    Marital_Status NVARCHAR2(100),
    Insurance_Policy_ID NUMBER,
    Gender NVARCHAR2(10),
    CONSTRUCTOR FUNCTION Employee_Type (
        ID NUMBER,
        First_Name NVARCHAR2,
        Last_Name NVARCHAR2,
        Education_ID NUMBER,
        Marital_Status NVARCHAR2,
        Insurance_Policy_ID NUMBER,
        Gender NVARCHAR2
    ) RETURN SELF AS RESULT,
    MAP MEMBER FUNCTION compare RETURN NUMBER,
    MEMBER FUNCTION getFullName RETURN NVARCHAR2,
    MEMBER PROCEDURE printDetails
);
/
--DROP TYPE Employee_Type;
--DROP TYPE Business_Trip_Type;

CREATE or replace TYPE BODY Employee_Type AS
    CONSTRUCTOR FUNCTION Employee_Type (
        ID NUMBER,
        First_Name NVARCHAR2,
        Last_Name NVARCHAR2,
        Education_ID NUMBER,
        Marital_Status NVARCHAR2,
        Insurance_Policy_ID NUMBER,
        Gender NVARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.ID := ID;
        SELF.First_Name := First_Name;
        SELF.Last_Name := Last_Name;
        SELF.Education_ID := Education_ID;
        SELF.Marital_Status := Marital_Status;
        SELF.Insurance_Policy_ID := Insurance_Policy_ID;
        SELF.Gender := Gender;
        RETURN;
    END;
    MAP MEMBER FUNCTION compare RETURN NUMBER IS
    BEGIN
        RETURN SELF.ID;
    END compare;
    MEMBER FUNCTION getFullName RETURN NVARCHAR2 IS
    BEGIN
        RETURN First_Name || ' ' || Last_Name;
    END getFullName;
    member PROCEDURE printDetails IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ID: ' || ID);
        DBMS_OUTPUT.PUT_LINE('Name: ' || getFullName);
        DBMS_OUTPUT.PUT_LINE('Education ID: ' || Education_ID);
        DBMS_OUTPUT.PUT_LINE('Marital Status: ' || Marital_Status);
        DBMS_OUTPUT.PUT_LINE('Insurance Policy ID: ' || Insurance_Policy_ID);
        DBMS_OUTPUT.PUT_LINE('Gender: ' || Gender);
    END printDetails;
END;
/

//-------------
CREATE or replace TYPE Business_Trip_Type AS OBJECT (
    ID NUMBER,
    Employee_ID NUMBER,
    Location NVARCHAR2(100),
    Start_Date DATE,
    End_Date DATE,
    CONSTRUCTOR FUNCTION Business_Trip_Type (
        ID NUMBER,
        Employee_ID NUMBER,
        Location NVARCHAR2,
        Start_Date DATE,
        End_Date DATE
    ) RETURN SELF AS RESULT,
    MAP MEMBER FUNCTION compare RETURN NUMBER,
    MEMBER FUNCTION tripDuration RETURN NUMBER,
    MEMBER PROCEDURE printDetails
);
/
CREATE or replace TYPE BODY Business_Trip_Type AS
    CONSTRUCTOR FUNCTION Business_Trip_Type (
        ID NUMBER,
        Employee_ID NUMBER,
        Location NVARCHAR2,
        Start_Date DATE,
        End_Date DATE
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.ID := ID;
        SELF.Employee_ID := Employee_ID;
        SELF.Location := Location;
        SELF.Start_Date := Start_Date;
        SELF.End_Date := End_Date;
        RETURN;
    END;
    MAP MEMBER FUNCTION compare RETURN NUMBER IS
    BEGIN
        RETURN SELF.ID;
    END compare;
    MEMBER FUNCTION tripDuration RETURN NUMBER IS
    BEGIN
        RETURN ROUND((End_Date - Start_Date));
    END tripDuration;
    member PROCEDURE printDetails IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ID: ' || ID);
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || Employee_ID);
        DBMS_OUTPUT.PUT_LINE('Location: ' || Location);
        DBMS_OUTPUT.PUT_LINE('Start Date: ' || TO_CHAR(Start_Date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('End Date: ' || TO_CHAR(End_Date, 'DD-MON-YYYY'));
    END printDetails;
END;
/
--- =======================
DECLARE
    emp1 Employee_Type;
    trip1 Business_Trip_Type;
BEGIN
    emp1 := Employee_Type(1, 'John', 'Doe', 1, 'Married', 123, 'Male');
    trip1 := Business_Trip_Type(1, 1, 'New York', TO_DATE('2024-04-10', 'YYYY-MM-DD'), TO_DATE('2024-04-15', 'YYYY-MM-DD'));

    -- Выводим детали сотрудника и командировки
    emp1.printDetails;
    trip1.printDetails;

    -- Сравнение объектов
    IF emp1.compare = trip1.compare THEN
        DBMS_OUTPUT.PUT_LINE('IDs are equal.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('IDs are not equal.');
    END IF;

    -- Продолжительность командировки
    DBMS_OUTPUT.PUT_LINE('Duration of the trip: ' || trip1.tripDuration || ' days');
END;
/

-- ===============
create index employee_id_index on TABLE(Employee_Type) (Employee_Type.id);

CREATE INDEX trip_id_index ON TABLE(Business_Trip_Type) (ID);

CREATE INDEX trip_duration_index ON TABLE(Business_Trip_Type) (tripDuration);

-- *****************************
CREATE TABLE Employee_Table(
    empl Employee_Type
);