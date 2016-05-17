IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_PersonalDays_update' AND TYPE = 'P')
DROP PROCEDURE sp_PersonalDays_update;
GO


CREATE PROCEDURE [dbo].[sp_PersonalDays_update]
	@PersonalDayID	INT,
	@CompanyID	INT,
	@PersonalDate	SMALLDATETIME
AS
	UPDATE Personaldays SET
		CompanyID = @CompanyID,
		PersonalDate = @PersonalDate
	WHERE
		PersonalDayID = @PersonalDayID;	


GO

