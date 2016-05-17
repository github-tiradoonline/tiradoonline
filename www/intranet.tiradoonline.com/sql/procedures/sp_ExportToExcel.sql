IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ExportToExcel' AND TYPE = 'P')
	DROP PROCEDURE sp_ExportToExcel;
GO

CREATE PROCEDURE sp_ExportToExcel
AS

	DECLARE @Counter		INT;
	SET @Counter = 1001;
	
	IF NOT EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ExportToExcel' AND TYPE = 'U')
		BEGIN

			CREATE TABLE ExportToExcel
			(
				Counter		INT NOT NULL
			);

			INSERT INTO ExportToExcel
				(Counter)
			VALUES
				(@Counter);

		END
	ELSE
		BEGIN
			SELECT @Counter = Counter + 1 FROM ExportToExcel;
			
			UPDATE ExportToExcel SET 
				Counter = @Counter;
			
		END
	

	SELECT @Counter;			

GO

EXEC sp_ExportToExcel
