IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Companies_CompanyID_CompanyName' AND TYPE = 'P')
DROP PROCEDURE sp_Companies_CompanyID_CompanyName;
GO


CREATE PROCEDURE [dbo].[sp_Companies_CompanyID_CompanyName]
	@UserID		INT
AS
	SELECT CompanyID, CompanyName FROM Companies WHERE UserID = @UserID ORDER BY CompanyName


GO

