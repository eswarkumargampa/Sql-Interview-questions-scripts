USE MASTER
GO
SET NOCOUNT ON
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'Finding_User_Information' AND TYPE = 'P')
DROP PROCEDURE Finding_User_Information
GO

CREATE PROCEDURE Finding_User_Information
AS

/*
Executing the Stored_Procedure below

EXEC Finding_User_Information

*/

BEGIN

--		DROP TABLE User_DB_Info
--		DROP TABLE IF EXISTS TABLE User_DB_Info 

IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'User_DB_Info' AND TYPE = 'U')
BEGIN
DROP TABLE User_DB_Info
END

CREATE TABLE User_DB_Info (User_DB_ID INT IDENTITY(1,1),DataBase_Name VARCHAR(200),UserName VARCHAR(200),Login_Exists VARCHAR(20))

DECLARE @Database_Info TABLE(DataBase_ID INT IDENTITY(1,1),DataBaseName VARCHAR(200))
DECLARE @Inc INT = 1,@Max_Cnt INT,@DBName VARCHAR(200),@SQL VARCHAR(MAX)

INSERT INTO @Database_Info(DataBaseName)
SELECT Name
FROM SYS.SYSDATABASES

SELECT @Max_Cnt = COUNT(DataBase_ID) FROM @Database_Info

WHILE(@Inc <= @Max_Cnt)

BEGIN

SELECT @DBName = DataBaseName FROM @Database_Info WHERE DataBase_ID = @Inc

SELECT @SQL = 'SELECT '''+@DBName+''', name, ''N'''+' FROM '+@DBName+'.SYS.SYSUSERS'

INSERT INTO User_DB_Info(DataBase_Name,UserName,Login_Exists)
EXEC(@SQL)

SET @Inc = @Inc+1

END

DELETE DB
FROM Master..User_DB_Info DB
	WHERE UserName IN ('public','dbo','INFORMATION_SCHEMA','sys','##MS_PolicyEventProcessingLogin##','##MS_AgentSigningCertificate##'
	,'RSExecRole','NT AUTHORITY\SYSTEM','db_owner','db_accessadmin','db_securityadmin','db_ddladmin','db_backupoperator','db_datareader','db_datawriter'
	,'db_denydatareader','db_denydatawriter','guest','DatabaseMailUserRole','db_ssisadmin','db_ssisltduser','db_ssisoperator','dc_admin,dc_operator	'
	,'dc_proxy','PolicyAdministratorRole','ServerGroupAdministratorRole','ServerGroupReaderRole','SQLAgentOperatorRole','SQLAgentReaderRole','SQLAgentUserRole'
	,'TargetServersRole','UtilityCMRReader','UtilityIMRReader','UtilityIMRWriter','dc_admin','dc_operator')
	OR UserName LIKE '%##%'
		
END

--			SELECT * FROM MASTER..User_DB_Info WITH (NOLOCK)


