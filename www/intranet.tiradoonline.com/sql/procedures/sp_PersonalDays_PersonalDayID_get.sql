IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_PersonalDays_PersonalDayID_get' AND TYPE = 'P')
DROP PROCEDURE sp_PersonalDays_PersonalDayID_get;
GO


CREATE PROCEDURE [dbo].[sp_PersonalDays_PersonalDayID_get]
	@PersonalDayID		INT
AS
	SELECT 
		a.PersonalDayID,
		a.CompanyID, 
		b.CompanyName,
		a.PersonalDate 
	FROM 
		Personaldays a,
		Companies b
	WHERE 
		a.CompanyID = b.CompanyID AND
		a.PersonalDayID = @PersonalDayID


GO

