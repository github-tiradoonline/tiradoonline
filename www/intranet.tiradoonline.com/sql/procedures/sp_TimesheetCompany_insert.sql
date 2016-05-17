IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_TimesheetCompany_insert' AND TYPE = 'P')
DROP PROCEDURE sp_TimesheetCompany_insert;
GO




CREATE PROCEDURE [dbo].[sp_TimesheetCompany_insert]
	@UserID				INT,
	@TimesheetCompanyName		VARCHAR(100),
	@TimesheetCompanyAddress1	VARCHAR(100),
	@TimesheetCompanyAddress2	VARCHAR(100),
	@TimesheetCompanyCity		VARCHAR(100),
	@TimesheetCompanyStateID	INT,
	@TimesheetCompanyZipCode	VARCHAR(20),
	@TimesheetCompanyPhone		VARCHAR(100)
AS
	
	
	INSERT INTO TimesheetCompany 
		(UserID, TimesheetCompanyName, TimesheetCompanyAddress1, TimesheetCompanyAddress2, TimesheetCompanyCity, TimesheetCompanyStateID, TimesheetCompanyZipCode, TimesheetCompanyPhone) 
	VALUES
		(@UserID, @TimesheetCompanyName, @TimesheetCompanyAddress1, @TimesheetCompanyAddress2, @TimesheetCompanyCity, @TimesheetCompanyStateID, @TimesheetCompanyZipCode, dbo.fn_FormatPhoneNumber(@TimesheetCompanyPhone)); 

	SELECT @@IDENTITY;


GO

