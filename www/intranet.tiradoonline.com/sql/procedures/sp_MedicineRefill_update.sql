IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineRefill_update' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineRefill_update;
GO



 CREATE PROCEDURE [dbo].[sp_MedicineRefill_update] 
	@MedicineRefillID				INT,
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
	
	UPDATE MedicineRefill SET
		MedicineID = @MedicineID, 
		DoctorID = @DoctorID, 
		PharmacyID = @PharmacyID, 
		RefillOrderDate = @RefillOrderDate, 
		RefillOrderPickupDate = @RefillOrderPickupDate, 
		RefillDateFilled = @RefillDateFilled, 
		RefillAmount = @RefillAmount,
		DailyAmount = @DailyAmount, 
		RefillTimes = @RefillTimes, 
		RefillUntilDate = @RefillUntilDate, 
		RefillDiscardDate = @RefillDiscardDate, 
		RefillDescription = @RefillDescription
	WHERE
		MedicineRefillID = @MedicineRefillID;



GO

