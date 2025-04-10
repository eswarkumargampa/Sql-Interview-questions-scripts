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
AND name <> 'dbo'
AND name not like '%#%'

DECLARE @MinID INT

SELECT @MinID =  MIN(ID) FROM #User

 
DECLARE @MaxID INT,
@statement NVARCHAR(MAX),
@dbname NVARCHAR(MAX)

SELECT @MaxID =  MAX(ID) FROM #User

 

--SELECT @MinCEID

--SELECT @MaxCEID

 

WHILE(@MinID < = @MaxID)

BEGIN

 
DECLARE @UserName VARCHAR(50)

SELECT @UserName = UserName FROM #User WHERE ID = @MinID
 

DECLARE @sql VARCHAR(1000)

 
SET @SQL = 'DROP USER '+ @UserName
 
SELECT @SQL = 'use '+@dbname +';'+ 'DROP USER '+ @UserName

 exec sp_executesql @SQL
 
SELECT @statement = 'use '+@dbname +';'+ 'CREATE USER '+ @UserName+
' FOR LOGIN '+ @UserName+'; EXEC sp_addrolemember N''db_datareader'', '
+ @UserName+';EXEC sp_addrolemember N''db_datawriter'', '+ @UserName+'
;EXEC sp_addrolemember N''db_owner'', '+ @UserName+''

exec sp_executesql @statement

SET @MinID = @MinID+1

 
END
