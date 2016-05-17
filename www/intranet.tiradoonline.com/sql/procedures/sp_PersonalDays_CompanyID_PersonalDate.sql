IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_PersonalDays_CompanyID_PersonalDate' AND TYPE = 'P')
DROP PROCEDURE sp_PersonalDays_CompanyID_PersonalDate;
GO


CREATE PROCEDURE [dbo].[sp_PersonalDays_CompanyID_PersonalDate]
	@CompanyID	INT,
	@PersonalDate	SMALLDATETIME
AS
	SELECT 
		PersonalDayID 
	FROM 
		PersonalDays 
	WHERE 
		CompanyID = @CompanyID AND 
		PersonalDate = @PersonalDate


GO

