
-- 1. Create Database
CREATE DATABASE CollegeDB;
USE CollegeDB;

-- 2. Create Tables

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Gender VARCHAR(10),
    DOB DATE,
    DepartmentID INT,
    Year INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    Marks INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 3. Insert Sample Data

-- Departments Table
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mechanical'),
(3, 'Electronics'),
(4, 'Civil'),
(5, 'Electrical'),
(6, 'Aerospace'),
(7, 'Biotechnology'),
(8, 'Chemical'),
(9, 'Mathematics'),
(10, 'Physics');

-- Students Table
INSERT INTO Students (Name, Gender, DOB, DepartmentID, Year) VALUES
('Rahul Kumar', 'Male', '2002-03-12', 1, 2),
('Priya Sharma', 'Female', '2001-07-08', 2, 3),
('Aryan Singh', 'Male', '2003-01-15', 1, 1),
('Nalini Verma', 'Female', '2000-11-21', 3, 4),
('Kunal Jain', 'Male', '2004-05-25', 4, 1),
('Riya Gupta', 'Female', '2002-09-10', 5, 2),
('Siddharth Mehta', 'Male', '2001-03-20', 6, 3),
('Anjali Saxena', 'Female', '2003-07-15', 7, 1),
('Vivek Mishra', 'Male', '2000-01-01', 8, 4),
('Sakshi Agarwal', 'Female', '2002-11-12', 9, 2);

-- Courses Table
INSERT INTO Courses (CourseID, CourseName, DepartmentID) VALUES
(101, 'Data Structures', 1),
(102, 'Thermodynamics', 2),
(103, 'Circuits', 3),
(104, 'Algorithms', 1),
(105, 'Mechanics of Materials', 2),
(106, 'Digital Logic', 3),
(107, 'Aerospace Engineering', 6),
(108, 'Biochemistry', 7),
(109, 'Calculus', 9),
(110, 'Electromagnetism', 10);

-- Enrollments Table
INSERT INTO Enrollments (StudentID, CourseID, Marks) VALUES
(1, 101, 85),
(1, 104, 90),
(2, 102, 75),
(3, 101, 88),
(4, 103, 60),
(5, 105, 70),
(6, 106, 80),
(7, 107, 85),
(8, 108, 90),
(9, 109, 75);

--  Queries

-- select all columns
SELECT * FROM departments;
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;

-- select specific columns 
SELECT name, gender FROM students;
SELECT DepartmentName FROM Departments; 
SELECT CourseName FROM courses;
SELECT marks FROM Enrollments;

-- WHERE Clause 
SELECT * FROM students 
WHERE Gender = 'male';


-- AGGREGATE FUNCTIONS 
-- COUNT (count total students)
SELECT COUNT(*) AS Total_Students
FROM students;

-- SUM 
SELECT SUM(marks) AS TotaL_Marks
FROM Enrollments;

-- MIN / MAX
SELECT MAX(marks) AS Highest,
MIN(marks) AS Lowest
from Enrollments;


-- JOINS 
-- retrieve students and their department names
SELECT s.Name, d.DepartmentName
FROM students s
JOIN Departments d  
ON s.DepartmentID = d.DepartmentID;

-- retrieve courses and their department names
SELECT c.CourseName, d.DepartmentName
FROM courses c
JOIN departments d
ON c.DepartmentID = d.DepartmentID;

-- retrieve students and their enrolled courses
SELECT s.Name, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN courses c ON e.CourseID = c.CourseID;

-- retrieve courses and their marks
SELECT c.CourseName, e.Marks
FROM courses c
JOIN enrollments e
ON c.CourseID = e.CourseID;

-- INNER JOIN 
-- retrieve students who are enrolled in a courses
SELECT s.Name, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

-- retrieve departments that have students enrolled
SELECT d.DepartmentName
FROM Departments d
INNER JOIN Students s 
ON d.DepartmentID = s.DepartmentID;

-- LEFT JOIN
-- retrieve all students, even if they are not enrolled in a course
SELECT s.Name, c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID;

-- retrieve all departments, even if they are not have students enrolled
SELECT d.DepartmentName, s.Name
FROM Departments d
LEFT JOIN Students s ON d.DepartmentID = s.DepartmentID;

