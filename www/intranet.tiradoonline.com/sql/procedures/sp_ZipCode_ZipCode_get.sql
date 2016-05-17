IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ZipCode_ZipCode_get' AND TYPE = 'P')
	DROP PROCEDURE sp_ZipCode_ZipCode_get;
GO

CREATE PROCEDURE sp_ZipCode_ZipCode_get
	@ZipCode		VARCHAR(20)
AS
	
	SELECT
		* 
	FROM
		ZipCode
	WHERE
		ZipCode = @ZipCode;

GO

EXEC sp_ZipCode_ZipCode_get '07030'