DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

CREATE TABLE Departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Locations (
  location_id INT PRIMARY KEY AUTO_INCREMENT,
  location_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(150) NOT NULL,
  gender CHAR(1) NOT NULL,
  age INT,
  designation VARCHAR(200),
  salary DECIMAL(12,2),
  hire_date DATE,
  department_id INT,
  location_id INT,
  email VARCHAR(255) UNIQUE,
  CONSTRAINT fk_dept FOREIGN KEY (department_id) REFERENCES Departments(department_id)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_loc FOREIGN KEY (location_id) REFERENCES Locations(location_id)
    ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO Departments (department_id, department_name) VALUES
(1,'Finance'), (2,'HR'), (3,'IT'), (4,'Operations');

INSERT INTO Locations (location_name) VALUES
('Mumbai'),('Bengaluru'),('Hyderabad'),('Chennai');

INSERT INTO Employees (emp_id, emp_name, gender, age, designation, salary, hire_date, department_id, location_id, email)
VALUES
(101,'Asha Rao','F',29,'Financial Analyst',55000,'2015-08-21',1,1,'asha.rao@example.com'),
(102,'Ravi Kumar','M',32,'Data Analyst',48000,'2017-03-12',3,2,'ravi.k@example.com'),
(103,'Meera Singh','F',26,NULL,51000,'2018-06-10',3,2,'meera.s@example.com'),
(104,'Suresh B','M',45,'Manager',90000,'2010-11-01',1,3,'suresh.b@example.com'),
(105,'Priya N','F',24,'Junior Analyst',30000,'2018-02-05',2,4,'priya.n@example.com'),
(106,'Arjun P','M',28,'Business Analyst',70000,'2014-12-15',4,1,NULL);
SELECT * FROM Employees;
SELECT DISTINCT salary FROM Employees;
SELECT emp_id, emp_name, age AS Employee_Age, salary AS Employee_Salary FROM Employees;
SELECT emp_id, emp_name, salary, hire_date FROM Employees
WHERE salary > 50000 AND hire_date < '2016-01-01';
SELECT emp_id, emp_name, department_id, salary FROM Employees
ORDER BY department_id ASC, salary DESC;
SELECT emp_id, emp_name, hire_date FROM Employees
WHERE YEAR(hire_date) = 2018
ORDER BY hire_date
LIMIT 5;
SELECT SUM(e.salary) AS total_salary_finance
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';
SELECT MIN(age) AS min_age FROM Employees;
SELECT l.location_name, MAX(e.salary) AS max_salary
FROM Employees e
JOIN Locations l ON e.location_id = l.location_id
GROUP BY l.location_name;
SELECT designation, AVG(salary) AS avg_salary
FROM Employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;
SELECT d.department_name, COUNT(*) AS emp_count
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(*) < 3;
SELECT l.location_name, AVG(e.age) AS avg_age_females
FROM Employees e
JOIN Locations l ON e.location_id = l.location_id
WHERE e.gender = 'F'
GROUP BY l.location_name
HAVING AVG(e.age) < 30;
SELECT e.emp_name, e.designation, d.department_name
FROM Employees e
INNER JOIN Departments d ON e.department_id = d.department_id;
SELECT d.department_name, COUNT(e.emp_id) AS total_employees
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_name;
SELECT l.location_name, e.emp_name
FROM Employees e
RIGHT JOIN Locations l ON e.location_id = l.location_id
ORDER BY l.location_name;









