IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Doctor_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Doctor_UserID_get;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Doctor_UserID_get]
	@UserID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		DoctorID,
		DoctorName =
			CASE 
				WHEN FirstName <> '' THEN
					LastName + ', ' + FirstName
				ELSE
					LastName
			END,
		FirstName,
		LastName,
		TelephoneNumber,
		TotalDoctors = (SELECT COUNT(*) FROM Doctor WHERE UserID = @UserID)
	FROM
		Doctor
	WHERE
		UserID = @UserID
	ORDER BY
		DoctorName
	
		
END



GO

