IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Companies_get_CompanyID' AND TYPE = 'P')
DROP PROCEDURE sp_Companies_get_CompanyID;
GO


CREATE PROCEDURE [dbo].[sp_Companies_get_CompanyID]
	@CompanyID	INT
AS
	SELECT 
		CompanyID, 
		CompanyName,
		StartDate,
		EndDate
	FROM 
		Companies 
	WHERE 
		CompanyID = @CompanyID



GO

