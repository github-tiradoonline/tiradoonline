IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompanyContact_JobCompanyID_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompanyContact_JobCompanyID_get;
GO



CREATE PROCEDURE [dbo].[sp_JobCompanyContact_JobCompanyID_get]
	@JobCompanyID				INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		JobCompanyContactID,
		JobCompanyContactName = 
			CASE 
				WHEN JobCompanyContactFirstName <> '' AND JobCompanyContactLastName = '' THEN
					JobCompanyContactFirstName
				WHEN JobCompanyContactFirstName = '' AND JobCompanyContactLastName <> '' THEN
					JobCompanyContactLastName
				ELSE
					JobCompanyContactLastName + ', ' + JobCompanyContactFirstName
			END,
		*
	FROM
		JobCompanyContact
	WHERE
		JobCompanyID = @JobCompanyID
	ORDER BY 
		JobCompanyContactID DESC;

END




GO

