ALTER TABLE Artists ADD CONSTRAINT FK_Artists_Movies FOREIGN KEY (MovieID) REFERENCES Movies(MovieID);
GO

ALTER TABLE Artists ADD CONSTRAINT FK_Artists_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Backups ADD CONSTRAINT FK_Backups_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Backups ADD CONSTRAINT FK_Backups_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Banking ADD CONSTRAINT FK_Balance_BalanceAccounts2 FOREIGN KEY (BankingAccountID) REFERENCES BankingAccount(BankingAccountID);
GO

ALTER TABLE Banking ADD CONSTRAINT FK_Balance_Transactions FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID);
GO

ALTER TABLE BankingAccount ADD CONSTRAINT FK_BalanceAccounts_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE BankingAccount ADD CONSTRAINT FK_BalanceAccounts_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE BankingAccountEmail ADD CONSTRAINT FK_BalanceAccountsEmail_BalanceAccounts FOREIGN KEY (BankingAccountID) REFERENCES BankingAccount(BankingAccountID);
GO

ALTER TABLE BankingAccountLinked ADD CONSTRAINT FK_BalanceAccountsLinked_BalanceAccounts FOREIGN KEY (BankingAccountID) REFERENCES BankingAccount(BankingAccountID);
GO

ALTER TABLE BankingEmail ADD CONSTRAINT FK_BalanceEmail_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE BankingEmail ADD CONSTRAINT FK_BalanceEmail_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE BloodPressure ADD CONSTRAINT FK_BloodPressure_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE CCBalance ADD CONSTRAINT FK_CCBalance_CreditCard FOREIGN KEY (CCID) REFERENCES CreditCard_old(CCID);
GO

ALTER TABLE Contacts ADD CONSTRAINT FK_Contacts_old_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE CreditCard ADD CONSTRAINT FK_CreditCard_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE CreditCard_old ADD CONSTRAINT FK_CreditCard_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Doctor ADD CONSTRAINT FK_Doctor_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Emails ADD CONSTRAINT FK_Emails_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE EmailTemplates ADD CONSTRAINT FK_EmailTemplates_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE HeartRate ADD CONSTRAINT FK_HeartRate_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE HeartRate ADD CONSTRAINT FK_HeartRate_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Hospital ADD CONSTRAINT FK_Hospital_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE HospitalPosition ADD CONSTRAINT FK_HospitalPostion_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE HospitalStaff ADD CONSTRAINT FK_HospitalStaff_Hospital FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID);
GO

ALTER TABLE HospitalStaff ADD CONSTRAINT FK_HospitalStaff_HospitalPosition FOREIGN KEY (HospitalPositionID) REFERENCES HospitalPosition(HospitalPositionID);
GO

ALTER TABLE Hours ADD CONSTRAINT FK_Hours_Companies FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID);
GO

