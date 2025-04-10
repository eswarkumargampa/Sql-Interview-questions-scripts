--Grantng write acess for the user who already read access

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

Select IDENTITY (INT,1,1) AS Number,
	P1.principal_id AS ID,
	P1.name As Principal,
	P2.name As DBRole
INTO #TEMP
From sys.database_principals As P1
Inner join sys.database_role_members As RM On RM.member_principal_id = P1.principal_id
Inner join sys.database_principals As P2 On P2.principal_id = RM.role_principal_id
Where P2.name IN ('db_datareader')
AND P1.name NOT IN (
Select P1.name As Principal
From sys.database_principals As P1
Inner join sys.database_role_members As RM On RM.member_principal_id = P1.principal_id
Inner join sys.database_principals As P2 On P2.principal_id = RM.role_principal_id
Where P2.name IN ('db_datawriter')
)
ORDER BY P1.name


--Getting all the db list

DROP TABLE IF EXISTS #Dbname

SELECT IDENTITY (INT,1,1) AS ID,name
INTO #Dbname
FROM MASTER.dbo.sysdatabases

SELECT @TotalLogins= MAX(Number) FROM #TEMP

WHILE (@I <= @TotalLogins)
BEGIN

SELECT @Loginname= Principal FROM #TEMP WHERE Number = @I
 
--Granting write perimissions for user who is already having read access

SELECT @TotalDbID=MAX(ID) FROM #Dbname

Declare @Databases INT = 1

	WHILE (@Databases <= @TotalDbID )

	BEGIN

	SELECT @dbname= NAME FROM #Dbname WHERE ID = @Databases

SELECT @statement = 'use '+@dbname +';'+ 'EXEC sp_addrolemember N''db_datawriter'', '
	+ @Loginname+';'

exec sp_executesql @statement


SET @Databases = @Databases+1
 
 END

SET @I = @I+1 

END

