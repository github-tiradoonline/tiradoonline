IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Companies_get' AND TYPE = 'P')
DROP PROCEDURE sp_Companies_get;
GO




CREATE PROCEDURE [dbo].[sp_Companies_get]
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

