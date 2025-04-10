--different ways to find 10th employee salary 

--Method 1: Using OFFSET and FETCH NEXT

SELECT salary
FROM employees
ORDER BY salary
OFFSET 9 ROWS
FETCH NEXT 1 ROWS ONLY;

--Method 2: Using a Subquery with TOP and ORDER BY

SELECT TOP 1 salary
FROM (
    SELECT TOP 10 salary
    FROM employees
    ORDER BY salary
) AS TopSalaries
ORDER BY salary DESC;

--Method 3: Using Correlated Subqueries

SELECT salary
FROM employees e1
WHERE 10 = (
    SELECT COUNT(DISTINCT salary)
    FROM employees e2
    WHERE e2.salary >= e1.salary
);


--Method 4: Using Common Table Expressions (CTEs) with ROW_NUMBER

WITH RankedSalaries AS (
    SELECT salary, ROW_NUMBER() OVER (ORDER BY salary) AS rnk
    FROM employees
)
SELECT salary
FROM RankedSalaries
WHERE rnk = 10;

--Method 5: Using Derived Tables

SELECT MIN(salary) AS salary
FROM (
    SELECT DISTINCT TOP 10 salary
    FROM employees
    ORDER BY salary
) AS TopSalaries;
