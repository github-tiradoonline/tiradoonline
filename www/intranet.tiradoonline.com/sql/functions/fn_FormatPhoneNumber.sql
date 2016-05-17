IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'fn_FormatPhoneNumber' AND TYPE = 'FN')
	DROP FUNCTION fn_FormatPhoneNumber;
GO


CREATE FUNCTION fn_FormatPhoneNumber(@PhoneNo VARCHAR(100))
	RETURNS VARCHAR(25)
AS

	BEGIN

		WHILE PATINDEX('%[^0-9]%', @PhoneNo) > 0
		    BEGIN
		        SET @PhoneNo = STUFF(@PhoneNo, PATINDEX('%[^0-9]%', @PhoneNo), 1, '')
		    END

		IF (LEFT(@PhoneNo, 1) = '1')
			SET @PhoneNo = SUBSTRING(@PhoneNo, 2, LEN(@PhoneNo) - 1);

		IF (LEN(@PhoneNo) < 10)
		    	SET @PhoneNo = @PhoneNo
		ELSE
			BEGIN
				IF (LEN(@PhoneNo) > 10)
				    	SET @PhoneNo = '(' + LEFT(@PhoneNo, 3) + ') ' + SUBSTRING(@PhoneNo, 4, 3) + '-' + SUBSTRING(@PhoneNo, 7, 4) + ' x' + SUBSTRING(@PhoneNo, 11, LEN(@PhoneNo))
				ELSE
				    	SET @PhoneNo = '(' + LEFT(@PhoneNo, 3) + ') ' + SUBSTRING(@PhoneNo, 4, 3) + '-' + SUBSTRING(@PhoneNo, 7, 4)
			END
		
		RETURN @PhoneNo

	END

GO


SELECT 
	MobileTelephoneNumber, 
	MobileTelephoneNumber2 = dbo.fn_FormatPhoneNumber(MobileTelephoneNumber),
	HomeTelephoneNumber, 
	HomeTelephoneNumber2 = dbo.fn_FormatPhoneNumber(HomeTelephoneNumber),
	BusinessTelephoneNumber, 
	BusinessTelephoneNumber2 = dbo.fn_FormatPhoneNumber(BusinessTelephoneNumber) 

FROM Contacts 

--where BusinessTelephoneNumber like '%ext%'