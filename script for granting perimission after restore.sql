DROP TABLE IF EXISTS #User

CREATE TABLE #User

(

               ID INT IDENTITY(1,1),
			   UserName VARCHAR(50)
)

INSERT INTO #User(UserName)

SELECT name FROM sys.database_principals 
wherE tYPE = 's' 
and default_schema_name = 'DBO'
AND name NOT IN ('dbo','MS_DataCollectorInternalUser')
AND name not like '%#%'


DECLARE @MinID INT

SELECT @MinID =  MIN(ID) FROM #User

 
DECLARE @MaxID INT

SELECT @MaxID =  MAX(ID) FROM #User

 

--SELECT @MinCEID

--SELECT @MaxCEID

 

WHILE(@MinID < = @MaxID)

BEGIN

 
DECLARE @UserName VARCHAR(50)

SELECT @UserName = UserName FROM #User WHERE ID = @MinID
 

DECLARE @sql VARCHAR(1000)

 
USE Claim;

 
SET @SQL = 'DROP USER '+ @UserName

 

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = REPLACE(REPLACE(@UserName,']',''),'[',''))

 

EXEC (@SQL)

 

DECLARE @SQL1 VARCHAR(100)

 

SET @SQL1 = 'CREATE USER ' +@UserName+ ' FOR LOGIN ' +@UserName+''

--PRINT @SQL1

EXEC (@SQL1)

 
--EXEC sp_addrolemember 'db_datareader',@UserName

 
DECLARE @Datareader VARCHAR(150)

SET @Datareader = 'sp_addrolemember ' +'db_datareader'+',' +@UserName

--PRINT @Datareader

EXEC (@Datareader)

 

DECLARE @DataWriter VARCHAR(150)

SET @DataWriter = 'sp_addrolemember ' +'db_datawriter'+',' +@UserName

--PRINT @DataWriter

EXEC (@DataWriter)

 

DECLARE @DbOwner VARCHAR(150)

SET @DbOwner = 'sp_addrolemember ' +'db_owner'+',' +@UserName

--PRINT @DataWriter

EXEC (@DbOwner)


DECLARE @Backupoperator VARCHAR(150)

SET @Backupoperator = 'sp_addrolemember ' +'db_backupoperator'+',' +@UserName

--PRINT @DataWriter

EXEC (@Backupoperator)
 

USE ClaimStage;

 

SET @SQL = 'DROP USER '+ @UserName

 

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = REPLACE(REPLACE(@UserName,']',''),'[',''))

 

EXEC (@SQL)

 

DECLARE @SQL2 VARCHAR(100)

 

SET @SQL2 = 'CREATE USER ' +@UserName+ ' FOR LOGIN ' +@UserName+''

--PRINT @SQL1

 

EXEC (@SQL2)

 

--EXEC sp_addrolemember 'db_datareader',@UserName

 

DECLARE @Datareader2 VARCHAR(150)

SET @Datareader2 = 'sp_addrolemember ' +'db_datareader'+',' +@UserName

--PRINT @Datareader

EXEC (@Datareader2)

 

DECLARE @DataWriter2 VARCHAR(150)

SET @DataWriter2 = 'sp_addrolemember ' +'db_datawriter'+',' +@UserName

--PRINT @DataWriter

EXEC (@DataWriter2)

 
DECLARE @DbOwner2 VARCHAR(150)

SET @DbOwner2 = 'sp_addrolemember ' +'db_owner'+',' +@UserName

--PRINT @DataWriter

EXEC (@DbOwner2)

DECLARE @Backupoperator2 VARCHAR(150)

SET @Backupoperator2 = 'sp_addrolemember ' +'db_backupoperator'+',' +@UserName

EXEC (@Backupoperator2)

 

USE EligibilityStage;

 

SET @SQL = 'DROP USER '+ @UserName

 

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = REPLACE(REPLACE(@UserName,']',''),'[',''))

 

EXEC (@SQL)

 

DECLARE @SQL3 VARCHAR(100)

 

