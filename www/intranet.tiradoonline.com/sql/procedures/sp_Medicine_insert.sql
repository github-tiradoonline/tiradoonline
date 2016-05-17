IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Medicine_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Medicine_insert;
GO



CREATE PROCEDURE [dbo].[sp_Medicine_insert] 
	@UserID				INT,
	@MedicineName 			VARCHAR(50),
	@GenericName 			VARCHAR(50),
	@PrescriptionNumber		VARCHAR(30), 
	@UnitID				INT,
	@MedicineDescription		VARCHAR(MAX)
AS
	
	INSERT INTO Medicine 
		(UserID, MedicineName, GenericName, PrescriptionNumber, UnitID, MedicineDescription)
	VALUES
		(@UserID, @MedicineName, @GenericName, @PrescriptionNumber, @UnitID, @MedicineDescription)

	SELECT @@IDENTITY;



GO

