--restore
USE [master]
GO

IF EXISTS(SELECT 1 FROM SYS.DATABASES WHERE Name= 'Claim')

ALTER DATABASE Claim SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
RESTORE DATABASE Claim FROM DISK = 'D:\BackUP\Claim.bak'
WITH REPLACE, FILE = 1, NOUNLOAD, STATS = 10,
MOVE 'Claim' TO 'D:\Databases\Claim.mdf',
MOVE 'Claim_Log' TO 'D:\Databases\Claim_Log.ldf'
ALTER DATABASE Claim SET MULTI_USER;


--Bakup
DECLARE @DBName VARCHAR(50) = 'Claim'		---		Give your DB name
DECLARE @Path VARCHAR(256) = 'D:\BackUP\'		---		Give your path where we need to plack our backups.
DECLARE @File_Name VARCHAR(256)
 
 SET @File_Name = @Path + @DBName +'.bak'  
   BACKUP DATABASE @DBName TO DISK = @File_Name 





