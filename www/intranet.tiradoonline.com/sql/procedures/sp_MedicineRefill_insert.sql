IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineRefill_insert' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineRefill_insert;
GO



CREATE PROCEDURE [dbo].[sp_MedicineRefill_insert] 
	@MedicineID				INT, 
	@DoctorID				INT, 
	@PharmacyID				INT, 
	@RefillOrderDate			DATETIME, 
	@RefillOrderPickupDate			DATETIME, 
	@RefillDateFilled			DATETIME, 
	@RefillAmount				NUMERIC(9,2), 
	@DailyAmount				NUMERIC(9,2), 
	@RefillTimes				INT, 
	@RefillUntilDate			DATETIME, 
	@RefillDiscardDate			DATETIME, 
	@RefillDescription			VARCHAR(5000)
AS
	
	INSERT INTO MedicineRefill
		(MedicineID, DoctorID, PharmacyID, RefillOrderDate, RefillOrderPickupDate, RefillDateFilled, RefillAmount, DailyAmount, RefillTimes, RefillUntilDate, RefillDiscardDate, RefillDescription)
	VALUES
		(@MedicineID, @DoctorID, @PharmacyID, @RefillOrderDate, @RefillOrderPickupDate, @RefillDateFilled, @RefillAmount, @DailyAmount, @RefillTimes, @RefillUntilDate, @RefillDiscardDate, @RefillDescription)

	SELECT @@IDENTITY;



GO

