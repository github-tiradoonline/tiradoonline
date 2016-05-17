IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timesheet_Invoice_generate' AND TYPE = 'P')
DROP PROCEDURE sp_Timesheet_Invoice_generate;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Timesheet_Invoice_generate]
	@TimesheetID		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	SELECT
		FullName = d.FirstName + ' ' + d.LastName,
		HomeAddress1 = d.Address1,
		HomeAddress2 = d.Address2,
		HomeCity = d.City,
		HomeState = (SELECT StateAbbr FROM States WHERE StateID = d.StateID),
		HomeZipCode = d.ZipCode,
		HomePhone = d.Phone,

		InvoiceDate = a.TimesheetInvoiceDate,
		InvoiceNumber = a.TimesheetInvoiceNumber,
		HourlyRate = a.TimesheetHourlyRate,
		CompanyName = b.TimesheetCompanyName,
		CompanyAddress1 = b.TimesheetCompanyAddress1,
		CompanyAddress2 = b.TimesheetCompanyAddress2,
		CompanyCity = b.TimesheetCompanyCity,
		CompanyState = (SELECT StateAbbr FROM States WHERE StateID = b.TimesheetCompanyStateID),
		CompanyZipCode = b.TimesheetCompanyZipCode,
		CompanyPhone = b.TimesheetCompanyPhone,

		TimesheetType = e.TimesheetType, 
		TimesheetDate = c.TimesheetDetailDate,
		TimesheetHours = c.TimesheetHours,
		TimesheetDescription = c.TimesheetDescription
	FROM
		Timesheet a,
		TimesheetCompany b,
		TimesheetDetail c,
		Users d,
		TimesheetType e
	WHERE
		a.TimesheetID = @TimesheetID AND
		a.TimesheetCompanyID = b.TimesheetCompanyID AND
		a.TimesheetID = c.TimesheetID AND
		a.TimesheetTypeID = e.TimesheetTypeID AND
		b.UserID = d.UserID
END



GO

EXEC sp_Timesheet_Invoice_generate 1039