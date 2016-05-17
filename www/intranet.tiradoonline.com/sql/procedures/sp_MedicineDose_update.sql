IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineDose_update' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineDose_update;
GO


CREATE PROCEDURE sp_MedicineDose_update 
	@MedicineDoseID					INT,
	@MedicineDoseDateTime				DATETIME,
	@MedicineID					INT,
	@Amount						NUMERIC(9,2),
	@MedicineDoseDescription			VARCHAR(2000)
AS
	
	UPDATE MedicineDose SET
		MedicineDoseDateTime = @MedicineDoseDateTime,
		MedicineID = @MedicineID,		
		Amount = @Amount,
		MedicineDoseDescription = @MedicineDoseDescription
	WHERE
		MedicineDoseID =  @MedicineDoseID;					



GO

