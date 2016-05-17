IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineRefill_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineRefill_UserID_get;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MedicineRefill_UserID_get]
	@UserID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		MedicineRefillID,
		a.MedicineID,
		Medicine =
			CASE 
				WHEN b.GenericName <> '' THEN
					b.MedicineName + ' (' + b.GenericName + ')'
				ELSE
					b.MedicineName
			END,
		NextRefillDate = DATEADD(DAY, RefillAmount / DailyAmount, RefillDateFilled),
		DoctorName = (
				SELECT
					CASE 
						WHEN FirstName <> '' THEN
							LastName + ', ' + FirstName
						ELSE
							LastName
					END
				FROM
					Doctor
				WHERE 
					DoctorID = a.DoctorID
			    ),
		PharmacyName = (SELECT PharmacyName FROM Pharmacy WHERE PharmacyID = a.PharmacyID),
		b.PrescriptionNumber,
		a.RefillOrderDate,
		a.RefillOrderPickupDate,
		a.RefillDateFilled,
		RefillAmount = CONVERT(VARCHAR, a.RefillAmount) + ' ' + c.UnitName,
		a.DailyAmount,
		a.RefillTimes,
		a.RefillUntilDate,
		a.RefillDiscardDate,
		a.RefillDescription
	FROM
		MedicineRefill a,
		Medicine b,
		Unit c
	WHERE
		a.MedicineID = b.MedicineID AND
		b.UnitID = c.UnitID AND
		b.UserID = @UserID
	ORDER BY
		a.RefillOrderPickupDate
	DESC;
	
		
END



GO

