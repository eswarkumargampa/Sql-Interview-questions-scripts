USE MASTER
GO

DECLARE @User_DB_Info TABLE(User_DB_ID INT IDENTITY(1,1),DataBase_Name VARCHAR(200),UserName VARCHAR(200))
DECLARE @Database_Info TABLE (Database_ID INT IDENTITY(1,1),Database_Name VARCHAR(200))
--DECLARE @Need_ToExclude_Users TABLE (UserID INT IDENTITY(1,1),UserName VARCHAR(200))
DECLARE @Inc INT = 1,@Max_Cnt INT,@SQL VARCHAR(MAX),@DB_Inc INT = 1,@DB_Max_Cnt INT,@DBName VARCHAR(200),@UserName VARCHAR(200)
DECLARE @User_SQL VARCHAR(MAX),@Write_Role_SQL VARCHAR(MAX),@Read_Role_SQL VARCHAR(MAX),@Owner_Role_SQL VARCHAR(MAX),@Drop_SQL VARCHAR(MAX)

UPDATE DB
	SET DB.Login_Exists = 'Y'		--			SELECT DB.*
FROM Master..User_DB_Info DB WITH (NOLOCK)
INNER JOIN Master..Login_DB_Info LB WITH (NOLOCK)
	ON DB.DataBase_Name = LB.DataBase_Name
	AND DB.UserName = LB.LoginName

INSERT INTO @User_DB_Info(DataBase_Name,UserName)
SELECT DataBase_Name,UserName
FROM Master..User_DB_Info DB WITH (NOLOCK)
	WHERE Login_Exists = 'Y'
	ORDER BY 1,2

--		SELECT * FROM Master..User_DB_Info DB WITH (NOLOCK)

--DECLARE @Inc INT,@Max_Cnt INT,@SQL VARCHAR(MAX),@DB_Inc INT = 1,@DB_Max_Cnt INT,@DBName VARCHAR(200)

SELECT @Max_Cnt = MAX(User_DB_ID) FROM @User_DB_Info

--SELECT @Max_Cnt AS Max_Cnt

IF(@Max_Cnt > 0)

BEGIN

WHILE(@Inc <= @Max_Cnt)

BEGIN

SELECT @DBName = DataBase_Name,@UserName = UserName FROM @User_DB_Info WHERE User_DB_ID = @Inc

--Droping the user from Every Database.

SELECT @Drop_SQL = 'USE '+@DBName+';
 DROP USER '+@UserName

 EXEC (@Drop_SQL)

 --Adding the user to Every Database.

SELECT @User_SQL = 'USE '+@DBName+';
CREATE USER '+@UserName+' FOR LOGIN '+@UserName+' WITH DEFAULT_SCHEMA=[DBO];'

EXEC (@User_SQL)
 
--Adding the Write Roles to Every Database.

SELECT @Write_Role_SQL = 'USE '+@DBName+' ; 
 ALTER ROLE [db_datawriter] ADD MEMBER '+@UserName +' ; '

EXEC  (@Write_Role_SQL)

--Adding the Read Roles to Every Database.

SELECT @Read_Role_SQL = 'USE '+@DBName+' ; 
 ALTER ROLE [db_datareader] ADD MEMBER '+@UserName +' ; '

EXEC  (@Read_Role_SQL)

--Adding the Owner Roles to Every Database.

SELECT @Owner_Role_SQL = 'USE '+@DBName+' ; 
 ALTER ROLE [db_owner] ADD MEMBER '+@UserName +' ; '

EXEC  (@Owner_Role_SQL)

SET @Inc = @Inc+1

END

END










