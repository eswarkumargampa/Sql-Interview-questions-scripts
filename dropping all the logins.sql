Declare @Loginnames VARCHAR(1000),
@Count INT = 1,
@Totalusers INT,
@Dropstatement NVARCHAR(1000)

DROP TABLE IF EXISTS #Logins

SELECT IDENTITY (INT,1,1) AS USERID,name
INTO #Logins
FROM sys.server_principals
WHERE Type = 'S'
AND name <> 'sa'
AND name not like '%#%'

SELECT @Totalusers = MAX(USERID) FROM #Logins

WHILE (@Count <= @Totalusers)

BEGIN

SELECT @Loginnames = name FROM #Logins WHERE USERID = @Count

SELECT @Dropstatement ='DROP Login '+@Loginnames

exec sp_executesql @Dropstatement

IF @Loginnames='dbo'
EXEC sp_changedbowner 'sa'
ELSE
EXEC sp_dropuser @Loginnames

SET @Count = @Count+1

END


