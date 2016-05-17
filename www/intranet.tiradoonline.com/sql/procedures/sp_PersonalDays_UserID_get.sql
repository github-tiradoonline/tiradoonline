IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_PersonalDays_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_PersonalDays_UserID_get;
GO


CREATE PROCEDURE [dbo].[sp_PersonalDays_UserID_get]
	@UserID		INT
AS
	SELECT 
		a.PersonalDayID,
		b.CompanyID, 
		b.CompanyName, 
		a.PersonalDate 
	FROM 
		Personaldays a, 
		Companies b 
	WHERE 
		a.CompanyID = b.CompanyID AND 
		b.UserID = @UserID
	ORDER BY 
		a.PersonalDate DESC, 
		b.CompanyName


GO