SET @SQL3 = 'CREATE USER ' +@UserName+ ' FOR LOGIN ' +@UserName+''

--PRINT @SQL1

 

EXEC (@SQL3)

 

--EXEC sp_addrolemember 'db_datareader',@UserName

 

DECLARE @Datareader3 VARCHAR(150)

SET @Datareader3 = 'sp_addrolemember ' +'db_datareader'+',' +@UserName

--PRINT @Datareader

EXEC (@Datareader3)


--EXEC sp_addrolemember 'db_datareader',@UserName

 
DECLARE @DataWriter3 VARCHAR(150)

SET @DataWriter3 = 'sp_addrolemember ' +'db_datawriter'+',' +@UserName

--PRINT @DataWriter

EXEC (@DataWriter3)

 

DECLARE @DbOwner3 VARCHAR(150)

SET @DbOwner3 = 'sp_addrolemember ' +'db_owner'+',' +@UserName

--PRINT @DataWriter

EXEC (@DbOwner3)

DECLARE @Backupoperator3 VARCHAR(150)

SET @Backupoperator3 = 'sp_addrolemember ' +'db_backupoperator'+',' +@UserName

EXEC (@Backupoperator3)

 

USE PMS;

 

SET @SQL = 'DROP USER '+ @UserName

 

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = REPLACE(REPLACE(@UserName,']',''),'[',''))

 

EXEC (@SQL)

 

DECLARE @SQL4 VARCHAR(100)

 

SET @SQL4 = 'CREATE USER ' +@UserName+ ' FOR LOGIN ' +@UserName+''

--PRINT @SQL1

 

EXEC (@SQL4)

 

--EXEC sp_addrolemember 'db_datareader',@UserName

 

DECLARE @Datareader4 VARCHAR(150)

SET @Datareader4 = 'sp_addrolemember ' +'db_datareader'+',' +@UserName

--PRINT @Datareader

EXEC (@Datareader4)


--EXEC sp_addrolemember 'db_datareader',@UserName
 

DECLARE @DataWriter4 VARCHAR(150)

SET @DataWriter4 = 'sp_addrolemember ' +'db_datawriter'+',' +@UserName

--PRINT @DataWriter

EXEC (@DataWriter4)

 

DECLARE @DbOwner4 VARCHAR(150)

SET @DbOwner4 = 'sp_addrolemember ' +'db_owner'+',' +@UserName

--PRINT @DataWriter

EXEC (@DbOwner4)

 DECLARE @Backupoperator4 VARCHAR(150)

SET @Backupoperator4 = 'sp_addrolemember ' +'db_backupoperator'+',' +@UserName

EXEC (@Backupoperator4)

 

USE Processstage;

 

SET @SQL = 'DROP USER '+ @UserName

 

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = REPLACE(REPLACE(@UserName,']',''),'[',''))

 

EXEC (@SQL)

 

DECLARE @SQL5 VARCHAR(100)

 

SET @SQL5 = 'CREATE USER ' +@UserName+ ' FOR LOGIN ' +@UserName+''

--PRINT @SQL1

 

EXEC (@SQL5)

 

--EXEC sp_addrolemember 'db_datareader',@UserName

 

DECLARE @Datareader5 VARCHAR(150)

SET @Datareader5 = 'sp_addrolemember ' +'db_datareader'+',' +@UserName

--PRINT @Datareader
EXEC (@Datareader5)

DECLARE @DataWriter5 VARCHAR(150)

SET @DataWriter5 = 'sp_addrolemember ' +'db_datawriter'+',' +@UserName

--PRINT @DataWriter

EXEC (@DataWriter5)

 

DECLARE @DbOwner5 VARCHAR(150)

SET @DbOwner5 = 'sp_addrolemember ' +'db_owner'+',' +@UserName

--PRINT @DataWriter

EXEC (@DbOwner5)

 DECLARE @Backupoperator5 VARCHAR(150)

SET @Backupoperator5 = 'sp_addrolemember ' +'db_backupoperator'+',' +@UserName

