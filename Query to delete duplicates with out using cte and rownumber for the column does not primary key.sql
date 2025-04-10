DROP TABLE IF EXISTS EMP

CREATE TABLE EMP (
EMPID INT,
EMPNAME VARCHAR(10),
SAL INT
)

INSERT INTO EMP VALUES (1,'A',1000),(1,'A',1000),(1,'A',1000),(2,'B',2000),(2,'B',2000),(3,'C',500)
,(3,'C',500),(3,'C',500),(4,'D',5000)

--Query to delete duplicates with out using cte for the column does not primary key 

SELECT *
FROM ( 
SELECT *,ROW_NUMBER () OVER (PARTITION BY EMPID,EMPNAME,SAL ORDER BY EMPID) AS RN
FROM EMP
)E
WHERE E.RN> 1

--Query to delete duplicates with out using cte and rownumber for the column does not primary key 

DELETE E 
FROM EMP E 
JOIN (
SELECT MAX(%%lockres%%) AS PSUEDOID,EMPID,EMPNAME,SAL
FROM EMP                                           
GROUP BY EMPID,EMPNAME,SAL
)EE 
	ON E.EMPID = EE.EMPID AND E.EMPNAME = EE.EMPNAME AND E.SAL = EE.SAL AND E.%%lockres%% <> EE.PSUEDOID