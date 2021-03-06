IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_HospitalStaff_HospitalID_get' AND TYPE = 'P')
DROP PROCEDURE sp_HospitalStaff_HospitalID_get;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HospitalStaff_HospitalID_get]
	@HospitalID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		c.HospitalStaffID,
		Hospital = a.HospitalName,
		Position = b.HospitalPositionName,
		FullName =
			CASE 
				WHEN c.FirstName <> '' AND c.LastName <> '' THEN
					c.LastName + ', ' + c.FirstName
				WHEN c.FirstName <> '' AND c.LastName = '' THEN
					c.FirstName
				WHEN c.LastName <> '' THEN
					c.LastName
				ELSE
					c.LastName
			END
	FROM
		Hospital a,
		HospitalPosition b,
		HospitalStaff c
	WHERE
		c.HospitalID = @HospitalID AND
		a.HospitalID = c.HospitalID AND
		b.HospitalPositionID = c.HospitalPositionID
	ORDER BY
		Position,
		FullName;
	
		
END



GO

