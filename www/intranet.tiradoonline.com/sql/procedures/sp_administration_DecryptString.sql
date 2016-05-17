IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_administration_DecryptString' AND TYPE = 'P')
DROP PROCEDURE sp_administration_DecryptString;
GO


CREATE PROCEDURE [dbo].[sp_administration_DecryptString]
	@teststring VARCHAR(255) OUTPUT
AS
	DECLARE @x tinyint
	DECLARE @DecryptedString VARCHAR(20)
	SET @DecryptedString = ""

	SET @x = 1

	WHILE @x <= LEN(@teststring)
		BEGIN

			SET @DecryptedString = @DecryptedString + CHAR(ASCII(SUBSTRING(@teststring, @x, 1)) - 11)
			SET @x = @x + 1
			CONTINUE
		END
	
	SELECT @DecryptedString


GO

