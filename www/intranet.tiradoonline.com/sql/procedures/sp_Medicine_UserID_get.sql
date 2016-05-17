IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Medicine_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Medicine_UserID_get;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Medicine_UserID_get]
	@UserID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		MedicineID,
		Medicine =
			CASE 
				WHEN GenericName <> '' THEN
					MedicineName + ' (' + GenericName + ')'
				ELSE
					MedicineName
			END,
		MedicineName,
		GenericName,
		TotalMedicine = (SELECT COUNT(*) FROM Medicine WHERE UserID = @UserID)
	FROM
		Medicine
	WHERE
		UserID = @UserID
	ORDER BY
		MedicineName
	
		
END



GO

