DROP PROCEDURE DisplayEmpName

CREATE PROCEDURE DisplayEmpName (
@EMPID INT,
@Givenname VARCHAR(MAX)
)

AS 
BEGIN

Declare @Ename VARCHAR(MAX)

SELECT @Ename =  Ename FROM EMPMAX WHERE EMPID = @EMPID

IF (@Ename IS NULL)

BEGIN 

PRINT 'name is null'

PRINT @Givenname
 

END

ELSE 

BEGIN

PRINT @Ename

END
END

EXECUTE DisplayEmpName 5,'Check'