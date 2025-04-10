USE master
GO

DROP TABLE IF EXISTS #TEMP

CREATE TABLE #TEMP(
Number INT IDENTITY(1,1),
NAME VARCHAR(100),
PASSWORD NVARCHAR(100)
)
INSERT INTO #TEMP(NAME,PASSWORD) 
VALUES('hanmanthk','''GaintEagle@1'''),('ashfaqm','''GaintEagle@1'''),('srivineeshm','''GaintEagle@1'''),('sairamm','''GaintEagle@1'''),('eswarg','''GaintEagle@1''')

--SELECT * FROM #TEMP

Declare @I int = 1,
@Loginname VARCHAR(100),
@LoginPassword NVARCHAR(100),
@TotalLogins INT,
@SqlStatement NVARCHAR(max),
@dbname VARCHAR(50),
@statement NVARCHAR(max)


SELECT @TotalLogins= MAX(Number) FROM #TEMP


WHILE (@I <= @TotalLogins)
BEGIN


SELECT @Loginname= NAME,@LoginPassword= PASSWORD FROM #TEMP WHERE Number = @I

SELECT @SqlStatement ='CREATE LOGIN '+@Loginname+' WITH PASSWORD= '+@LoginPassword+', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON'

exec sp_executesql @SqlStatement

--PRINT @SqlStatement


DECLARE db_cursor CURSOR 
LOCAL FAST_FORWARD
FOR  
SELECT name
FROM MASTER.dbo.sysdatabases
WHERE name NOT IN ('master','model','msdb','tempdb','distribution')  
OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @dbname  
WHILE @@FETCH_STATUS = 0  
BEGIN  

SELECT @statement = 'use '+@dbname +';'+ 'CREATE USER '+ @Loginname+
' FOR LOGIN '+ @Loginname+'; EXEC sp_addrolemember N''db_datareader'', '
+ @Loginname+';EXEC sp_addrolemember N''db_datawriter'', '+ @Loginname+''

exec sp_executesql @statement

--PRINT @statement

FETCH NEXT FROM db_cursor INTO @dbname  
END  
CLOSE db_cursor  
DEALLOCATE db_cursor 

SET @I = @I+1 

END






