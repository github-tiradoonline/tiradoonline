IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Users_reports' AND TYPE = 'P')
DROP PROCEDURE sp_Users_reports;
GO


ID IN (SELECT CompanyID FROM Companies WHERE UserID = a.UserID)),
		
				PersonalDays = (SELECT COUNT(*) FROM PersonalDays WHERE CompanyID IN (SELECT CompanyID FROM Companies WHERE UserID = a.UserID)),
		
				PersonalInformation = (SELECT COUNT(*) FROM PersonalInformation WHERE UserID = a.UserID),
		
				PhoneCall = (SELECT COUNT(*) FROM PhoneCall WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = a.UserID)),
		
				RecoveryCounselors = (SELECT COUNT(*) FROM RecoveryCounselors WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = a.UserID)),
		
				RecoveryGroups = (SELECT COUNT(*) FROM RecoveryGroups WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = a.UserID)),
		
				RecoveryGroupSessions = (SELECT COUNT(*) FROM RecoveryGroupSessions WHERE RecoveryGroupID IN (SELECT RecoveryGroupID FROM RecoveryGroups WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = a.UserID))),
		
				RecoveryPrograms = (SELECT COUNT(*) FROM RecoveryPrograms WHERE UserID = a.UserID),
		
				Reminders = (SELECT COUNT(*) FROM Reminders WHERE UserID = a.UserID),
		
				ResumeFile = (SELECT COUNT(*) FROM ResumeFile WHERE UserID = a.UserID),
		
				ResumeQueue = (SELECT COUNT(*) FROM ResumeQueue WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = a.UserID)),
		
				ResumeText = (SELECT COUNT(*) FROM ResumeText WHERE UserID = a.UserID),
		
				Settings = (SELECT COUNT(*) FROM Settings WHERE UserID = a.UserID),
		
				SickDays = (SELECT COUNT(*) FROM SickDays WHERE CompanyID IN (SELECT CompanyID FROM Companies WHERE UserID = a.UserID)),
		
				Snippets = (SELECT COUNT(*) FROM Snippets WHERE SnippetGroupID IN (SELECT SnippetGroupID FROM SnippetGroups WHERE UserID = a.UserID)),
		
				SnippetGroups = (SELECT COUNT(*) FROM SnippetGroups WHERE UserID = a.UserID),
		
				SQLScripts = (SELECT COUNT(*) FROM SQLScripts WHERE UserID = a.UserID),
		
				Sugar = (SELECT COUNT(*) FROM Sugar WHERE UserID = a.UserID),
		
				Temperature = (SELECT COUNT(*) FROM Temperature WHERE UserID = a.UserID),
		
				Test = (SELECT COUNT(*) FROM Test WHERE UserID = a.UserID),
		
				TestType = (SELECT COUNT(*) FROM TestType WHERE UserID = a.UserID),
		
				TimeSheet = (SELECT COUNT(*) FROM TimeSheet WHERE TimeSheetCompanyID IN (SELECT TimeSheetCompanyID FROM TimeSheetCompany WHERE UserID = a.UserID)),
		
				TimeSheetCompany = (SELECT COUNT(*) FROM TimeSheetCompany WHERE UserID = a.UserID),
		
				TimeSheetDetail = (SELECT COUNT(*) FROM TimeSheetDetail WHERE TimeSheetID IN (SELECT TimeSheetID FROM TimeSheet WHERE TimesheetCompanyID IN (SELECT TimesheetCompanyID FROM TimesheetCompany WHERE UserID = a.UserID))),
		
				TimeSheetPayment = (SELECT COUNT(*) FROM TimeSheetPayment WHERE TimeSheetCompanyID IN (SELECT TimeSheetCompanyID FROM TimeSheetCompany WHERE UserID = a.UserID)),
		
				Unit = (SELECT COUNT(*) FROM Unit WHERE UserID = a.UserID),

				a.create_dt
			FROM
				Users a;

		END


GO

