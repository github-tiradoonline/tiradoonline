IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Jobs_JobCompanyID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Jobs_JobCompanyID_get;
GO



CREATE PROCEDURE [dbo].[sp_Jobs_JobCompanyID_get]
	@JobCompanyID				INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		*,
		JobStateName = (SELECT State FROM States WHERE StateID = Jobs.JobStateID)
	FROM
		Jobs
	WHERE
		JobCompanyID = @JobCompanyID
	ORDER BY 
		JobDate DESC;

END




GO

