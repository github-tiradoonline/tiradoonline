IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_SickDays_get' AND TYPE = 'P')
DROP PROCEDURE sp_SickDays_get;
GO


CREATE PROCEDURE [dbo].[sp_SickDays_get]
	@UserID		INT
AS
	SELECT 
		b.CompanyID, 
		b.CompanyName, 
		a.SickDate 
	FROM 
		SickDays a, 
		Companies b 
	WHERE 
		a.CompanyID = b.CompanyID AND 
		b.UserID = @UserID
	ORDER BY 
		a.SickDate DESC, 
		b.CompanyName


GO