ALTER TABLE Insulin ADD CONSTRAINT FK_Insulin_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE JobCompany ADD CONSTRAINT FK_Company_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE JobCompanyAddress ADD CONSTRAINT FK_CompanyAddress_Company FOREIGN KEY (JobCompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE JobCompanyContact ADD CONSTRAINT FK_CompanyContact_Company FOREIGN KEY (JobCompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE JobCompanyPhoneCall ADD CONSTRAINT FK_JobCompanyPhoneCall_JobCompany FOREIGN KEY (JobCompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE JobCoverLetter ADD CONSTRAINT FK_JobCoverLetter_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE JobEmail ADD CONSTRAINT FK_JobEmail_Jobs FOREIGN KEY (JobID) REFERENCES Jobs(JobID);
GO

ALTER TABLE JobInterview ADD CONSTRAINT FK_Interview_Company FOREIGN KEY (JobCompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE JobInterview ADD CONSTRAINT FK_JobInterview_JobCompany FOREIGN KEY (JobInterviewClientID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE JobInterview ADD CONSTRAINT FK_JobInterview_JobInterviewType FOREIGN KEY (JobInterviewTypeID) REFERENCES JobInterviewType(JobInterviewTypeID);
GO

ALTER TABLE JobQueue ADD CONSTRAINT FK_JobQueue_Jobs FOREIGN KEY (JobID) REFERENCES Jobs(JobID);
GO

ALTER TABLE Jobs ADD CONSTRAINT FK_Jobs_JobCompanyContact1 FOREIGN KEY (JobCompanyContactID) REFERENCES JobCompanyContact(JobCompanyContactID);
GO

ALTER TABLE Jobs ADD CONSTRAINT FK_Jobs_JobCompany1 FOREIGN KEY (JobCompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE Logins ADD CONSTRAINT FK_Logins_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Lyric ADD CONSTRAINT FK_Lyric_LyricType FOREIGN KEY (LyricTypeID) REFERENCES LyricType(LyricTypeID);
GO

ALTER TABLE Lyric ADD CONSTRAINT FK_Lyric_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Medicine ADD CONSTRAINT FK_Medicine_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE MedicineDose ADD CONSTRAINT FK_MedicineDose_Medicine FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID);
GO

ALTER TABLE MedicineDosePackage ADD CONSTRAINT FK_MedicineDosePackage_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE MedicineDosePackageItem ADD CONSTRAINT FK_MedicineDosePackageItem_MedicineDosePackage FOREIGN KEY (MedicineDosePackageID) REFERENCES MedicineDosePackage(MedicineDosePackageID);
GO

ALTER TABLE MedicineDosePackageItem ADD CONSTRAINT FK_MedicineDosePackageItem_Medicine FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID);
GO

ALTER TABLE MedicineRefill ADD CONSTRAINT FK_MedicineRefill_Doctor FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID);
GO

ALTER TABLE MedicineRefill ADD CONSTRAINT FK_MedicineRefill_Medicine FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID);
GO

ALTER TABLE MedicineRefill ADD CONSTRAINT FK_MedicineRefill_Pharamacy FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID);
GO

ALTER TABLE MonthlyBills ADD CONSTRAINT FK_MonthlyBills_BalanceAccounts FOREIGN KEY (BankingAccountID) REFERENCES BankingAccount(BankingAccountID);
GO

ALTER TABLE Movies ADD CONSTRAINT FK_Movies_Genre FOREIGN KEY (GenreID) REFERENCES Genre(GenreID);
GO

ALTER TABLE Movies ADD CONSTRAINT FK_Movies_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Notes_old ADD CONSTRAINT FK_Notes_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE PersonalDays ADD CONSTRAINT FK_PersonalDays_Companies FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID);
GO

ALTER TABLE PersonalInformation ADD CONSTRAINT FK_PersonalInformation_PersonalInformationCards FOREIGN KEY (CCTypeID) REFERENCES PersonalInformationCards(PersonalInformationCardID);
GO

ALTER TABLE PersonalInformation ADD CONSTRAINT FK_PersonalInformation_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Pharmacy ADD CONSTRAINT FK_Pharamacy_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Pharmacy ADD CONSTRAINT FK_Pharamacy_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE POP3Email ADD CONSTRAINT FK_POP3Email_POP3EmailFolder FOREIGN KEY (POP3EmailFolderID) REFERENCES POP3EmailFolder(POP3EmailFolderID);
GO

ALTER TABLE POP3EmailAccount ADD CONSTRAINT FK_POP3EmailAccount_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE POP3EmailFolder ADD CONSTRAINT FK_POP3EmailFolder_POP3EmailAccount FOREIGN KEY (POP3EmailAccountID) REFERENCES POP3EmailAccount(POP3EmailAccountID);
GO

ALTER TABLE POP3EmailRule ADD CONSTRAINT FK_POP3EmailRule_POP3EmailAccount FOREIGN KEY (POP3EmailAccountID) REFERENCES POP3EmailAccount(POP3EmailAccountID);
GO

ALTER TABLE POP3EmailRule ADD CONSTRAINT FK_POP3EmailRule_POP3EmailFolder FOREIGN KEY (POP3EmailFolderID) REFERENCES POP3EmailFolder(POP3EmailFolderID);
GO

ALTER TABLE RecoveryCounselors ADD CONSTRAINT FK_RecoveryCounselors_RecoveryPrograms FOREIGN KEY (RecoveryProgramID) REFERENCES RecoveryPrograms(RecoveryProgramID);
GO

