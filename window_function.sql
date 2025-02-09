/*  understanding 
WHERE
 GROUP BY
 HAVING
 Set Operations
 Sub-querying or CTEs
 Joins
 and views Rank Frames Lead and lag Case statement
 */
 use learn1;
 CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    JoiningDate DATE,
    ManagerID INT,
    PerformanceRating INT
);
INSERT INTO Employees (EmployeeID, Name, Department, Salary, JoiningDate, ManagerID, PerformanceRating) VALUES
(101, 'John Doe', 'Sales', 60000, '2019-01-15', 201, 4),
(102, 'Jane Smith', 'HR', 75000, '2020-03-10', 202, 5),
(103, 'Alice Brown', 'IT', 80000, '2018-07-23', 203, 3),
(104, 'Bob White', 'IT', 85000, '2017-11-01', 203, 5),
(105, 'Emma Davis', 'Sales', 65000, '2021-02-19', 201, 4),
(106, 'Mike Green', 'HR', 70000, '2019-05-30', 202, 3),
(107, 'Chris Black', 'Marketing', 90000, '2020-12-15', 204, 4),
(108, 'Anna Blue', 'Marketing', 95000, '2016-04-12', 204, 5);
select * from employees;
-- 1. WHERE Clause:
select Name,Department,Salary
from employees
where Department = 'IT' and Salary > 75000;	
-- 2. GROUP BY Clause:
select Department,
avg(Salary) as avgsalary
from employees
group by Department;
-- 3. HAVING Clause:
select Department
from employees
group by Department
having avg(Salary) > 70000;
-- Set Operations:
-- UNION Example
SELECT Name FROM Employees WHERE Department = 'Sales'
UNION
SELECT Name FROM Employees WHERE Department = 'Marketing';
-- 5. Sub-querying or CTEs:
-- Sub-query Example
SELECT Name, Salary 
FROM Employees 
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- CTE Example
WITH HighEarners AS (
    SELECT Name, Salary 
    FROM Employees 
    WHERE Salary > 70000
)
SELECT * FROM HighEarners;

-- 7. Rank:
SELECT Name, Department, Salary, 
RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) as SalaryRank
FROM Employees;

-- 8. Frames:
SELECT Name, Salary, 
SUM(Salary) OVER (ORDER BY Salary ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as RunningTotal
FROM Employees;

-- 9. Lead and Lag:
SELECT Name, Salary, 
LEAD(Salary, 1) OVER (ORDER BY Salary) as NextSalary, 
LAG(Salary, 1) OVER (ORDER BY Salary) as PreviousSalary
FROM Employees;

-- 10. Case Statement:
SELECT Name, Department, Salary, 
CASE 
    WHEN Salary < 60000 THEN 'Low'
    WHEN Salary BETWEEN 60000 AND 80000 THEN 'Medium'
    ELSE 'High'
END as SalaryLevel
FROM Employees;







