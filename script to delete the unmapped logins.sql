USE master
GO

DECLARE @username VARCHAR(25)
DECLARE GetOrphanUsers CURSOR
FOR
SELECT UserName = name
FROM sysusers
WHERE issqluser = 1
AND (sid IS NOT NULL
AND sid <> 0x0)
AND SUSER_SNAME(sid) IS NULL
ORDER BY name
OPEN GetOrphanUsers
FETCH NEXT
FROM GetOrphanUsers
INTO @username
WHILE @@FETCH_STATUS = 0
BEGIN
IF @username='dbo'
EXEC sp_changedbowner 'sa'
ELSE
EXEC sp_dropuser @username
FETCH NEXT
FROM GetOrphanUsers
INTO @username
END
CLOSE GetOrphanUsers
DEALLOCATE GetOrphanUsers
GO

USE MSDB
GO


DECLARE @username VARCHAR(25)
DECLARE GetOrphanUsers CURSOR
FOR
SELECT  name
FROM sysusers
WHERE issqluser = 1
AND (sid IS NOT NULL
AND sid <> 0x0)
AND SUSER_SNAME(sid) IS NULL
AND name<>'MS_DataCollectorInternalUser'
ORDER BY name
OPEN GetOrphanUsers
FETCH NEXT
FROM GetOrphanUsers
INTO @username
WHILE @@FETCH_STATUS = 0
BEGIN
IF @username='dbo'
EXEC sp_changedbowner 'sa'
ELSE
EXEC sp_dropuser @username
FETCH NEXT
FROM GetOrphanUsers
INTO @username
END
CLOSE GetOrphanUsers
DEALLOCATE GetOrphanUsers
GO

USE TEMPDB
GO


DECLARE @username VARCHAR(25)
DECLARE GetOrphanUsers CURSOR
FOR
SELECT UserName = name
FROM sysusers
WHERE issqluser = 1
AND (sid IS NOT NULL
AND sid <> 0x0)
AND SUSER_SNAME(sid) IS NULL
ORDER BY name
OPEN GetOrphanUsers
FETCH NEXT
FROM GetOrphanUsers
INTO @username
WHILE @@FETCH_STATUS = 0
BEGIN
IF @username='dbo'
EXEC sp_changedbowner 'sa'
ELSE
EXEC sp_dropuser @username
FETCH NEXT
FROM GetOrphanUsers
INTO @username
END
CLOSE GetOrphanUsers
DEALLOCATE GetOrphanUsers
GO

USE model
GO

DECLARE @username VARCHAR(25)
DECLARE GetOrphanUsers CURSOR
FOR
SELECT UserName = name
FROM sysusers
WHERE issqluser = 1
AND (sid IS NOT NULL
AND sid <> 0x0)
AND SUSER_SNAME(sid) IS NULL
ORDER BY name
OPEN GetOrphanUsers
FETCH NEXT
FROM GetOrphanUsers
INTO @username
WHILE @@FETCH_STATUS = 0
BEGIN
IF @username='dbo'
EXEC sp_changedbowner 'sa'
ELSE
EXEC sp_dropuser @username
FETCH NEXT
FROM GetOrphanUsers
INTO @username
END
CLOSE GetOrphanUsers
DEALLOCATE GetOrphanUsers
GO

USE Claim
GO


DECLARE @username VARCHAR(25)
DECLARE GetOrphanUsers CURSOR
FOR
SELECT UserName = name
FROM sysusers
WHERE issqluser = 1
AND (sid IS NOT NULL
AND sid <> 0x0)
AND SUSER_SNAME(sid) IS NULL
ORDER BY name
OPEN GetOrphanUsers
FETCH NEXT
FROM GetOrphanUsers
INTO @username
WHILE @@FETCH_STATUS = 0
BEGIN
IF @username='dbo'
EXEC sp_changedbowner 'sa'
ELSE
EXEC sp_dropuser @username
FETCH NEXT
FROM GetOrphanUsers
INTO @username
END
CLOSE GetOrphanUsers
DEALLOCATE GetOrphanUsers
GO

USE ClaimStage
GO


DECLARE @username VARCHAR(25)
DECLARE GetOrphanUsers CURSOR
FOR
SELECT UserName = name
FROM sysusers
WHERE issqluser = 1
AND (sid IS NOT NULL
AND sid <> 0x0)
AND SUSER_SNAME(sid) IS NULL
ORDER BY name
OPEN GetOrphanUsers
FETCH NEXT
FROM GetOrphanUsers
INTO @username
WHILE @@FETCH_STATUS = 0
BEGIN
IF @username='dbo'
EXEC sp_changedbowner 'sa'
ELSE
EXEC sp_dropuser @username
FETCH NEXT
FROM GetOrphanUsers
INTO @username
END
CLOSE GetOrphanUsers
DEALLOCATE GetOrphanUsers
GO

USE EligibilityStage
GO


DECLARE @username VARCHAR(25)
DECLARE GetOrphanUsers CURSOR
FOR
SELECT UserName = name
FROM sysusers
WHERE issqluser = 1
AND (sid IS NOT NULL
AND sid <> 0x0)
AND SUSER_SNAME(sid) IS NULL
ORDER BY name
OPEN GetOrphanUsers
FETCH NEXT
FROM GetOrphanUsers
INTO @username
WHILE @@FETCH_STATUS = 0
BEGIN
IF @username='dbo'
EXEC sp_changedbowner 'sa'
ELSE
EXEC sp_dropuser @username
FETCH NEXT
FROM GetOrphanUsers
INTO @username
END
CLOSE GetOrphanUsers
DEALLOCATE GetOrphanUsers
GO

USE ProcessStage
GO


DECLARE @username VARCHAR(25)
DECLARE GetOrphanUsers CURSOR
FOR
SELECT UserName = name
FROM sysusers
WHERE issqluser = 1
AND (sid IS NOT NULL
AND sid <> 0x0)
AND SUSER_SNAME(sid) IS NULL
ORDER BY name
OPEN GetOrphanUsers
FETCH NEXT
FROM GetOrphanUsers
INTO @username
WHILE @@FETCH_STATUS = 0
BEGIN
IF @username='dbo'
EXEC sp_changedbowner 'sa'
ELSE
EXEC sp_dropuser @username
FETCH NEXT
FROM GetOrphanUsers
INTO @username
END
CLOSE GetOrphanUsers
DEALLOCATE GetOrphanUsers
GO

USE PMS
GO


DECLARE @username VARCHAR(25)
DECLARE GetOrphanUsers CURSOR
FOR
SELECT UserName = name
FROM sysusers
WHERE issqluser = 1
AND (sid IS NOT NULL
AND sid <> 0x0)
AND SUSER_SNAME(sid) IS NULL
ORDER BY name
OPEN GetOrphanUsers
FETCH NEXT
FROM GetOrphanUsers
INTO @username
WHILE @@FETCH_STATUS = 0
BEGIN
IF @username='dbo'
EXEC sp_changedbowner 'sa'
ELSE
EXEC sp_dropuser @username
FETCH NEXT
FROM GetOrphanUsers
INTO @username
END
CLOSE GetOrphanUsers
DEALLOCATE GetOrphanUsers
GO