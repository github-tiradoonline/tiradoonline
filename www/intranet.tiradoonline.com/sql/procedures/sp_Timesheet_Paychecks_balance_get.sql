IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timesheet_Paychecks_balance_get' AND TYPE = 'P')
DROP PROCEDURE sp_Timesheet_Paychecks_balance_get;
GO

CREATE PROCEDURE [dbo].[sp_Timesheet_Paychecks_balance_get]
	@TimesheetCompanyID				INT
AS


	CREATE TABLE #PaycheckTransactions
	(
		PaycheckTransactionID		INT,
		PaycheckTransactionDate		DATETIME NOT NULL,
		PaycheckTransaction		VARCHAR(200) NOT NULL,
		PaycheckTransactionAmount	NUMERIC(9, 2) NOT NULL
	);

	INSERT INTO #PaycheckTransactions
		(PaycheckTransactionID, PaycheckTransactionDate, PaycheckTransaction, PaycheckTransactionAmount)
			SELECT 
				PaycheckID,
				PaymentDate,
				'Paycheck',
				Gross = (Gross - Federal - SocialSecurity - Medicare - NY_Withholding - NY_Disability - NY_City)
			FROM
				Paychecks
			WHERE
				TimesheetCompanyID = @TimesheetCompanyID;

	INSERT INTO #PaycheckTransactions
		(PaycheckTransactionID, PaycheckTransactionDate, PaycheckTransaction, PaycheckTransactionAmount)
			SELECT 
				a.TimesheetID,
				a.TimesheetInvoiceDate,
				'Invoice#: ' + CONVERT(VARCHAR(20), a.TimesheetInvoiceNumber),
				TimesheetAmount = (SELECT Total = (a.TimesheetHourlyRate * SUM(TimesheetHours)) - (2 * (a.TimesheetHourlyRate * SUM(TimesheetHours))) FROM TimesheetDetail WHERE TimesheetID = a.TimesheetID AND TimesheetBillable = 1)
			FROM
				Timesheet a
			WHERE
				a.TimesheetCompanyID = @TimesheetCompanyID;

	SELECT * FROM #PaycheckTransactions ORDER BY PaycheckTransactionDate;

GO

EXEC sp_Timesheet_Paychecks_balance_get 1051