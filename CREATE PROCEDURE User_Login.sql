USE [master]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET NOCOUNT ON
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'User_Login' AND TYPE = 'P')
DROP PROCEDURE User_Login
GO

CREATE PROCEDURE User_Login
	(
	@Login_Name VARCHAR(MAX)
	)
AS

/*
Executing the Stored_Procedure below

EXEC User_Login 'hanmakk,ashfamm'

*/

BEGIN
DECLARE @Database_Info TABLE (Database_ID INT IDENTITY(1,1),Database_Name VARCHAR(200))
DECLARE @Login_Info TABLE (Login_Name VARCHAR(200),Exists_Flag VARCHAR(10))
DECLARE @Exsisted_Logins TABLE(ID INT IDENTITY(1,1),login_Name VARCHAR(200))
DECLARE @New_Logins TABLE(ID INT IDENTITY(1,1),login_Name VARCHAR(200))
DECLARE @Login_Max_Cnt INT,@Login_Inc INT = 1,@DB_Max_Cnt INT,@DB_Inc INT = 1,@DBName VARCHAR(200),@Login_SQL VARCHAR(MAX),@User_SQL VARCHAR(MAX)
	,@Write_Role_SQL VARCHAR(MAX),@Read_Role_SQL VARCHAR(MAX),@Owner_Role_SQL VARCHAR(MAX),@Password VARCHAR(200)
	,@Server_Name VARCHAR(MAX) = @@SERVERNAME,@XML XML,@Loop INT,@adminStatement NVARCHAR(max)

--DROP TABLE IF EXISTS #Login_Info
CREATE TABLE #Login_Info (Login_ID INT IDENTITY(1,1),Login_Name VARCHAR(200),Pwd VARCHAR(200))

SET @XML = CAST('<i>' + REPLACE(@Login_Name, ',', '</i><i>') + '</i>' AS XML)

iar--Inserting all Logins and Password into table variable.

INSERT INTO @Login_Info(Login_Name,Exists_Flag)
SELECT Item AS Login_Name,'N' AS Exists_Flag
FROM InterimDB.dbo.[SplitString] (@Login_Name,',')

UPDATE LI
	SET LI.Exists_Flag = 'Y'		--		SELECT *
FROM @Login_Info LI
INNER JOIN master.sys.sysusers SU WITH (NOLOCK)
	ON LI.Login_Name = SU.name

INSERT  INTO @Exsisted_Logins(login_Name)
SELECT Login_Name
FROM @Login_Info LI
	WHERE LI.Exists_Flag = 'Y'

INSERT  INTO @New_Logins(login_Name)
SELECT Login_Name
FROM @Login_Info LI
	WHERE LI.Exists_Flag = 'N'

INSERT INTO #Login_Info(Login_Name,Pwd)
SELECT REPLACE(REPLACE(LI.Login_Name,'.',''),',','') AS Login_Name,'GaintEagle@1' AS Pwd
FROM @Login_Info LI
INNER JOIN @XML.nodes('i') x(i) 
        ON  LI.Login_Name = x.i.value('.', 'VARCHAR(MAX)')
		AND LI.Exists_Flag = 'N'

IF(@Server_Name != '10.0.0.51')		---		Please given your server name except Production
BEGIN

SELECT @Login_Max_Cnt = MAX(Login_ID) FROM #Login_Info

WHILE(@Login_Inc <= @Login_Max_Cnt)		---		Loop for number of Logins

BEGIN 

SELECT @Login_Name = Login_Name,@Password = Pwd FROM #Login_Info WHERE Login_ID = @Login_Inc

SELECT @Login_SQL = 'CREATE LOGIN '+@Login_Name+' WITH PASSWORD = '+''''+@Password+''''+' MUST_CHANGE	
	,CHECK_EXPIRATION = ON;'

EXEC (@Login_SQL)

SET @adminStatement ='EXEC master..sp_addsrvrolemember @loginame = '+@Login_Name+', @rolename = N''sysadmin'''

exec sp_executesql @adminStatement


--Creating the New Users for each and every databases.

INSERT INTO @Database_Info(Database_Name)
SELECT name AS Database_Name
FROM sys.databases

SELECT @DB_Max_Cnt = MAX(database_id) FROM @Database_Info

WHILE(@DB_Inc <= @DB_Max_Cnt)
BEGIN

SELECT @DBName = Database_Name FROM @Database_Info WHERE Database_ID = @DB_Inc

--Adding the New user to Every Database.

SELECT @User_SQL = 'USE '+@DBName+';
CREATE USER '+@Login_Name+' FOR LOGIN '+@Login_Name+' WITH DEFAULT_SCHEMA=[DBO];'

EXEC (@User_SQL)

--Adding the Write Roles to Every Database.

SELECT @Write_Role_SQL = 'USE '+@DBName+' ; 
 ALTER ROLE [db_datawriter] ADD MEMBER '+@Login_Name +' ; '

EXEC  (@Write_Role_SQL)

--Adding the Read Roles to Every Database.

SELECT @Read_Role_SQL = 'USE '+@DBName+' ; 
 ALTER ROLE [db_datareader] ADD MEMBER '+@Login_Name +' ; '

EXEC  (@Read_Role_SQL)

--Adding the Owner Roles to Every Database.

SELECT @Owner_Role_SQL = 'USE '+@DBName+' ; 
 ALTER ROLE [db_owner] ADD MEMBER '+@Login_Name +' ; '

EXEC  (@Owner_Role_SQL)

SET @DB_Inc = @DB_Inc+1

END		---		While loop for DBs Ends

SET @Login_Inc = @Login_Inc+1

END		---		While loop for Users Ends

END		---		If Loop Ends

SELECT ID,' user already exists : '+login_Name AS Alert FROM @Exsisted_Logins

SELECT @Loop = MAX(ID) FROM @New_Logins

--SELECT @Loop

IF(@Loop > 0)

SELECT ID,'user : '+@Login_Name+' successfully created' AS Alert FROM @New_Logins 

END		---		SP End Here
