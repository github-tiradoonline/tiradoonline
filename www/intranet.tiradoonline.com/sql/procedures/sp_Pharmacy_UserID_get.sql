IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Pharmacy_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Pharmacy_UserID_get;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Pharmacy_UserID_get]
	@UserID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		PharmacyID,
		PharmacyName,
		PharmacyAddress,
		PharmacyCity,
		PharmacyStateID,
		PharmacyState = (SELECT State FROM States WHERE StateID = Pharmacy.PharmacyStateID),
		PharmacyZipCode,
		PharmacyTelephoneNumber,
		TotalPharmacys = (SELECT COUNT(*) FROM Pharmacy WHERE UserID = @UserID)
	FROM
		Pharmacy
	WHERE
		UserID = @UserID
	ORDER BY
		PharmacyName
	
		
END



GO