-- RIGHT JOIN
-- retrieve all courses, even if they are not have students enrolled 
SELECT c.CourseName, s.Name
FROM Courses c
RIGHT JOIN Enrollments e ON c.CourseID = e.CourseID
RIGHT JOIN Students s ON e.StudentID = s.StudentID;


-- GROUP ClAUSE
-- Total students per department
SELECT d.DepartmentName, COUNT(s.StudentID) AS Total_Students
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- Average marks per course
SELECT c.CourseName, AVG(e.Marks) AS Average_Marks
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName;

-- ORDER BY CLAUSE
-- Students ordered by DOB
SELECT Name, DOB FROM Students
ORDER BY DOB;

-- Top scorers by course
SELECT s.Name, c.CourseName, e.Marks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
ORDER BY e.Marks DESC;

-- HAVING CLAUSE 
-- Departments with more than 1 students
SELECT d.DepartmentName, COUNT(s.StudentID) AS Total_Students
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(s.StudentID) > 1;

-- Courses with average marks above 80
SELECT c.CourseName, AVG(e.Marks) AS Average_Marks
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName
HAVING AVG(e.Marks) > 80;

-- Sub Queries
-- Students who scored above average
SELECT s.Name, e.Marks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.Marks > (SELECT AVG(Marks) FROM Enrollments);

-- Departments with at least one student born after 2002
SELECT DISTINCT d.DepartmentName
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
WHERE s.DOB > '2002-01-01';

-- Top scorer in each course
SELECT c.CourseName, s.Name AS Topper, e.Marks AS TopScore
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE (e.CourseID, e.Marks) IN (
    SELECT CourseID, MAX(Marks)
    FROM Enrollments
    GROUP BY CourseID
);

-- highest scorer in each course
SELECT c.CourseName, s.Name, e.Marks
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Students s ON e.StudentID = s.StudentID
WHERE e.Marks = (
    SELECT MAX(Marks)
    FROM Enrollments e2
    WHERE e2.CourseID = e.CourseID
);

-- VIEWS 
-- Create a view of student enrollments
CREATE VIEW StudentEnrollments AS
SELECT s.Name AS StudentName, c.CourseName, e.Marks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

-- Query the view
SELECT * FROM StudentEnrollments
WHERE Marks > 80;

-- High Performers
CREATE VIEW HighPerformers AS
SELECT s.Name, AVG(e.Marks) AS AvgMarks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID
HAVING AvgMarks > 80;

-- Stored Procedure
-- Students by department
DELIMITER //
CREATE PROCEDURE GetStudentsByDept(IN deptName VARCHAR(100))
BEGIN
    SELECT s.Name 
    FROM Students s
    JOIN Departments d ON s.DepartmentID = d.DepartmentID
    WHERE d.DepartmentName = deptName;
END //
DELIMITER ;

-- Create a procedure to get student details by ID
DELIMITER //
CREATE PROCEDURE GetStudentByID(IN studID INT)
BEGIN
    SELECT * FROM Students WHERE StudentID = studID;
END //
DELIMITER ;

-- Call the procedure
CALL GetStudentByID(3);


-- Procedure to insert a new student
DELIMITER //
CREATE PROCEDURE AddStudent(
    IN name VARCHAR(100),
    IN gender VARCHAR(10),
    IN dob DATE,
    IN deptID INT,
    IN year INT
)
BEGIN
    INSERT INTO Students (Name, Gender, DOB, DepartmentID, Year)
    VALUES (name, gender, dob, deptID, year);
END //
DELIMITER ;

-- Call the procedure
CALL AddStudent('Neha Rathi', 'Female', '2003-06-22', 1, 1);


-- Triggers 
-- Create an audit table to log insertions
CREATE TABLE StudentAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(100),
    ActionTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger to log insertions into Students
DELIMITER //
CREATE TRIGGER AfterStudentInsert
AFTER INSERT ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentAudit (StudentName)
    VALUES (NEW.Name);
END //
DELIMITER ;



-- ---------------------------------------------------------------------

-- Important Queries 

-- 1. Retrieve all student details.
SELECT * FROM Students;

-- 2. Get names of all departments.
SELECT DepartmentName FROM Departments;

-- 3. List all course names.
SELECT CourseName FROM Courses;

-- 4. Count total students.
SELECT COUNT(*) AS TotalStudents FROM Students;

-- 5. Find all female students.
SELECT * FROM Students WHERE Gender = 'Female';