ALTER TABLE RecoveryGroups ADD CONSTRAINT FK_RecoveryGroups_RecoveryPrograms FOREIGN KEY (RecoveryProgramID) REFERENCES RecoveryPrograms(RecoveryProgramID);
GO

ALTER TABLE RecoveryGroupSessions ADD CONSTRAINT FK_RecoveryGroupSessions_RecoveryGroups FOREIGN KEY (RecoveryGroupID) REFERENCES RecoveryGroups(RecoveryGroupID);
GO

ALTER TABLE RecoveryGroupSessions ADD CONSTRAINT FK_RecoveryGroiupSessions_RecoveryGroups FOREIGN KEY (RecoveryGroupID) REFERENCES RecoveryGroups(RecoveryGroupID);
GO

ALTER TABLE RecoveryPrograms ADD CONSTRAINT FK_RecoveryPrograms_RecoveryTypes FOREIGN KEY (RecoveryTypeID) REFERENCES RecoveryTypes(RecoveryTypeID);
GO

ALTER TABLE RecoveryPrograms ADD CONSTRAINT FK_RecoveryPrograms_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE RecoveryUrine ADD CONSTRAINT FK_RecoveryUrine_RecoveryPrograms FOREIGN KEY (RecoveryProgramID) REFERENCES RecoveryPrograms(RecoveryProgramID);
GO

ALTER TABLE Reminders ADD CONSTRAINT FK_Reminders_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE ResumeFile ADD CONSTRAINT FK_ResumeFile_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE ResumeQueue ADD CONSTRAINT FK_ResumeQueue_Company FOREIGN KEY (CompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE ResumeText ADD CONSTRAINT FK_ResumeText_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Settings ADD CONSTRAINT FK_Settings_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE SickDays ADD CONSTRAINT FK_SickDays_Companies FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID);
GO

ALTER TABLE SnippetGroups ADD CONSTRAINT FK_SnippetGroups_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Snippets ADD CONSTRAINT FK_Snippets_SnippetGroups FOREIGN KEY (SnippetGroupID) REFERENCES SnippetGroups(SnippetGroupID);
GO

ALTER TABLE SQLScripts ADD CONSTRAINT FK_SQLScripts_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE SQLScripts ADD CONSTRAINT FK_SQLScripts_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE SQLScripts ADD CONSTRAINT FK_SQLScripts_Users2 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Sugar ADD CONSTRAINT FK_Sugar_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Task ADD CONSTRAINT FK_Task_TaskProject FOREIGN KEY (TaskProjectID) REFERENCES TaskProject(TaskProjectID);
GO

ALTER TABLE TaskProject ADD CONSTRAINT FK_TaskProject_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Temperature ADD CONSTRAINT FK_Temperature_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Test ADD CONSTRAINT FK_Test_TestResult FOREIGN KEY (TestResultID) REFERENCES TestResult(TestResultID);
GO

ALTER TABLE Test ADD CONSTRAINT FK_Test_TestType FOREIGN KEY (TestTypeID) REFERENCES TestType(TestTypeID);
GO

ALTER TABLE TestType ADD CONSTRAINT FK_TestType_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Timesheet ADD CONSTRAINT FK_Timesheet_TimesheetCompany FOREIGN KEY (TimesheetCompanyID) REFERENCES TimesheetCompany(TimeSheetCompanyID);
GO

ALTER TABLE TimesheetCompany ADD CONSTRAINT FK_TimesheetCompany_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE TimesheetDetail ADD CONSTRAINT FK_TimesheetDetail_Timesheet FOREIGN KEY (TimesheetID) REFERENCES Timesheet(TimesheetID);
GO

ALTER TABLE TimesheetPayment ADD CONSTRAINT FK_TimesheetPayment_TimesheetCompany FOREIGN KEY (TimesheetCompanyID) REFERENCES TimesheetCompany(TimeSheetCompanyID);
GO

ALTER TABLE Transactions ADD CONSTRAINT FK_Transactions_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Unit ADD CONSTRAINT FK_Unit_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Weight ADD CONSTRAINT FK_Weight_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Artists ADD CONSTRAINT FK_Artists_Movies FOREIGN KEY (MovieID) REFERENCES Movies(MovieID);
GO

