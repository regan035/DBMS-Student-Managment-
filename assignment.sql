DROP DATABASE IF EXISTS course_mgmt;
CREATE DATABASE course_mgmt;
USE course_mgmt;
CREATE TABLE Student_Master(
    Student_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Student_Fname VARCHAR(100) NOT NULL,
    Student_Lname VARCHAR(100) NOT NULL,
    Student_DOB DATETIME  
);

CREATE TABLE Course_Master(
    Course_ID INT NOT NULL PRIMARY KEY,
    Course_Name VARCHAR(100) NOT NULL,
    Course_Cost DECIMAL(6,2),
    Course_Detail VARCHAR(200),
    Course_Objective VARCHAR(300)
    
);

CREATE TABLE Student_Course_Info(
    Student_ID INT,
    Course_ID INT,
    Course_Start_Date DATETIME,
    Course_Ende_Date DATETIME,
    Class_Location VARCHAR(100),
    FOREIGN KEY(Student_ID)REFERENCES Student_Master(Student_ID),
    FOREIGN KEY(Course_ID)REFERENCES Course_Master(Course_ID)
);

INSERT INTO Student_Master(Student_Fname,Student_Lname,Student_DOB) VALUES
('John','Doe','1990-01-01 01:02:03'),
('Tommy','Ford','1992-02-02 02:03:04'),
('Ryan','Smith','1993-03-03 05:06:07'),
('William','Sam','1993-03-03 05:06:07'),
('Mary','Sue','1994-03-03 05:06:07');

INSERT INTO Course_Master(Course_ID,Course_Name,Course_Cost,Course_Detail,Course_Objective) VALUES
(10001,'Eng 101',102.42,'English 1','English 101'),
(10002,'Eng 102',202.42,'English 2','English 201'),
(20001,'CS 101',1202.42,'Computer Science','CS101'),
(30001,'HIS 101',1202.42,'History 1','History 101'),
(40001,'MATH 101',1202.42,'Math 1','Math 101');

INSERT INTO Student_Course_Info(Student_ID,Course_ID,Course_Start_Date,Course_Ende_Date,Class_Location)VALUES
(1,10001,'2022-05-01 09:00:00','2022-07-31 17:00:00','ROOM101'),
(1,10002,'2022-05-02 09:00:00','2022-07-31 17:00:00','ROOM102'),
(2,10001,'2022-05-01 09:00:00','2022-07-31 17:00:00','ROOM101'),
(2,20001,'2022-05-03 09:00:00','2022-07-31 17:00:00','ROOM103'),
(3,10002,'2022-05-02 09:00:00','2022-07-31 17:00:00','ROOM102'),
(3,20001,'2022-05-03 09:00:00','2022-07-31 17:00:00','ROOM103'),
(4,30001,'2022-05-03 13:00:00','2022-07-31 17:00:00','ROOM104');


# SELECT * FROM Student_Master;
# SELECT * FROM Course_Master;
# SELECT * FROM Student_Course_Info;

## Inner Join will only display data with matched values.
# In this example we use 2 inner join to connect 3 tables together and only display student names who registered classes with class names and locations
SELECT 
Student_Master.Student_Fname, 
Student_Master.Student_Lname, 
Course_Master.Course_Name, 
Student_Course_Info.Course_Start_Date, 
Student_Course_Info.Class_Location 
FROM Student_Course_Info 
INNER JOIN Student_Master 
ON Student_Master.Student_ID = Student_Course_Info.Student_ID
INNER JOIN Course_Master
ON Course_Master.Course_ID = Student_Course_Info.Course_ID;

# Left Join will display all records( Student Name ) in the student master table(Left side),
# and only matched records in course master table(Right side) which shows registered classes information.
# In this example Mary Sue doesn't register any class.

SELECT 
Student_Master.Student_Fname, 
Student_Master.Student_Lname, 
Student_Course_Info.Course_ID,
Student_Course_Info.Course_Start_Date, 
Student_Course_Info.Class_Location 
FROM Student_Master 
LEFT JOIN Student_Course_Info
ON Student_Master.Student_ID = Student_Course_Info.Student_ID;

## Right Join will display all records in course master (Right side ) 
# and only matched record in student master record table(Left side)
# In this example, we use a inner join to filter out the only students that registered classes with dates and locations, 
# then use RIGHT JOIN to display all class names. 
# We can see course Math 101 have neither student register nor starting date and classroom location in record.
SELECT 
Student_Master.Student_Fname, 
Student_Master.Student_Lname, 
Course_Master.Course_Name, 
Student_Course_Info.Course_Start_Date, 
Student_Course_Info.Class_Location 
FROM Student_Course_Info 
INNER JOIN Student_Master 
ON Student_Master.Student_ID = Student_Course_Info.Student_ID
RIGHT JOIN Course_Master
ON Course_Master.Course_ID = Student_Course_Info.Course_ID;

## Full Join wall display all tables when there is a match either on left or right.
SELECT 
Student_Master.Student_Fname, 
Student_Master.Student_Lname, 
Student_Course_Info.Course_ID,
Student_Course_Info.Course_Start_Date
FROM Student_Master 
FULL JOIN Student_Course_Info
ON Student_Master.Student_ID = Student_Course_Info.Student_ID; 