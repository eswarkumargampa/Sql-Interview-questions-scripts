CREATE FUNCTION StateProvinceID(
@StateProvinceID INT
)
RETURNS TABLE 
AS 

RETURN
SELECT *
FROM AdventureWorks2017.dbo.SSIS1 (NOLOCK)
WHERE StateProvinceID = @StateProvinceID

SELECT * FROM  StateProvinceID (14)