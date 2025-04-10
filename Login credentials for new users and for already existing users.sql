--Creating new user with read and write acess

USE MASTER
GO

BEGIN TRAN
--COMMIT
--ROLLBACK

Declare @I int = 1,
@Loginname VARCHAR(100),
@LoginPassword NVARCHAR(100),
@TotalLogins INT,
@SqlStatement NVARCHAR(max),
@dbname VARCHAR(50),
@statement NVARCHAR(max),
@TotalDbID INT

--Creating temp table to store the information of loginname and password for all the user to create logins

DROP TABLE IF EXISTS #TEMP

CREATE TABLE #TEMP(
Number INT IDENTITY(1,1),
NAME VARCHAR(100),
PASSWORD NVARCHAR(100)
)
INSERT INTO #TEMP(NAME,PASSWORD) 
VALUES('hanmanthk','''GaintEagle@1'''),
('ashfaqm','''GaintEagle@1'''),
('srivineeshm','''GaintEagle@1'''),
('sairamm','''GaintEagle@1'''),
('eswarg','''GaintEagle@1''')

--Getting all the db list

DROP TABLE IF EXISTS #Dbname

SELECT IDENTITY (INT,1,1) AS ID,name
INTO #Dbname
FROM MASTER.dbo.sysdatabases


SELECT @TotalLogins= MAX(Number) FROM #TEMP


WHILE (@I <= @TotalLogins)
BEGIN


SELECT @Loginname= NAME,@LoginPassword= PASSWORD FROM #TEMP WHERE Number = @I

--creating the login credentials 

SELECT @SqlStatement ='CREATE LOGIN '+@Loginname+' WITH PASSWORD= '+@LoginPassword+'
MUST_CHANGE ,CHECK_EXPIRATION=ON,DEFAULT_DATABASE=[master],  CHECK_POLICY=ON'

exec sp_executesql @SqlStatement
 
--Granting read and write perimissions

SELECT @TotalDbID=MAX(ID) FROM #Dbname

Declare @Databases INT = 1

	WHILE (@Databases <= @TotalDbID )

	BEGIN

	SELECT @dbname= NAME FROM #Dbname WHERE ID = @Databases

	SELECT @statement = 'use '+@dbname +';'+ 'CREATE USER '+ @Loginname+
	' FOR LOGIN '+ @Loginname+'; EXEC sp_addrolemember N''db_datareader'', '
	+ @Loginname+';EXEC sp_addrolemember N''db_datawriter'', '+ @Loginname+''

exec sp_executesql @statement


SET @Databases = @Databases+1
 
 END

SET @I = @I+1 

END