ALTER TABLE Artists ADD CONSTRAINT FK_Artists_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Backups ADD CONSTRAINT FK_Backups_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Backups ADD CONSTRAINT FK_Backups_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Banking ADD CONSTRAINT FK_Balance_BalanceAccounts2 FOREIGN KEY (BankingAccountID) REFERENCES BankingAccount(BankingAccountID);
GO

ALTER TABLE Banking ADD CONSTRAINT FK_Balance_Transactions FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID);
GO

ALTER TABLE BankingAccount ADD CONSTRAINT FK_BalanceAccounts_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE BankingAccount ADD CONSTRAINT FK_BalanceAccounts_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE BankingAccountEmail ADD CONSTRAINT FK_BalanceAccountsEmail_BalanceAccounts FOREIGN KEY (BankingAccountID) REFERENCES BankingAccount(BankingAccountID);
GO

ALTER TABLE BankingAccountLinked ADD CONSTRAINT FK_BalanceAccountsLinked_BalanceAccounts FOREIGN KEY (BankingAccountID) REFERENCES BankingAccount(BankingAccountID);
GO

ALTER TABLE BankingEmail ADD CONSTRAINT FK_BalanceEmail_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE BankingEmail ADD CONSTRAINT FK_BalanceEmail_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE BloodPressure ADD CONSTRAINT FK_BloodPressure_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE CCBalance ADD CONSTRAINT FK_CCBalance_CreditCard FOREIGN KEY (CCID) REFERENCES CreditCard_old(CCID);
GO

ALTER TABLE Contacts ADD CONSTRAINT FK_Contacts_old_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE CreditCard ADD CONSTRAINT FK_CreditCard_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE CreditCard_old ADD CONSTRAINT FK_CreditCard_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Doctor ADD CONSTRAINT FK_Doctor_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Emails ADD CONSTRAINT FK_Emails_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE EmailTemplates ADD CONSTRAINT FK_EmailTemplates_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE HeartRate ADD CONSTRAINT FK_HeartRate_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE HeartRate ADD CONSTRAINT FK_HeartRate_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Hospital ADD CONSTRAINT FK_Hospital_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE HospitalPosition ADD CONSTRAINT FK_HospitalPostion_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE HospitalStaff ADD CONSTRAINT FK_HospitalStaff_Hospital FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID);
GO

ALTER TABLE HospitalStaff ADD CONSTRAINT FK_HospitalStaff_HospitalPosition FOREIGN KEY (HospitalPositionID) REFERENCES HospitalPosition(HospitalPositionID);
GO

ALTER TABLE Hours ADD CONSTRAINT FK_Hours_Companies FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID);
GO

