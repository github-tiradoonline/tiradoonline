IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineDose_insert' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineDose_insert;
GO



CREATE PROCEDURE [dbo].[sp_MedicineDose_insert]
	@MedicineDoseDateTime		DATETIME, 
	@MedicineID			INT, 
	@Amount				NUMERIC(9,2), 
	@MedicineDoseDescription		varchar(2000) 
AS
	
	INSERT INTO MedicineDose
		(MedicineDoseDateTime, MedicineID, Amount, MedicineDoseDescription)
	VALUES
		(@MedicineDoseDateTime, @MedicineID, @Amount, @MedicineDoseDescription)

	SELECT @@IDENTITY;



GO

