IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_HospitalStaff_Search_HospitalID_get' AND TYPE = 'P')
DROP PROCEDURE sp_HospitalStaff_Search_HospitalID_get;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HospitalStaff_Search_HospitalID_get]
	@HospitalID			INT,
	@StaffName		VARCHAR(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @StaffName = '%' + @StaffName + '%';

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
		b.HospitalPositionID = c.HospitalPositionID AND
		(
			a.HospitalName LIKE @StaffName OR
			c.FirstName LIKE @StaffName OR
			c.LastName LIKE @StaffName
		)
	ORDER BY
		Position,
		FullName;
	
		
END



GO

exec sp_HospitalStaff_Search_HospitalID_get 1001, 't'