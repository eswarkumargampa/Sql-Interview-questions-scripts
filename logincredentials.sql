USE [master]
GO
CREATE LOGIN [TipsDemoUser] WITH PASSWORD=N'Tips_DemoUser@123', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
Use master
GO

DECLARE @dbname VARCHAR(50)   
DECLARE @statement NVARCHAR(max)

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

SELECT @statement = 'use '+@dbname +';'+ 'CREATE USER [TipsDemoUser] 
FOR LOGIN [TipsDemoUser]; EXEC sp_addrolemember N''db_datareader'', 
[TipsDemoUser];EXEC sp_addrolemember N''db_datawriter'', [TipsDemoUser]'

exec sp_executesql @statement

FETCH NEXT FROM db_cursor INTO @dbname  
END  
CLOSE db_cursor  
DEALLOCATE db_cursor 












Use master
GO

DECLARE @dbname VARCHAR(50)   
DECLARE @statement NVARCHAR(max)

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

SELECT @statement = 'use '+@dbname +';'+ 'CREATE USER [TipsDemoUser] 
FOR LOGIN [TipsDemoUser]; EXEC sp_addrolemember N''db_datareader'', 
[TipsDemoUser];EXEC sp_addrolemember N''db_datawriter'', [TipsDemoUser]'

exec sp_executesql @statement

FETCH NEXT FROM db_cursor INTO @dbname  
END  
CLOSE db_cursor  
DEALLOCATE db_cursor 




--CREATE TABLE #TEMP(
--Number INT IDENTITY(1,1),
--NAME VARCHAR(100),
--PASSWORD NVARCHAR(100)
--)
--INSERT INTO #TEMP(NAME,PASSWORD) 
--VALUES('hanmanthk','GaintEagle@1'),('ashfaqm','GaintEagle@1'),('srivineesh','GaintEagle@1'),('sairam','GaintEagle@1'),('eswar','GaintEagle@1')

--SELECT *
--FROM #TEMP

Declare @I int = 1,
@Loginname VARCHAR(100),
@LoginPassword NVARCHAR(100),
@TotalLogins INT,
@SqlStatement VARCHAR(1000)





SELECT @Loginname= NAME,@LoginPassword= PASSWORD FROM #TEMP WHERE Number = @I

SELECT @SqlStatement ='CREATE LOGIN '+@Loginname+' WITH PASSWORD= '+@LoginPassword+', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON'

PRINT @SqlStatement

















Declare @I int = 1,
@Loginname VARCHAR(100),
@LoginPassword NVARCHAR(100),
@TotalLogins INT,
@SqlStatement VARCHAR(1000)


SELECT @TotalLogins= MAX(Number) FROM #TEMP


WHILE (@I <= @TotalLogins)
BEGIN


SELECT @Loginname= NAME,@LoginPassword= PASSWORD FROM #TEMP WHERE Number = @I

SELECT @SqlStatement ='CREATE LOGIN '+@Loginname+' WITH PASSWORD= '+@LoginPassword+', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON'

exec sp_executesql @SqlStatement


SET @I = @I+1 

END






























