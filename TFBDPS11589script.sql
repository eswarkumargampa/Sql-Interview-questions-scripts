USE interimDB
GO

SELECT *
FROM TFBDPS11589

SELECT *,
CASE 
WHEN trueupeac<=IIF(retailpriced<>0,retailpriced,AAC) THEN trueupeac 
WHEN trueupeac > IIF(retailpriced<>0,retailpriced,AAC) THEN IIF(SWP=0 OR SWP > IIF(retailpriced<>0,retailpriced,AAC),IIF(retailpriced<>0,retailpriced,AAC),SWP) 
END AS TrueUpCost
FROM TFBDPS11589

