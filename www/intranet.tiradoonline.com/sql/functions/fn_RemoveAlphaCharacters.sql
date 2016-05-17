IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'fn_RemoveAlphaCharacters' AND TYPE = 'FN')
	DROP FUNCTION fn_RemoveAlphaCharacters;
GO


CREATE FUNCTION fn_RemoveAlphaCharacters(@convertString VARCHAR(100))
	RETURNS VARCHAR(25)
AS

	BEGIN

		DECLARE @Counter INT;
		DECLARE @returnString		VARCHAR(100);

		SET @Counter = 1;
		SET @returnString = '';
		
		WHILE @Counter < LEN(@convertString)
		    BEGIN
			IF ASCII(SUBSTRING(@convertString, @Counter, 1)) >= 48 AND ASCII(SUBSTRING(@convertString, @Counter, 1)) <= 57
			        SET @returnString = @returnString + SUBSTRING(@convertString, @Counter, 1)
	
			SET @Counter = @Counter + 1;

		    END

		RETURN @returnString

	END

GO


SELECT 
	MobileTelephoneNumber, 
	MobileTelephoneNumber2 = dbo.fn_RemoveAlphaCharacters(MobileTelephoneNumber),
	HomeTelephoneNumber, 
	HomeTelephoneNumber2 = dbo.fn_RemoveAlphaCharacters(HomeTelephoneNumber),
	BusinessTelephoneNumber, 
	BusinessTelephoneNumber2 = dbo.fn_RemoveAlphaCharacters(BusinessTelephoneNumber) 

FROM Contacts 

--where BusinessTelephoneNumber like '%ext%'