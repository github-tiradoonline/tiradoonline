IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompany_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompany_UserID_get;
GO



CREATE PROCEDURE [dbo].[sp_JobCompany_UserID_get]
	@UserID				INT
AS

	SELECT
		JobCompanyID,
		JobCompanyName
	FROM
		JobCompany
	WHERE
		UserID = @UserID
	ORDER BY
		JobCompanyName;





GO

