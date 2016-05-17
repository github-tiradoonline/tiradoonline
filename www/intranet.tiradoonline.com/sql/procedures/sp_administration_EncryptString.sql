IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_administration_EncryptString' AND TYPE = 'P')
DROP PROCEDURE sp_administration_EncryptString;
GO


CREATE PROCEDURE [dbo].[sp_administration_EncryptString]
	@teststring VARCHAR(255) OUTPUT
AS
	DECLARE @x tinyint
	DECLARE @EncryptedString VARCHAR(20)
	SET @EncryptedString = ''

	SET @x = 1

	WHILE @x <= LEN(@teststring)
		BEGIN

			SET @EncryptedString = @EncryptedString + CHAR(ASCII(SUBSTRING(@teststring, @x, 1)) + 11)
			SET @x = @x + 1
			CONTINUE
		END
	
	SELECT EncryptedString = @EncryptedString



GO

