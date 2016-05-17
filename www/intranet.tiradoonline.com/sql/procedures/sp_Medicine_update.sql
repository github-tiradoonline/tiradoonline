IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Medicine_update' AND TYPE = 'P')
DROP PROCEDURE sp_Medicine_update;
GO



CREATE PROCEDURE [dbo].[sp_Medicine_update] 
	@MedicineID			INT,
	@MedicineName 			VARCHAR(50),
	@GenericName 			VARCHAR(50),
	@PrescriptionNumber		VARCHAR(30), 
	@UnitID				INT,
	@MedicineDescription		VARCHAR(MAX)
AS
	
	UPDATE Medicine SET
		MedicineName = @MedicineName, 
		GenericName = @GenericName, 
		PrescriptionNumber = @PrescriptionNumber, 
		UnitID = @UnitID, 
		MedicineDescription = @MedicineDescription
	WHERE
		MedicineID = @MedicineID;



GO

