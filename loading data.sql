USE PRACTISE
GO

CREATE TABLE TRANSACTIONS (Amount INT, DATE DATETIME)

INSERT INTO TRANSACTIONS VALUES (1000,'2020-01-06'),
								(-10,'2020-01-14'),
								(-75,'2020-01-20'),
								(-5,'2020-01-25'),
								(-4,'2020-01-29'),
								(2000,'2020-03-10'),
								(-75,'2020-03-12'),
								(-20,'2020-03-15'),
								(40,'2020-03-15'),
								(-50,'2020-03-17'),
								(200,'2020-10-10'),
								(-200,'2020-10-10')

SELECT * FROM TRANSACTIONS