IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Users_delete' AND TYPE = 'P')
DROP PROCEDURE sp_Users_delete;
GO


CREATE PROCEDURE [dbo].[sp_Users_delete]
	@UserID				INT
AS

	BEGIN TRANSACTION

		BEGIN

			DELETE FROM Accounts WHERE UserID = @UserID;

			DELETE FROM Artists WHERE UserID = @UserID;

			DELETE FROM Backups WHERE UserID = @UserID;

			DELETE FROM Banking WHERE BankingAccountID IN (SELECT BankingAccountID FROM BankingAccount WHERE UserID = @UserID);
			DELETE FROM BankingAccount WHERE UserID = @UserID;

			DELETE FROM CompanyAddress WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID);
			DELETE FROM CompanyContact WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID);
			DELETE FROM PhoneCall WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID);
			DELETE FROM Interview WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID);
			DELETE FROM ResumeQueue WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID);
			DELETE FROM Company WHERE UserID = @UserID;
			DELETE FROM ResumeFile WHERE UserID = @UserID;
			DELETE FROM ResumeText WHERE UserID = @UserID;

			DELETE FROM Contacts WHERE UserID = @UserID;

			DELETE FROM CreditCard WHERE UserID = @UserID;

			DELETE FROM HeartRate WHERE UserID = @UserID;
			DELETE FROM MedicineDose WHERE MedicineID IN (SELECT MedicineID FROM Medicine WHERE UserID = @UserID);
			DELETE FROM Medicine WHERE UserID = @UserID;
			DELETE FROM Logins WHERE UserID = @UserID;
			DELETE FROM TestType WHERE UserID = @UserID;
			DELETE FROM Test WHERE UserID = @UserID;
			DELETE FROM Unit WHERE UserID = @UserID;

			DELETE FROM RecoveryGroupSessions WHERE RecoveryGroupID IN (SELECT RecoveryGroupID FROM RecoveryGroups WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = @UserID));
			DELETE FROM RecoveryCounselors WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = @UserID);
			DELETE FROM RecoveryGroups WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = @UserID);
			DELETE FROM RecoveryPrograms WHERE UserID = @UserID;

			DELETE FROM Settings WHERE UserID = @UserID;

			DELETE FROM Snippets WHERE SnippetGroupID IN (SELECT SnippetGroupID FROM SnippetGroups WHERE UserID = @UserID);
			DELETE FROM SnippetGroups WHERE UserID = @UserID;

			DELETE FROM TimeSheetDetail WHERE TimeSheetID IN (SELECT TimeSheetID FROM TimeSheet WHERE TimesheetCompanyID IN (SELECT TimesheetCompanyID FROM TimesheetCompany WHERE UserID = @UserID));
			DELETE FROM TimeSheetPayment WHERE TimeSheetCompanyID IN (SELECT TimeSheetCompanyID FROM TimeSheetCompany WHERE UserID = @UserID);
			DELETE FROM TimeSheet WHERE TimeSheetCompanyID IN (SELECT TimeSheetCompanyID FROM TimeSheetCompany WHERE UserID = @UserID);
			DELETE FROM TimeSheetCompany WHERE UserID = @UserID;

			DELETE FROM Users WHERE UserID = @UserID;
			
		END

	IF @@ERROR > 0
		ROLLBACK TRANSACTION;
	ELSE
		COMMIT TRANSACTION;




GO

