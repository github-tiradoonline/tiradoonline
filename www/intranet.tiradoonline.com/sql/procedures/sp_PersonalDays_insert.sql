IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_PersonalDays_insert' AND TYPE = 'P')
DROP PROCEDURE sp_PersonalDays_insert;
GO


CREATE PROCEDURE [dbo].[sp_PersonalDays_insert]
	@CompanyID	INT,
	@PersonalDate	SMALLDATETIME
AS
	INSERT INTO Personaldays 
		(CompanyID, PersonalDate) 
	VALUES 
		(@CompanyID, @PersonalDate);


GO