-- 6. Get students enrolled in 'Data Structures'.
SELECT s.Name
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Data Structures';

-- 7. Find average marks in each course.
SELECT c.CourseName, AVG(e.Marks) AS AverageMarks
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName;

-- 8. List students born after 2002.
SELECT * FROM Students WHERE DOB > '2002-01-01';

-- 9. Get departments with more than 2 students.
SELECT d.DepartmentName, COUNT(*) AS TotalStudents
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(*) > 2;

-- 10. Get student names and their departments.
SELECT s.Name, d.DepartmentName
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID;

-- 11. Find total marks for each student.
SELECT s.Name, SUM(e.Marks) AS TotalMarks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.Name;

-- 12. List students with marks above average.
SELECT s.Name, e.Marks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.Marks > (SELECT AVG(Marks) FROM Enrollments);

-- 13. Highest mark scored in each course.
SELECT c.CourseName, MAX(e.Marks) AS MaxMarks
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName;

-- 14. Total courses per department.
SELECT d.DepartmentName, COUNT(c.CourseID) AS TotalCourses
FROM Courses c
JOIN Departments d ON c.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- 15. Students not enrolled in any course.
SELECT s.Name
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;

-- 16. List all students with their enrolled courses.
SELECT s.Name, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

-- 17. Top scoring student in each course.
SELECT c.CourseName, s.Name, e.Marks
FROM Enrollments e
JOIN Courses c ON c.CourseID = e.CourseID
JOIN Students s ON s.StudentID = e.StudentID
WHERE (e.CourseID, e.Marks) IN (
    SELECT CourseID, MAX(Marks)
    FROM Enrollments
    GROUP BY CourseID
);

-- 18. View to display high performers (avg > 80).
CREATE OR REPLACE VIEW HighPerformers AS
SELECT s.Name, AVG(e.Marks) AS AvgMarks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID
HAVING AvgMarks > 80;

-- 19. Query from HighPerformers view.
SELECT * FROM HighPerformers;

-- 20. Stored Procedure to get student by ID.
DELIMITER //
CREATE PROCEDURE GetStudentByID(IN studID INT)
BEGIN
    SELECT * FROM Students WHERE StudentID = studID;
END //
DELIMITER ;

-- 21. Call stored procedure.
CALL GetStudentByID(2);

-- 22. Add new student using procedure.
DELIMITER //
CREATE PROCEDURE AddStudent(
    IN name VARCHAR(100),
    IN gender VARCHAR(10),
    IN dob DATE,
    IN deptID INT,
    IN year INT
)
BEGIN
    INSERT INTO Students (Name, Gender, DOB, DepartmentID, Year)
    VALUES (name, gender, dob, deptID, year);
END //
DELIMITER ;

-- 23. Call AddStudent procedure.
CALL AddStudent('Deepak Mishra', 'Male', '2003-04-10', 2, 1);

-- 24. List of departments with no students.
SELECT d.DepartmentName
FROM Departments d
LEFT JOIN Students s ON d.DepartmentID = s.DepartmentID
WHERE s.StudentID IS NULL;

-- 25. Trigger to audit new student insertions.
CREATE TABLE IF NOT EXISTS StudentAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(100),
    ActionTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER AfterStudentInsert
AFTER INSERT ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentAudit (StudentName)
    VALUES (NEW.Name);
END //
DELIMITER ;

-- 26. List all audit logs.
SELECT * FROM StudentAudit;

-- 27. Calculate age of all students.
SELECT Name, TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age FROM Students;

-- 28. Rank students by total marks.
SELECT s.Name, SUM(e.Marks) AS TotalMarks,
       RANK() OVER (ORDER BY SUM(e.Marks) DESC) AS RankNo
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID;

-- 29. Find course with highest average marks.
SELECT CourseName
FROM (
    SELECT c.CourseName, AVG(e.Marks) AS AvgMarks
    FROM Courses c
    JOIN Enrollments e ON c.CourseID = e.CourseID
    GROUP BY c.CourseID
) AS Sub
ORDER BY AvgMarks DESC
LIMIT 1;

-- 30. Students from 'Computer Science'.
SELECT s.Name
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';

-- 31. Count students in each year.
SELECT Year, COUNT(*) AS Total FROM Students GROUP BY Year;

