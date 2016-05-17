IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Companies_UserID' AND TYPE = 'P')
DROP PROCEDURE sp_Companies_UserID;
GO


CREATE PROCEDURE [dbo].[sp_Companies_UserID]
	@UserID		INT
AS
	SELECT 
        	CompanyID,
                CompanyName
	FROM
		Companies 
	WHERE 
		UserID = @UserID


GO

