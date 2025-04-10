USE MASTER
GO
SET NOCOUNT ON
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'Finding_Login_Information' AND TYPE = 'P')
DROP PROCEDURE Finding_Login_Information
GO

CREATE PROCEDURE Finding_Login_Information
AS

/*
Executing the Stored_Procedure below

EXEC Finding_Login_Information

*/

BEGIN

--		DROP TABLE Login_DB_Info
--		DROP TABLE IF EXISTS TABLE Login_DB_Info 

IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'Login_DB_Info' AND TYPE = 'U')
BEGIN
DROP TABLE Login_DB_Info
END

CREATE TABLE Login_DB_Info (Login_DB_ID INT IDENTITY(1,1),DataBase_Name VARCHAR(200),LoginName VARCHAR(200),LoginType VARCHAR(20))

DECLARE @Database_Info TABLE(DataBase_ID INT IDENTITY(1,1),DataBaseName VARCHAR(200))
DECLARE @Inc INT = 1,@Max_Cnt INT,@DBName VARCHAR(200),@SQL VARCHAR(MAX)

INSERT INTO @Database_Info(DataBaseName)
SELECT Name
FROM SYS.SYSDATABASES

SELECT @Max_Cnt = COUNT(DataBase_ID) FROM @Database_Info

WHILE(@Inc <= @Max_Cnt)

BEGIN

SELECT @DBName = DataBaseName FROM @Database_Info WHERE DataBase_ID = @Inc

SELECT @SQL = 'SELECT '''+@DBName+''', name, type FROM '+@DBName+'.SYS.Server_Principals'

INSERT INTO Login_DB_Info(DataBase_Name,LoginName,LoginType)
EXEC(@SQL)

SET @Inc = @Inc+1

END

DELETE DB
FROM Master..Login_DB_Info DB
	WHERE LoginType != 'S'
	OR LoginName = 'sa'
	OR LoginName LIKE '%##%'
		
END

--			SELECT * FROM MASTER..Login_DB_Info WITH (NOLOCK)