-- 32. Students with more than one course.
SELECT s.Name, COUNT(e.CourseID) AS CoursesEnrolled
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID
HAVING CoursesEnrolled > 1;

-- 33. Course not taken by any student.
SELECT CourseName
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
WHERE e.EnrollmentID IS NULL;

-- 34. Student with minimum marks in any course.
SELECT s.Name, e.Marks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
ORDER BY e.Marks ASC
LIMIT 1;

-- 35. Number of students by gender.
SELECT Gender, COUNT(*) AS Count FROM Students GROUP BY Gender;

-- 36. Youngest student.
SELECT * FROM Students ORDER BY DOB DESC LIMIT 1;

-- 37. Average marks by department.
SELECT d.DepartmentName, AVG(e.Marks) AS AvgMarks
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Departments d ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- 38. List of courses with student count.
SELECT c.CourseName, COUNT(e.StudentID) AS StudentsEnrolled
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName;

-- 39. Gender-wise average marks.
SELECT s.Gender, AVG(e.Marks) AS AvgMarks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.Gender;

-- 40. All students sorted by name.
SELECT * FROM Students ORDER BY Name;

-- 41. Course with lowest average marks.
SELECT c.CourseName
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY e.CourseID
ORDER BY AVG(e.Marks) ASC
LIMIT 1;

-- 42. Delete student by ID.
DELETE FROM Students WHERE StudentID = 15;

-- 43. Update student name.
UPDATE Students SET Name = 'Rohan Mehta' WHERE StudentID = 3;

-- 44. Number of students per department (including 0).
SELECT d.DepartmentName, COUNT(s.StudentID) AS TotalStudents
FROM Departments d
LEFT JOIN Students s ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- 45. Average marks per year.
SELECT s.Year, AVG(e.Marks) AS AvgMarks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.Year;

-- 46. Students with name starting with 'A'.
SELECT * FROM Students WHERE Name LIKE 'A%';

-- 47. Courses that contain the word 'Logic'.
SELECT * FROM Courses WHERE CourseName LIKE '%Logic%';

-- 48. Students having marks in all their enrolled courses > 80.
SELECT s.Name
FROM Students s
WHERE NOT EXISTS (
    SELECT 1
    FROM Enrollments e
    WHERE e.StudentID = s.StudentID AND e.Marks <= 80
);

-- 49. Student with second highest mark.
SELECT s.Name, e.Marks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
ORDER BY e.Marks DESC
LIMIT 1 OFFSET 1;

-- 50. Departments with at least one course and one student.
SELECT d.DepartmentName
FROM Departments d
WHERE EXISTS (
    SELECT 1 FROM Courses c WHERE c.DepartmentID = d.DepartmentID
) AND EXISTS (
    SELECT 1 FROM Students s WHERE s.DepartmentID = d.DepartmentID
);

-- 51. Use CASE to classify student grades.
SELECT s.Name, e.Marks,
       CASE
           WHEN e.Marks >= 90 THEN 'A'
           WHEN e.Marks >= 75 THEN 'B'
           WHEN e.Marks >= 60 THEN 'C'
           WHEN e.Marks >= 40 THEN 'D'
           ELSE 'F'
       END AS Grade
FROM Enrollments e
JOIN Students s ON s.StudentID = e.StudentID;

-- 52. Common Table Expression (CTE) to get top 3 scorers.
WITH RankedStudents AS (
    SELECT s.Name, SUM(e.Marks) AS TotalMarks,
           RANK() OVER (ORDER BY SUM(e.Marks) DESC) AS RankNo
    FROM Students s
    JOIN Enrollments e ON s.StudentID = e.StudentID
    GROUP BY s.StudentID
)
SELECT * FROM RankedStudents WHERE RankNo <= 3;

-- 53. Using EXISTS to find students who took 'Operating Systems'.
SELECT s.Name
FROM Students s
WHERE EXISTS (
    SELECT 1
    FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE e.StudentID = s.StudentID AND c.CourseName = 'Data Structures'
);

-- 54. Get highest and lowest marks in the database.
SELECT MAX(Marks) AS Highest, MIN(Marks) AS Lowest FROM Enrollments;

-- 55. Create index on Students.Name for faster search.
CREATE INDEX idx_student_name ON Students(Name);

