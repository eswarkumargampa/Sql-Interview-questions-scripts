ALTER Procedure ADDtwo2 (
@I INT,
@II INT 
)
AS 
BEGIN

Declare @C INT 

SET @C = @I+@II

RETURN @C


END

DECLARE @RV INT 
EXEC @RV = ADDtwo2 
	 @I = 5,
	 @II = 6 

	 SELECT 'RV' = @RV 