EXEC (@Backupoperator5)



 

--USE Claim_Archive

 

--SET @SQL = 'DROP USER '+ @UserName

 

--IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = REPLACE(REPLACE(@UserName,']',''),'[',''))

 

--EXEC (@SQL)

 

--DECLARE @SQL6 VARCHAR(100)

 

--SET @SQL6 = 'CREATE USER ' +@UserName+ ' FOR LOGIN ' +@UserName+''

----PRINT @SQL1

 

--EXEC (@SQL6)

 

----EXEC sp_addrolemember 'db_datareader',@UserName

 

--DECLARE @Datareader6 VARCHAR(150)

--SET @Datareader6 = 'sp_addrolemember ' +'db_datareader'+',' +@UserName

----PRINT @Datareader

--EXEC (@Datareader6)


--DECLARE @DataWriter6 VARCHAR(150)

--SET @DataWriter6 = 'sp_addrolemember ' +'db_datawriter'+',' +@UserName

----PRINT @DataWriter

--EXEC (@DataWriter6)

 

--DECLARE @DbOwner6 VARCHAR(150)

--SET @DbOwner6 = 'sp_addrolemember ' +'db_owner'+',' +@UserName

----PRINT @DataWriter

--EXEC (@DbOwner6)


 

--USE ClaimStage_Archive

 

--SET @SQL = 'DROP USER '+ @UserName

 

--IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = REPLACE(REPLACE(@UserName,']',''),'[',''))

 

--EXEC (@SQL)

 

--DECLARE @SQL7 VARCHAR(100)

 

--SET @SQL7 = 'CREATE USER ' +@UserName+ ' FOR LOGIN ' +@UserName+''

----PRINT @SQL1

 

--EXEC (@SQL7)

 

----EXEC sp_addrolemember 'db_datareader',@UserName

 

--DECLARE @Datareader7 VARCHAR(150)

--SET @Datareader7 = 'sp_addrolemember ' +'db_datareader'+',' +@UserName

----PRINT @Datareader

--EXEC (@Datareader7)


--DECLARE @DataWriter7 VARCHAR(150)

--SET @DataWriter7 = 'sp_addrolemember ' +'db_datawriter'+',' +@UserName

----PRINT @DataWriter

--EXEC (@DataWriter7)

 

--DECLARE @DbOwner7 VARCHAR(150)

--SET @DbOwner7 = 'sp_addrolemember ' +'db_owner'+',' +@UserName

----PRINT @DataWriter

--EXEC (@DbOwner7)


 

--USE EligibilityStage_Archive

 

--SET @SQL = 'DROP USER '+ @UserName

 

--IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = REPLACE(REPLACE(@UserName,']',''),'[',''))

 

--EXEC (@SQL)

 

--DECLARE @SQL8 VARCHAR(100)

 

--SET @SQL8 = 'CREATE USER ' +@UserName+ ' FOR LOGIN ' +@UserName+''

----PRINT @SQL1

 

--EXEC (@SQL8)

 

----EXEC sp_addrolemember 'db_datareader',@UserName

 

--DECLARE @Datareader8 VARCHAR(150)

--SET @Datareader8 = 'sp_addrolemember ' +'db_datareader'+',' +@UserName

----PRINT @Datareader

--EXEC (@Datareader8)


--DECLARE @DataWriter8 VARCHAR(150)

--SET @DataWriter8 = 'sp_addrolemember ' +'db_datawriter'+',' +@UserName

----PRINT @DataWriter

--EXEC (@DataWriter8)

 

--DECLARE @DbOwner8 VARCHAR(150)

--SET @DbOwner8 = 'sp_addrolemember ' +'db_owner'+',' +@UserName

----PRINT @DataWriter

--EXEC (@DbOwner8)


 

SET @MinID = @MinID+1

 

END
/*
CREATE LOGIN adminuser WITH PASSWORD = 'ABCDegf123';
GO

EXEC master..sp_addsrvrolemember @loginame = N'adminuser', @rolename = N'sysadmin'
GO
*/