-- 56. Find duplicate student names (if any).
SELECT Name, COUNT(*) AS Count
FROM Students
GROUP BY Name
HAVING COUNT(*) > 1;

-- 57. Use UNION to combine male and female student lists.
SELECT Name, Gender FROM Students WHERE Gender = 'Male'
UNION
SELECT Name, Gender FROM Students WHERE Gender = 'Female';

-- 58. Compare department sizes.
SELECT d.DepartmentName,
       COUNT(s.StudentID) AS StudentCount,
       COUNT(DISTINCT e.CourseID) AS CourseCount
FROM Departments d
LEFT JOIN Students s ON s.DepartmentID = d.DepartmentID
LEFT JOIN Courses c ON c.DepartmentID = d.DepartmentID
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY d.DepartmentName;

-- 59. Use ROW_NUMBER to number students alphabetically.
SELECT s.Name, ROW_NUMBER() OVER (ORDER BY s.Name) AS RowNum
FROM Students s;

-- 60. Get course-wise student count using LEFT JOIN.
SELECT c.CourseName, COUNT(e.StudentID) AS TotalEnrolled
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName;

-- 61. Self join concept – list students in same department.
SELECT A.Name AS Student1, B.Name AS Student2, D.DepartmentName
FROM Students A
JOIN Students B ON A.DepartmentID = B.DepartmentID AND A.StudentID < B.StudentID
JOIN Departments D ON A.DepartmentID = D.DepartmentID;

-- 62. Get student's name, course name, and department name.
SELECT s.Name, c.CourseName, d.DepartmentName
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Departments d ON c.DepartmentID = d.DepartmentID;

-- 63. Delete all enrollments where marks < 30 (failed).
DELETE FROM Enrollments WHERE Marks < 30;

-- 64. Find students who scored same in two or more courses.
SELECT s.Name, e.Marks, COUNT(*) AS SameMarksCourses
FROM Enrollments e
JOIN Students s ON s.StudentID = e.StudentID
GROUP BY s.StudentID, e.Marks
HAVING COUNT(*) > 1;

-- 65. Show percentage of students per department.
SELECT d.DepartmentName,
       ROUND((COUNT(s.StudentID) * 100.0) / (SELECT COUNT(*) FROM Students), 2) AS Percentage
FROM Departments d
LEFT JOIN Students s ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;

-- 66. Create a backup of Students table.
CREATE TABLE Students_Backup AS
SELECT * FROM Students;

-- 67. Find courses with average marks between 60 and 80.
SELECT c.CourseName, AVG(e.Marks) AS AvgMarks
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName
HAVING AVG(e.Marks) BETWEEN 60 AND 80;

-- 68. Subquery to find students with highest individual marks.
SELECT Name FROM Students
WHERE StudentID IN (
    SELECT StudentID FROM Enrollments
    WHERE Marks = (SELECT MAX(Marks) FROM Enrollments)
);

-- 69. Compare each student's marks with course average.
SELECT s.Name, c.CourseName, e.Marks,
       (SELECT AVG(Marks) FROM Enrollments e2 WHERE e2.CourseID = c.CourseID) AS CourseAvg
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

-- 70. Dynamic filter using IN.
SELECT * FROM Students WHERE Year IN (1, 2);

-- 71. Count how many students failed in at least one course.
SELECT COUNT(DISTINCT StudentID) AS StudentsFailed
FROM Enrollments
WHERE Marks < 40;

-- 72. Update all students in 1st year to 2nd year.
UPDATE Students SET Year = 2 WHERE Year = 1;

-- 73. Show student with the highest average marks.
SELECT s.Name, AVG(e.Marks) AS AvgMarks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID
ORDER BY AvgMarks DESC
LIMIT 1;

-- 74. Display top 2 students per course (dense rank).
SELECT * FROM (
    SELECT c.CourseName, s.Name, e.Marks,
           DENSE_RANK() OVER (PARTITION BY c.CourseID ORDER BY e.Marks DESC) AS RankNo
    FROM Enrollments e
    JOIN Students s ON e.StudentID = s.StudentID
    JOIN Courses c ON e.CourseID = c.CourseID
) ranked
WHERE RankNo <= 2;

-- 75. Detect students whose total marks > 250 and < 300.
SELECT s.Name, SUM(e.Marks) AS TotalMarks
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID
HAVING TotalMarks BETWEEN 250 AND 300;