ALTER TABLE Insulin ADD CONSTRAINT FK_Insulin_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE JobCompany ADD CONSTRAINT FK_Company_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE JobCompanyAddress ADD CONSTRAINT FK_CompanyAddress_Company FOREIGN KEY (JobCompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE JobCompanyContact ADD CONSTRAINT FK_CompanyContact_Company FOREIGN KEY (JobCompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE JobCompanyPhoneCall ADD CONSTRAINT FK_JobCompanyPhoneCall_JobCompany FOREIGN KEY (JobCompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE JobCoverLetter ADD CONSTRAINT FK_JobCoverLetter_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE JobEmail ADD CONSTRAINT FK_JobEmail_Jobs FOREIGN KEY (JobID) REFERENCES Jobs(JobID);
GO

ALTER TABLE JobInterview ADD CONSTRAINT FK_Interview_Company FOREIGN KEY (JobCompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE JobInterview ADD CONSTRAINT FK_JobInterview_JobCompany FOREIGN KEY (JobInterviewClientID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE JobInterview ADD CONSTRAINT FK_JobInterview_JobInterviewType FOREIGN KEY (JobInterviewTypeID) REFERENCES JobInterviewType(JobInterviewTypeID);
GO

ALTER TABLE JobQueue ADD CONSTRAINT FK_JobQueue_Jobs FOREIGN KEY (JobID) REFERENCES Jobs(JobID);
GO

ALTER TABLE Jobs ADD CONSTRAINT FK_Jobs_JobCompanyContact1 FOREIGN KEY (JobCompanyContactID) REFERENCES JobCompanyContact(JobCompanyContactID);
GO

ALTER TABLE Jobs ADD CONSTRAINT FK_Jobs_JobCompany1 FOREIGN KEY (JobCompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE Logins ADD CONSTRAINT FK_Logins_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Lyric ADD CONSTRAINT FK_Lyric_LyricType FOREIGN KEY (LyricTypeID) REFERENCES LyricType(LyricTypeID);
GO

ALTER TABLE Lyric ADD CONSTRAINT FK_Lyric_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Medicine ADD CONSTRAINT FK_Medicine_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE MedicineDose ADD CONSTRAINT FK_MedicineDose_Medicine FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID);
GO

ALTER TABLE MedicineDosePackage ADD CONSTRAINT FK_MedicineDosePackage_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE MedicineDosePackageItem ADD CONSTRAINT FK_MedicineDosePackageItem_MedicineDosePackage FOREIGN KEY (MedicineDosePackageID) REFERENCES MedicineDosePackage(MedicineDosePackageID);
GO

ALTER TABLE MedicineDosePackageItem ADD CONSTRAINT FK_MedicineDosePackageItem_Medicine FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID);
GO

ALTER TABLE MedicineRefill ADD CONSTRAINT FK_MedicineRefill_Doctor FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID);
GO

ALTER TABLE MedicineRefill ADD CONSTRAINT FK_MedicineRefill_Medicine FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID);
GO

ALTER TABLE MedicineRefill ADD CONSTRAINT FK_MedicineRefill_Pharamacy FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID);
GO

ALTER TABLE MonthlyBills ADD CONSTRAINT FK_MonthlyBills_BalanceAccounts FOREIGN KEY (BankingAccountID) REFERENCES BankingAccount(BankingAccountID);
GO

ALTER TABLE Movies ADD CONSTRAINT FK_Movies_Genre FOREIGN KEY (GenreID) REFERENCES Genre(GenreID);
GO

ALTER TABLE Movies ADD CONSTRAINT FK_Movies_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Notes_old ADD CONSTRAINT FK_Notes_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE PersonalDays ADD CONSTRAINT FK_PersonalDays_Companies FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID);
GO

ALTER TABLE PersonalInformation ADD CONSTRAINT FK_PersonalInformation_PersonalInformationCards FOREIGN KEY (CCTypeID) REFERENCES PersonalInformationCards(PersonalInformationCardID);
GO

ALTER TABLE PersonalInformation ADD CONSTRAINT FK_PersonalInformation_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Pharmacy ADD CONSTRAINT FK_Pharamacy_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Pharmacy ADD CONSTRAINT FK_Pharamacy_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE POP3Email ADD CONSTRAINT FK_POP3Email_POP3EmailFolder FOREIGN KEY (POP3EmailFolderID) REFERENCES POP3EmailFolder(POP3EmailFolderID);
GO

ALTER TABLE POP3EmailAccount ADD CONSTRAINT FK_POP3EmailAccount_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE POP3EmailFolder ADD CONSTRAINT FK_POP3EmailFolder_POP3EmailAccount FOREIGN KEY (POP3EmailAccountID) REFERENCES POP3EmailAccount(POP3EmailAccountID);
GO

ALTER TABLE POP3EmailRule ADD CONSTRAINT FK_POP3EmailRule_POP3EmailAccount FOREIGN KEY (POP3EmailAccountID) REFERENCES POP3EmailAccount(POP3EmailAccountID);
GO

ALTER TABLE POP3EmailRule ADD CONSTRAINT FK_POP3EmailRule_POP3EmailFolder FOREIGN KEY (POP3EmailFolderID) REFERENCES POP3EmailFolder(POP3EmailFolderID);
GO

ALTER TABLE RecoveryCounselors ADD CONSTRAINT FK_RecoveryCounselors_RecoveryPrograms FOREIGN KEY (RecoveryProgramID) REFERENCES RecoveryPrograms(RecoveryProgramID);
GO

