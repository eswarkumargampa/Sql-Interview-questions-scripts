USE [master]
GO
CREATE LOGIN [BEST] WITH PASSWORD=N'BEST', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
--EXEC master..sp_addsrvrolemember @loginame = N'test', @rolename = N'sysadmin'
--GO

Declare @adminStatement NVARCHAR(max),
@loginame VARCHAR(max) = 'BEST'

SET @adminStatement ='EXEC master..sp_addsrvrolemember @loginame = '+@loginame+', @rolename = N''sysadmin'''

PRINT @Statement

exec sp_executesql @adminStatement