ALTER TABLE RecoveryGroups ADD CONSTRAINT FK_RecoveryGroups_RecoveryPrograms FOREIGN KEY (RecoveryProgramID) REFERENCES RecoveryPrograms(RecoveryProgramID);
GO

ALTER TABLE RecoveryGroupSessions ADD CONSTRAINT FK_RecoveryGroupSessions_RecoveryGroups FOREIGN KEY (RecoveryGroupID) REFERENCES RecoveryGroups(RecoveryGroupID);
GO

ALTER TABLE RecoveryGroupSessions ADD CONSTRAINT FK_RecoveryGroiupSessions_RecoveryGroups FOREIGN KEY (RecoveryGroupID) REFERENCES RecoveryGroups(RecoveryGroupID);
GO

ALTER TABLE RecoveryPrograms ADD CONSTRAINT FK_RecoveryPrograms_RecoveryTypes FOREIGN KEY (RecoveryTypeID) REFERENCES RecoveryTypes(RecoveryTypeID);
GO

ALTER TABLE RecoveryPrograms ADD CONSTRAINT FK_RecoveryPrograms_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE RecoveryUrine ADD CONSTRAINT FK_RecoveryUrine_RecoveryPrograms FOREIGN KEY (RecoveryProgramID) REFERENCES RecoveryPrograms(RecoveryProgramID);
GO

ALTER TABLE Reminders ADD CONSTRAINT FK_Reminders_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE ResumeFile ADD CONSTRAINT FK_ResumeFile_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE ResumeQueue ADD CONSTRAINT FK_ResumeQueue_Company FOREIGN KEY (CompanyID) REFERENCES JobCompany(JobCompanyID);
GO

ALTER TABLE ResumeText ADD CONSTRAINT FK_ResumeText_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Settings ADD CONSTRAINT FK_Settings_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE SickDays ADD CONSTRAINT FK_SickDays_Companies FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID);
GO

ALTER TABLE SnippetGroups ADD CONSTRAINT FK_SnippetGroups_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Snippets ADD CONSTRAINT FK_Snippets_SnippetGroups FOREIGN KEY (SnippetGroupID) REFERENCES SnippetGroups(SnippetGroupID);
GO

ALTER TABLE SQLScripts ADD CONSTRAINT FK_SQLScripts_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE SQLScripts ADD CONSTRAINT FK_SQLScripts_Users1 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE SQLScripts ADD CONSTRAINT FK_SQLScripts_Users2 FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Sugar ADD CONSTRAINT FK_Sugar_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Task ADD CONSTRAINT FK_Task_TaskProject FOREIGN KEY (TaskProjectID) REFERENCES TaskProject(TaskProjectID);
GO

ALTER TABLE TaskProject ADD CONSTRAINT FK_TaskProject_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Temperature ADD CONSTRAINT FK_Temperature_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Test ADD CONSTRAINT FK_Test_TestResult FOREIGN KEY (TestResultID) REFERENCES TestResult(TestResultID);
GO

ALTER TABLE Test ADD CONSTRAINT FK_Test_TestType FOREIGN KEY (TestTypeID) REFERENCES TestType(TestTypeID);
GO

ALTER TABLE TestType ADD CONSTRAINT FK_TestType_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Timesheet ADD CONSTRAINT FK_Timesheet_TimesheetCompany FOREIGN KEY (TimesheetCompanyID) REFERENCES TimesheetCompany(TimeSheetCompanyID);
GO

ALTER TABLE TimesheetCompany ADD CONSTRAINT FK_TimesheetCompany_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE TimesheetDetail ADD CONSTRAINT FK_TimesheetDetail_Timesheet FOREIGN KEY (TimesheetID) REFERENCES Timesheet(TimesheetID);
GO

ALTER TABLE TimesheetPayment ADD CONSTRAINT FK_TimesheetPayment_TimesheetCompany FOREIGN KEY (TimesheetCompanyID) REFERENCES TimesheetCompany(TimeSheetCompanyID);
GO

ALTER TABLE Transactions ADD CONSTRAINT FK_Transactions_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Unit ADD CONSTRAINT FK_Unit_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

ALTER TABLE Weight ADD CONSTRAINT FK_Weight_Users FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO


