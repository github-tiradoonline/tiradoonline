IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Artists' AND TYPE = 'U')
	DROP TABLE Artists;
GO

CREATE TABLE Artists
(
	ArtistID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	MovieID		 INT  NULL,
	ArtistFirstName		 VARCHAR(50)  NOT NULL,
	ArtistLastName		 VARCHAR(50)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Artists ADD CONSTRAINT PK_Artists PRIMARY KEY (ArtistID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Backups' AND TYPE = 'U')
	DROP TABLE Backups;
GO

CREATE TABLE Backups
(
	BackupID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	BackupDate		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Backups ADD CONSTRAINT IDX_Backups_BackupID PRIMARY KEY (BackupID);
GO


ALTER TABLE Backups ADD CONSTRAINT IDX_Backups_BackupID PRIMARY KEY (UserID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Banking' AND TYPE = 'U')
	DROP TABLE Banking;
GO

CREATE TABLE Banking
(
	BankingID		IDENTITY (1,1) INT  NOT NULL,
	BankingAccountID		 INT  NOT NULL,
	SubBankingAccountID		 INT  NULL,
	TransactionID		 INT  NOT NULL,
	BankingDate		 SMALLDATETIME  NOT NULL,
	Payment		 NUMERIC(8,2)  NOT NULL,
	BankingFile		 BIT DEFAULT ((0)) NOT NULL,
	BankingFileName		 VARCHAR(200)  NULL,
	Comment		 VARCHAR(255)  NULL,
	update_dt		 SMALLDATETIME  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Banking ADD CONSTRAINT PK_Balance PRIMARY KEY (BankingID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingAccount' AND TYPE = 'U')
	DROP TABLE BankingAccount;
GO

CREATE TABLE BankingAccount
(
	BankingAccountID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	BankingAccountName		 VARCHAR(50)  NOT NULL,
	ReceiveEmails		 BIT DEFAULT ((1)) NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE BankingAccount ADD CONSTRAINT PK_BalanceAccounts PRIMARY KEY (BankingAccountID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingAccountEmail' AND TYPE = 'U')
	DROP TABLE BankingAccountEmail;
GO

CREATE TABLE BankingAccountEmail
(
	BankingAccountEmailID		IDENTITY (1001,1) INT  NOT NULL,
	BankingAccountID		 INT  NOT NULL,
	BankingAccountEmail		 VARCHAR(100)  NOT NULL,
	create_dt		 DATETIME  NOT NULL

);
GO

ALTER TABLE BankingAccountEmail ADD CONSTRAINT PK_BalanceAccountsEmail PRIMARY KEY (BankingAccountEmailID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingAccountLinked' AND TYPE = 'U')
	DROP TABLE BankingAccountLinked;
GO

CREATE TABLE BankingAccountLinked
(
	BankingAccountLinkedID		IDENTITY (1001,1) INT  NOT NULL,
	BankingAccountID		 INT  NOT NULL,
	Email		 VARCHAR(50)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE BankingAccountLinked ADD CONSTRAINT PK_BalanceAccountsLinked PRIMARY KEY (BankingAccountLinkedID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingEmail' AND TYPE = 'U')
	DROP TABLE BankingEmail;
GO

CREATE TABLE BankingEmail
(
	BankingEmailID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	ToEmail		 VARCHAR(100)  NOT NULL,
	FromEmail		 VARCHAR(100)  NOT NULL,
	Subject		 VARCHAR(100)  NOT NULL,
	BodyText		 TEXT  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE BankingEmail ADD CONSTRAINT PK_BalanceEmail PRIMARY KEY (BankingEmailID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BloodPressure' AND TYPE = 'U')
	DROP TABLE BloodPressure;
GO

CREATE TABLE BloodPressure
(
	BloodPressureID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	BloodPressureDateTime		 DATETIME  NOT NULL,
	BloodPressureTop		 SMALLINT  NOT NULL,
	BloodPressureBottom		 SMALLINT  NOT NULL,
	BloodPressureComments		 VARCHAR(2000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE BloodPressure ADD CONSTRAINT PK_BloodPressure_BloodPressureID PRIMARY KEY (BloodPressureID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'CCBalance' AND TYPE = 'U')
	DROP TABLE CCBalance;
GO

CREATE TABLE CCBalance
(
	CCBalanceID		IDENTITY (1000,1) INT  NOT NULL,
	CCID		 INT  NOT NULL,
	CCDate		 SMALLDATETIME DEFAULT (getdate()) NOT NULL,
	CCDescription		 VARCHAR(100)  NOT NULL,
	CCPayment		 NUMERIC(9,2) DEFAULT (0) NOT NULL,
	update_dt		 SMALLDATETIME  NOT NULL

);
GO

ALTER TABLE CCBalance ADD CONSTRAINT IDX_CCBalance_CCBalanceID PRIMARY KEY (CCBalanceID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Companies' AND TYPE = 'U')
	DROP TABLE Companies;
GO

CREATE TABLE Companies
(
	CompanyID		IDENTITY (1,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	CompanyName		 VARCHAR(30)  NOT NULL,
	StartDate		 SMALLDATETIME  NULL,
	EndDate		 SMALLDATETIME  NULL

);
GO

ALTER TABLE Companies ADD CONSTRAINT IDX_Companies_CompanyID PRIMARY KEY (CompanyID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Contacts' AND TYPE = 'U')
	DROP TABLE Contacts;
GO

CREATE TABLE Contacts
(
	ContactID		IDENTITY (1001,1) INT  NOT NULL,
	EntryID		 VARCHAR(50)  NOT NULL,
	UserID		 INT  NOT NULL,
	FileAs		 VARCHAR(100)  NULL,
	FirstName		 VARCHAR(20)  NULL,
	LastName		 VARCHAR(20)  NULL,
	FullName		 VARCHAR(50)  NULL,
	CompanyName		 VARCHAR(100)  NULL,
	JobTitle		 VARCHAR(50)  NULL,
	Email1Address		 VARCHAR(100)  NULL,
	Email2Address		 VARCHAR(100)  NULL,
	Email3Address		 VARCHAR(100)  NULL,
	WebPage		 VARCHAR(100)  NULL,
	IMAddress		 VARCHAR(20)  NULL,
	MobileTelephoneNumber		 VARCHAR(50)  NULL,
	HomeTelephoneNumber		 VARCHAR(50)  NULL,
	BusinessTelephoneNumber		 VARCHAR(50)  NULL,
	BusinessFaxNumber		 VARCHAR(50)  NULL,
	HomeAddressStreet		 VARCHAR(50)  NULL,
	HomeAddressCity		 VARCHAR(50)  NULL,
	HomeAddressState		 VARCHAR(50)  NULL,
	HomeAddressPostalCode		 VARCHAR(50)  NULL,
	BusinessAddressStreet		 VARCHAR(50)  NULL,
	BusinessAddressCity		 VARCHAR(50)  NULL,
	BusinessAddressState		 VARCHAR(50)  NULL,
	BusinessAddressPostalCode		 VARCHAR(50)  NULL,
	HasPicture		 BIT DEFAULT ((0)) NOT NULL,
	LastModificationTime		 DATETIME  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME  NULL

);
GO

ALTER TABLE Contacts ADD CONSTRAINT PK_Contacts PRIMARY KEY (ContactID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ContactsOutlookExport' AND TYPE = 'U')
	DROP TABLE ContactsOutlookExport;
GO

CREATE TABLE ContactsOutlookExport
(
	ContactsOutlookExportID		IDENTITY (1001,1) INT  NOT NULL,
	EntryID		 VARCHAR(50)  NOT NULL,
	UserID		 INT  NOT NULL,
	FileAs		 VARCHAR(100)  NULL,
	FirstName		 VARCHAR(20)  NULL,
	LastName		 VARCHAR(20)  NULL,
	FullName		 VARCHAR(50)  NULL,
	CompanyName		 VARCHAR(100)  NULL,
	JobTitle		 VARCHAR(50)  NULL,
	Email1Address		 VARCHAR(100)  NULL,
	Email2Address		 VARCHAR(100)  NULL,
	Email3Address		 VARCHAR(100)  NULL,
	WebPage		 VARCHAR(100)  NULL,
	IMAddress		 VARCHAR(20)  NULL,
	MobileTelephoneNumber		 VARCHAR(50)  NULL,
	HomeTelephoneNumber		 VARCHAR(50)  NULL,
	BusinessTelephoneNumber		 VARCHAR(50)  NULL,
	BusinessFaxNumber		 VARCHAR(50)  NULL,
	HomeAddressStreet		 VARCHAR(50)  NULL,
	HomeAddressCity		 VARCHAR(50)  NULL,
	HomeAddressState		 VARCHAR(50)  NULL,
	HomeAddressPostalCode		 VARCHAR(50)  NULL,
	BusinessAddressStreet		 VARCHAR(50)  NULL,
	BusinessAddressCity		 VARCHAR(50)  NULL,
	BusinessAddressState		 VARCHAR(50)  NULL,
	BusinessAddressPostalCode		 VARCHAR(50)  NULL,
	LastModificationTime		 DATETIME  NULL,
	HasPicture		 BIT DEFAULT ((0)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE ContactsOutlookExport ADD CONSTRAINT PK_ContactsOutlookExport PRIMARY KEY (ContactsOutlookExportID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'CreditCard' AND TYPE = 'U')
	DROP TABLE CreditCard;
GO

CREATE TABLE CreditCard
(
	CreditCardID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	CreditCardName		 VARCHAR(50)  NOT NULL,
	CreditLimit		 NUMERIC(9,2)  NOT NULL,
	MinimumPayment		 NUMERIC(9,2)  NULL,
	CreditAvailable		 NUMERIC(9,2)  NULL,
	ClosingDate		 TINYINT  NULL,
	DueDate		 TINYINT  NULL,
	Percentage		 NUMERIC(9,2)  NULL,
	Payments		 NUMERIC(9,2)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE CreditCard ADD CONSTRAINT PK_CreditCard PRIMARY KEY (CreditCardID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'CreditCard_old' AND TYPE = 'U')
	DROP TABLE CreditCard_old;
GO

CREATE TABLE CreditCard_old
(
	CCID		IDENTITY (1000,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	CCName		 VARCHAR(20)  NOT NULL,
	CCLimit		 NUMERIC(9,2)  NOT NULL,
	CCExpiration		 SMALLDATETIME  NOT NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE CreditCard_old ADD CONSTRAINT IDX_CreditCard_CreditCardID PRIMARY KEY (CCID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Doctor' AND TYPE = 'U')
	DROP TABLE Doctor;
GO

CREATE TABLE Doctor
(
	DoctorID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	FirstName		 VARCHAR(20)  NULL,
	LastName		 VARCHAR(50)  NOT NULL,
	TelephoneNumber		 VARCHAR(50)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Doctor ADD CONSTRAINT PK_Doctor PRIMARY KEY (DoctorID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Emails' AND TYPE = 'U')
	DROP TABLE Emails;
GO

CREATE TABLE Emails
(
	EmailID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	Email		 VARCHAR(100)  NULL,
	Subject		 VARCHAR(100)  NULL,
	BodyText		 VARCHAR(4000)  NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Emails ADD CONSTRAINT IDX_Emails_EmailID PRIMARY KEY (EmailID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'EmailTemplates' AND TYPE = 'U')
	DROP TABLE EmailTemplates;
GO

CREATE TABLE EmailTemplates
(
	EmailTemplateID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	CreateAccountSubject		 VARCHAR(200)  NULL,
	CreateAccountEmail		 VARCHAR(MAX)  NULL,
	ForgotPasswordSubject		 VARCHAR(200)  NULL,
	ForgotPasswordEmail		 VARCHAR(MAX)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE EmailTemplates ADD CONSTRAINT PK_EmailTemplates PRIMARY KEY (EmailTemplateID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ExecutedSQLScripts' AND TYPE = 'U')
	DROP TABLE ExecutedSQLScripts;
GO

CREATE TABLE ExecutedSQLScripts
(
	ExecutedSQLScriptID		IDENTITY (1,1) INT  NOT NULL,
	ApplicationName		 VARCHAR(100)  NULL,
	ExecutedSQLScript		 VARCHAR(1000)  NOT NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE ExecutedSQLScripts ADD CONSTRAINT IDX_ExecutedSQLScripts_ExecutedSQLScriptsID PRIMARY KEY (ExecutedSQLScriptID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'FilteredBrowsers' AND TYPE = 'U')
	DROP TABLE FilteredBrowsers;
GO

CREATE TABLE FilteredBrowsers
(
	FilteredBrowserID		IDENTITY (1001,1) INT  NOT NULL,
	Alias		 VARCHAR(50)  NOT NULL,
	Browser		 VARCHAR(500)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE FilteredBrowsers ADD CONSTRAINT PK_FilteredBrowsers PRIMARY KEY (FilteredBrowserID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'FilteredIPAddresses' AND TYPE = 'U')
	DROP TABLE FilteredIPAddresses;
GO

CREATE TABLE FilteredIPAddresses
(
	FilteredIPAddressID		IDENTITY (1001,1) INT  NOT NULL,
	Alias		 VARCHAR(50)  NOT NULL,
	IPAddress		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE FilteredIPAddresses ADD CONSTRAINT PK_FilteredIPAddresses PRIMARY KEY (FilteredIPAddressID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ForeignKeys' AND TYPE = 'U')
	DROP TABLE ForeignKeys;
GO

CREATE TABLE ForeignKeys
(
	fkid		 INT  NULL

);
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Genre' AND TYPE = 'U')
	DROP TABLE Genre;
GO

CREATE TABLE Genre
(
	GenreID		IDENTITY (1001,1) INT  NOT NULL,
	Genre		 VARCHAR(50)  NOT NULL,
	create_dt		 DATETIME  NOT NULL

);
GO

ALTER TABLE Genre ADD CONSTRAINT PK_Genre PRIMARY KEY (GenreID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'HeartRate' AND TYPE = 'U')
	DROP TABLE HeartRate;
GO

CREATE TABLE HeartRate
(
	HeartRateID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	HeartRateDateTime		 DATETIME  NOT NULL,
	HeartRate		 SMALLINT  NOT NULL,
	HeartRateComments		 VARCHAR(2000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE HeartRate ADD CONSTRAINT PK_HeartRate_HeartRateID PRIMARY KEY (HeartRateID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Hospital' AND TYPE = 'U')
	DROP TABLE Hospital;
GO

CREATE TABLE Hospital
(
	HospitalID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	HospitalName		 VARCHAR(100)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Hospital ADD CONSTRAINT PK_Hospital PRIMARY KEY (HospitalID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'HospitalPosition' AND TYPE = 'U')
	DROP TABLE HospitalPosition;
GO

CREATE TABLE HospitalPosition
(
	HospitalPositionID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	HospitalPositionName		 VARCHAR(100)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE HospitalPosition ADD CONSTRAINT PK_HospitalPostion PRIMARY KEY (HospitalPositionID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'HospitalStaff' AND TYPE = 'U')
	DROP TABLE HospitalStaff;
GO

CREATE TABLE HospitalStaff
(
	HospitalStaffID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	HospitalID		 INT  NOT NULL,
	HospitalPositionID		 INT  NOT NULL,
	FirstName		 VARCHAR(50)  NULL,
	LastName		 VARCHAR(50)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE HospitalStaff ADD CONSTRAINT PK_HospitalStaff PRIMARY KEY (HospitalStaffID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Hours' AND TYPE = 'U')
	DROP TABLE Hours;
GO

CREATE TABLE Hours
(
	HoursID		IDENTITY (1001,1) INT  NOT NULL,
	CompanyID		 INT  NOT NULL,
	WorkDate		 DATETIME DEFAULT (getdate()) NOT NULL,
	StartHour		 NUMERIC(4,1) DEFAULT (0) NOT NULL,
	EndHour		 NUMERIC(4,1) DEFAULT (0) NULL,
	LunchHour		 NUMERIC(4,3) DEFAULT (0) NULL

);
GO

ALTER TABLE Hours ADD CONSTRAINT IDX_Hours_HourID PRIMARY KEY (HoursID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Insulin' AND TYPE = 'U')
	DROP TABLE Insulin;
GO

CREATE TABLE Insulin
(
	InsulinID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	MedicineID		 INT  NOT NULL,
	InsulinDateTime		 DATETIME  NOT NULL,
	Units		 NUMERIC(4,2)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Insulin ADD CONSTRAINT PK_Insulin_InsulinID PRIMARY KEY (InsulinID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompany' AND TYPE = 'U')
	DROP TABLE JobCompany;
GO

CREATE TABLE JobCompany
(
	JobCompanyID		IDENTITY (1001,1) INT  NOT NULL,
	JobIDOld		 INT  NULL,
	UserID		 INT  NOT NULL,
	JobCompanyName		 VARCHAR(50)  NOT NULL,
	JobCompanyWebsite		 VARCHAR(100)  NULL,
	JobCompanyLinkedIn		 VARCHAR(500)  NULL,
	JobCompanyTwitter		 VARCHAR(500)  NULL,
	JobCompanyFacebook		 VARCHAR(500)  NULL,
	JobCompanyGooglePlus		 VARCHAR(500)  NULL,
	JobCompanyYouTube		 VARCHAR(500)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE JobCompany ADD CONSTRAINT PK_Company_CompanyID PRIMARY KEY (JobCompanyID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompanyAddress' AND TYPE = 'U')
	DROP TABLE JobCompanyAddress;
GO

CREATE TABLE JobCompanyAddress
(
	JobCompanyAddressID		IDENTITY (1001,1) INT  NOT NULL,
	JobCompanyID		 INT  NOT NULL,
	JobCompanyAddress1		 VARCHAR(50)  NOT NULL,
	JobCompanyAddress2		 VARCHAR(50)  NULL,
	JobCompanyAddressCity		 VARCHAR(50)  NULL,
	StateID		 INT  NOT NULL,
	JobCompanyAddressZipCode		 VARCHAR(20)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE JobCompanyAddress ADD CONSTRAINT PK_CompanyAddress_CompanyAddressID PRIMARY KEY (JobCompanyAddressID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompanyContact' AND TYPE = 'U')
	DROP TABLE JobCompanyContact;
GO

CREATE TABLE JobCompanyContact
(
	JobCompanyContactID		IDENTITY (1001,1) INT  NOT NULL,
	JobCompanyID		 INT  NOT NULL,
	JobCompanyContactTitle		 VARCHAR(100)  NULL,
	JobCompanyContactFirstName		 VARCHAR(50)  NOT NULL,
	JobCompanyContactLastName		 VARCHAR(50)  NULL,
	JobCompanyContactWorkPhone		 VARCHAR(50)  NULL,
	JobCompanyContactFax		 VARCHAR(50)  NULL,
	JobCompanyContactCellPhone		 VARCHAR(50)  NULL,
	JobCompanyContactEmail		 VARCHAR(100)  NULL,
	JobCompanyContactLinkedIn		 VARCHAR(500)  NULL,
	JobCompanyContactTwitter		 VARCHAR(500)  NULL,
	JobCompanyContactFacebook		 VARCHAR(500)  NULL,
	JobCompanyContactGooglePlus		 VARCHAR(500)  NULL,
	JobCompanyContactNotes		 VARCHAR(MAX)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE JobCompanyContact ADD CONSTRAINT PK_CompanyContact_CompanyContactID PRIMARY KEY (JobCompanyContactID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompanyPhoneCall' AND TYPE = 'U')
	DROP TABLE JobCompanyPhoneCall;
GO

CREATE TABLE JobCompanyPhoneCall
(
	JobCompanyPhoneCallID		IDENTITY (1001,1) INT  NOT NULL,
	JobCompanyID		 INT  NOT NULL,
	JobCompanyContactID		 INT  NOT NULL,
	JobCompanyPhoneCallTypeID		 INT  NOT NULL,
	JobCompanyPhoneCallDateTime		 DATETIME  NOT NULL,
	JobCompanyPhoneCallPhoneNumber		 VARCHAR(50)  NOT NULL,
	JobCompanyPhoneCallNotes		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE JobCompanyPhoneCall ADD CONSTRAINT PK_JobCompanyPhoneCall PRIMARY KEY (JobCompanyPhoneCallID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompanyPhoneCallType' AND TYPE = 'U')
	DROP TABLE JobCompanyPhoneCallType;
GO

CREATE TABLE JobCompanyPhoneCallType
(
	JobCompanyPhoneCallTypeID		IDENTITY (1,1) INT  NOT NULL,
	JobCompanyPhoneCallType		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE JobCompanyPhoneCallType ADD CONSTRAINT PK_JobPhoneCallStatus PRIMARY KEY (JobCompanyPhoneCallTypeID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCoverLetter' AND TYPE = 'U')
	DROP TABLE JobCoverLetter;
GO

CREATE TABLE JobCoverLetter
(
	JobCoverLetterID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	JobCoverLetterName		 VARCHAR(100)  NOT NULL,
	JobCoverLetterText		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE JobCoverLetter ADD CONSTRAINT PK_JobCoverLetter PRIMARY KEY (JobCoverLetterID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobEmail' AND TYPE = 'U')
	DROP TABLE JobEmail;
GO

CREATE TABLE JobEmail
(
	JobEmailID		IDENTITY (1001,1) INT  NOT NULL,
	JobID		 INT  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE JobEmail ADD CONSTRAINT PK_JobEmail PRIMARY KEY (JobEmailID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobInterview' AND TYPE = 'U')
	DROP TABLE JobInterview;
GO

CREATE TABLE JobInterview
(
	JobInterviewID		IDENTITY (1001,1) INT  NOT NULL,
	JobCompanyID		 INT  NOT NULL,
	JobInterviewTypeID		 INT  NOT NULL,
	JobInterviewClientID		 INT  NOT NULL,
	JobInterviewClientContactID		 INT  NOT NULL,
	JobInterviewDateTime		 DATETIME  NOT NULL,
	JobInterviewAddress1		 VARCHAR(50)  NULL,
	JobInterviewAddress2		 VARCHAR(50)  NULL,
	JobInterviewCity		 VARCHAR(50)  NULL,
	StateID		 INT  NULL,
	JobInterviewZipCode		 VARCHAR(20)  NULL,
	JobInterviewNotes		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE JobInterview ADD CONSTRAINT PK_Interview_InterviewID PRIMARY KEY (JobInterviewID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobInterviewType' AND TYPE = 'U')
	DROP TABLE JobInterviewType;
GO

CREATE TABLE JobInterviewType
(
	JobInterviewTypeID		IDENTITY (1,1) INT  NOT NULL,
	JobInterviewType		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE JobInterviewType ADD CONSTRAINT PK_JobInterviewType PRIMARY KEY (JobInterviewTypeID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobQueue' AND TYPE = 'U')
	DROP TABLE JobQueue;
GO

CREATE TABLE JobQueue
(
	JobQueueID		IDENTITY (1001,1) INT  NOT NULL,
	JobID		 INT  NOT NULL,
	sent_dt		 DATETIME  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE JobQueue ADD CONSTRAINT PK_JobEmail_JobEmailID PRIMARY KEY (JobQueueID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Jobs' AND TYPE = 'U')
	DROP TABLE Jobs;
GO

CREATE TABLE Jobs
(
	JobID		IDENTITY (1001,1) INT  NOT NULL,
	JobCompanyID		 INT  NOT NULL,
	JobCompanyContactID		 INT  NOT NULL,
	JobSalaryTypeID		 INT  NOT NULL,
	JobDate		 DATETIME  NOT NULL,
	JobPosition		 VARCHAR(500)  NOT NULL,
	JobSalary		 NUMERIC(9,2)  NOT NULL,
	JobClient		 VARCHAR(100)  NULL,
	JobCity		 VARCHAR(50)  NOT NULL,
	JobStateID		 INT  NOT NULL,
	JobRequirements		 VARCHAR(MAX)  NOT NULL,
	JobNotes		 VARCHAR(MAX)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Jobs ADD CONSTRAINT PK_Jobs_1 PRIMARY KEY (JobID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobSalaryType' AND TYPE = 'U')
	DROP TABLE JobSalaryType;
GO

CREATE TABLE JobSalaryType
(
	JobSalaryTypeID		IDENTITY (1001,1) INT  NOT NULL,
	JobSalaryType		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE JobSalaryType ADD CONSTRAINT PK_JobSalaryType PRIMARY KEY (JobSalaryTypeID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Logins' AND TYPE = 'U')
	DROP TABLE Logins;
GO

CREATE TABLE Logins
(
	LoginID		IDENTITY (1,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	LoginDate		 SMALLDATETIME DEFAULT (getdate()) NOT NULL,
	Browser		 VARCHAR(100)  NULL,
	IPAddress		 VARCHAR(15)  NOT NULL

);
GO

ALTER TABLE Logins ADD CONSTRAINT IDX_Logins_LoginsID PRIMARY KEY (LoginID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Logs' AND TYPE = 'U')
	DROP TABLE Logs;
GO

CREATE TABLE Logs
(
	LogID		IDENTITY (1,1) INT  NOT NULL,
	ApplicationName		 VARCHAR(1000)  NOT NULL,
	LogDesc		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Logs ADD CONSTRAINT IDX_Logs_LogID PRIMARY KEY (LogID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Lyric' AND TYPE = 'U')
	DROP TABLE Lyric;
GO

CREATE TABLE Lyric
(
	LyricID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	LyricTypeID		 INT  NOT NULL,
	LyricName		 VARCHAR(1000)  NOT NULL,
	LyricActorArtist		 VARCHAR(100)  NOT NULL,
	LyricContent		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Lyric ADD CONSTRAINT PK_FaceBookMedia PRIMARY KEY (LyricID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'LyricType' AND TYPE = 'U')
	DROP TABLE LyricType;
GO

CREATE TABLE LyricType
(
	LyricTypeID		IDENTITY (1001,1) INT  NOT NULL,
	LyricTypeName		 VARCHAR(50)  NOT NULL,
	LyricCategory		 VARCHAR(50)  NOT NULL,
	LyricPersonType		 VARCHAR(50)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE LyricType ADD CONSTRAINT PK_LyricType PRIMARY KEY (LyricTypeID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Medicine' AND TYPE = 'U')
	DROP TABLE Medicine;
GO

CREATE TABLE Medicine
(
	MedicineID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	MedicineName		 VARCHAR(50)  NOT NULL,
	GenericName		 VARCHAR(50)  NOT NULL,
	PrescriptionNumber		 VARCHAR(30)  NULL,
	UnitID		 INT  NOT NULL,
	MedicineDescription		 VARCHAR(MAX)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Medicine ADD CONSTRAINT PK_Medicine_MedicineID PRIMARY KEY (MedicineID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineDose' AND TYPE = 'U')
	DROP TABLE MedicineDose;
GO

CREATE TABLE MedicineDose
(
	MedicineDoseID		IDENTITY (1001,1) INT  NOT NULL,
	MedicineID		 INT  NOT NULL,
	MedicineDoseDateTime		 DATETIME  NOT NULL,
	MedicineDoseDescription		 VARCHAR(2000)  NULL,
	Amount		 NUMERIC(9,2)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE MedicineDose ADD CONSTRAINT PK_MedicineDose_MedicineDoseID PRIMARY KEY (MedicineDoseID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineDosePackage' AND TYPE = 'U')
	DROP TABLE MedicineDosePackage;
GO

CREATE TABLE MedicineDosePackage
(
	MedicineDosePackageID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	MedicineDosePackageName		 VARCHAR(100)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATE DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE MedicineDosePackage ADD CONSTRAINT PK_MedicineDosePackage PRIMARY KEY (MedicineDosePackageID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineDosePackageItem' AND TYPE = 'U')
	DROP TABLE MedicineDosePackageItem;
GO

CREATE TABLE MedicineDosePackageItem
(
	MedicineDosePackageItemID		IDENTITY (1001,1) INT  NOT NULL,
	MedicineDosePackageID		 INT  NOT NULL,
	MedicineID		 INT  NOT NULL,
	Amount		 NUMERIC(9,2) DEFAULT ((0)) NOT NULL,
	Description		 VARCHAR(200)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE MedicineDosePackageItem ADD CONSTRAINT PK_MedicineDosePackageItem PRIMARY KEY (MedicineDosePackageItemID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineRefill' AND TYPE = 'U')
	DROP TABLE MedicineRefill;
GO

CREATE TABLE MedicineRefill
(
	MedicineRefillID		IDENTITY (1001,1) INT  NOT NULL,
	MedicineID		 INT  NOT NULL,
	PharmacyID		 INT  NOT NULL,
	DoctorID		 INT  NOT NULL,
	RefillOrderDate		 DATETIME  NULL,
	RefillOrderPickupDate		 DATETIME  NULL,
	RefillDateFilled		 DATETIME  NULL,
	RefillAmount		 NUMERIC(9,2) DEFAULT ((0)) NULL,
	DailyAmount		 NUMERIC(9,2) DEFAULT ((0)) NULL,
	RefillTimes		 INT DEFAULT ((0)) NULL,
	RefillUntilDate		 DATETIME  NULL,
	RefillDiscardDate		 DATETIME  NULL,
	RefillDescription		 VARCHAR(5000)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE MedicineRefill ADD CONSTRAINT PK_MedicineRefill PRIMARY KEY (MedicineRefillID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MonthlyBills' AND TYPE = 'U')
	DROP TABLE MonthlyBills;
GO

CREATE TABLE MonthlyBills
(
	MonthlyBillID		IDENTITY (1001,1) INT  NOT NULL,
	BankingAccountID		 INT  NOT NULL,
	MonthlyBillStartDate		 SMALLDATETIME  NOT NULL,
	MonthlyBillDate		 SMALLDATETIME  NOT NULL,
	MonthlyBillDesc		 VARCHAR(100)  NOT NULL,
	MonthlyBillAmount		 NUMERIC(9,2)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE MonthlyBills ADD CONSTRAINT PK_MonthlyBills PRIMARY KEY (MonthlyBillID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Movies' AND TYPE = 'U')
	DROP TABLE Movies;
GO

CREATE TABLE Movies
(
	MovieID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	GenreID		 INT  NOT NULL,
	MovieTitle		 VARCHAR(200)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Movies ADD CONSTRAINT PK_Movies PRIMARY KEY (MovieID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Notes' AND TYPE = 'U')
	DROP TABLE Notes;
GO

CREATE TABLE Notes
(
	NoteID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	NoteName		 VARCHAR(100)  NOT NULL,
	NoteText		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Notes ADD CONSTRAINT PK_Notes_1 PRIMARY KEY (NoteID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Notes_old' AND TYPE = 'U')
	DROP TABLE Notes_old;
GO

CREATE TABLE Notes_old
(
	NoteID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	StartLocation		 INT  NULL,
	Title		 VARCHAR(100)  NULL,
	NoteText		 VARCHAR(MAX)  NULL,
	update_dt		 DATETIME DEFAULT (getdate()) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Notes_old ADD CONSTRAINT PK_Notes PRIMARY KEY (NoteID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'PageLogs' AND TYPE = 'U')
	DROP TABLE PageLogs;
GO

CREATE TABLE PageLogs
(
	PageLogID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	SCRIPT_NAME		 TEXT  NOT NULL,
	Template		 VARCHAR(100)  NULL,
	Action		 VARCHAR(100)  NULL,
	REQUEST_METHOD		 VARCHAR(20)  NULL,
	QUERY_STRING		 VARCHAR(MAX)  NULL,
	FORM		 VARCHAR(MAX)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE PageLogs ADD CONSTRAINT PK_PageLogs PRIMARY KEY (PageLogID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Paychecks' AND TYPE = 'U')
	DROP TABLE Paychecks;
GO

CREATE TABLE Paychecks
(
	PaycheckID		IDENTITY (1001,1) INT  NOT NULL,
	TimesheetCompanyID		 INT  NULL,
	PaymentDate		 DATETIME DEFAULT (getdate()) NOT NULL,
	HourlyRate		 NUMERIC(6,2) DEFAULT ((0)) NOT NULL,
	Gross		 NUMERIC(7,2) DEFAULT ((0)) NOT NULL,
	Federal		 NUMERIC(7,2) DEFAULT ((0)) NULL,
	SocialSecurity		 NUMERIC(7,2) DEFAULT ((0)) NULL,
	Medicare		 NUMERIC(7,2) DEFAULT ((0)) NULL,
	NY_Withholding		 NUMERIC(7,2) DEFAULT ((0)) NULL,
	NY_Disability		 NUMERIC(7,2) DEFAULT ((0)) NULL,
	NY_City		 NUMERIC(7,2) DEFAULT ((0)) NULL

);
GO

ALTER TABLE Paychecks ADD CONSTRAINT IDX_Paychecs_PaycheckID PRIMARY KEY (PaycheckID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'PersonalDays' AND TYPE = 'U')
	DROP TABLE PersonalDays;
GO

CREATE TABLE PersonalDays
(
	PersonalDayID		IDENTITY (1001,1) INT  NOT NULL,
	CompanyID		 INT  NOT NULL,
	PersonalDate		 SMALLDATETIME  NOT NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE PersonalDays ADD CONSTRAINT IDX_PersonalDays_PersonalDayID PRIMARY KEY (PersonalDayID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'PersonalInformation' AND TYPE = 'U')
	DROP TABLE PersonalInformation;
GO

CREATE TABLE PersonalInformation
(
	PersonalInformationID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	AccountName		 VARCHAR(100)  NOT NULL,
	UserName		 VARCHAR(100)  NULL,
	Password		 VARCHAR(50)  NULL,
	Password2		 VARCHAR(50)  NULL,
	AccountNumber		 VARCHAR(50)  NULL,
	AccountNumber2		 VARCHAR(50)  NULL,
	Rewards		 VARCHAR(50)  NULL,
	Pin		 VARCHAR(50)  NULL,
	Website		 VARCHAR(100)  NULL,
	Phone		 VARCHAR(50)  NULL,
	Phone2		 VARCHAR(50)  NULL,
	Email		 VARCHAR(50)  NULL,
	ATM		 VARCHAR(50)  NULL,
	Checking		 VARCHAR(50)  NULL,
	RoutingNumber		 VARCHAR(50)  NULL,
	CCTypeID		 INT  NULL,
	Expiration		 VARCHAR(10)  NULL,
	CSV		 VARCHAR(50)  NULL,
	SerialNumber		 VARCHAR(100)  NULL,
	Code		 VARCHAR(1000)  NULL,
	RegistrationDate		 SMALLDATETIME  NULL,
	Notes		 VARCHAR(MAX)  NULL,
	Browser		 VARCHAR(300)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE PersonalInformation ADD CONSTRAINT PK_Accounts PRIMARY KEY (PersonalInformationID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'PersonalInformationCards' AND TYPE = 'U')
	DROP TABLE PersonalInformationCards;
GO

CREATE TABLE PersonalInformationCards
(
	PersonalInformationCardID		IDENTITY (1001,1) INT  NOT NULL,
	PersonalInformationCard		 VARCHAR(100)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE PersonalInformationCards ADD CONSTRAINT PK_PersonalInformationCards PRIMARY KEY (PersonalInformationCardID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Pharmacy' AND TYPE = 'U')
	DROP TABLE Pharmacy;
GO

CREATE TABLE Pharmacy
(
	PharmacyID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	PharmacyName		 VARCHAR(100)  NOT NULL,
	PharmacyAddress		 VARCHAR(100)  NOT NULL,
	PharmacyCity		 VARCHAR(50)  NOT NULL,
	PharmacyStateID		 INT  NOT NULL,
	PharmacyZipCode		 VARCHAR(20)  NOT NULL,
	PharmacyTelephoneNumber		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Pharmacy ADD CONSTRAINT PK_MedicinePharamacy PRIMARY KEY (PharmacyID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'POP3Email' AND TYPE = 'U')
	DROP TABLE POP3Email;
GO

CREATE TABLE POP3Email
(
	POP3EmailID		IDENTITY (1001,1) INT  NOT NULL,
	POP3EmailFolderID		 INT DEFAULT ((1001)) NOT NULL,
	POP3EmailMessageID		 VARCHAR(100)  NULL,
	POP3EmailMessageDateTime		 DATETIME  NULL,
	POP3EmailFromName		 VARCHAR(500)  NULL,
	POP3EmailFromEmail		 VARCHAR(500)  NULL,
	POP3EmailSubject		 VARCHAR(500)  NULL,
	POP3EmailBodyText		 VARCHAR(MAX)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NULL

);
GO

ALTER TABLE POP3Email ADD CONSTRAINT PK_POP3Email PRIMARY KEY (POP3EmailID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'POP3EmailAccount' AND TYPE = 'U')
	DROP TABLE POP3EmailAccount;
GO

CREATE TABLE POP3EmailAccount
(
	POP3EmailAccountID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	POP3EmailAccountName		 VARCHAR(50)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE POP3EmailAccount ADD CONSTRAINT PK_POP3EmailAccount PRIMARY KEY (POP3EmailAccountID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'POP3EmailFolder' AND TYPE = 'U')
	DROP TABLE POP3EmailFolder;
GO

CREATE TABLE POP3EmailFolder
(
	POP3EmailFolderID		IDENTITY (1001,1) INT  NOT NULL,
	POP3EmailAccountID		 INT  NOT NULL,
	POP3EmailFolderName		 VARCHAR(100)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE POP3EmailFolder ADD CONSTRAINT PK_POP3EmailFolder PRIMARY KEY (POP3EmailFolderID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'POP3EmailRule' AND TYPE = 'U')
	DROP TABLE POP3EmailRule;
GO

CREATE TABLE POP3EmailRule
(
	POP3EmailRuleID		IDENTITY (1001,1) INT  NOT NULL,
	POP3EmailAccountID		 INT  NOT NULL,
	POP3EmailFolderID		 INT  NOT NULL,
	POP3EmailEmailAddress		 VARCHAR(50)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE POP3EmailRule ADD CONSTRAINT PK_POP3EmailRule PRIMARY KEY (POP3EmailRuleID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryCounselors' AND TYPE = 'U')
	DROP TABLE RecoveryCounselors;
GO

CREATE TABLE RecoveryCounselors
(
	RecoveryCounselorID		IDENTITY (1001,1) INT  NOT NULL,
	RecoveryProgramID		 INT  NOT NULL,
	FirstName		 VARCHAR(20)  NULL,
	LastName		 VARCHAR(30)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE RecoveryCounselors ADD CONSTRAINT PK_RecoveryCounselors PRIMARY KEY (RecoveryCounselorID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryGroups' AND TYPE = 'U')
	DROP TABLE RecoveryGroups;
GO

CREATE TABLE RecoveryGroups
(
	RecoveryGroupID		IDENTITY (1,1) INT  NOT NULL,
	RecoveryProgramID		 INT  NOT NULL,
	RecoveryGroupName		 VARCHAR(50)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE RecoveryGroups ADD CONSTRAINT PK_RecoveryGroups PRIMARY KEY (RecoveryGroupID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryGroupSessions' AND TYPE = 'U')
	DROP TABLE RecoveryGroupSessions;
GO

CREATE TABLE RecoveryGroupSessions
(
	RecoveryGroupSessionID		IDENTITY (1001,1) INT  NOT NULL,
	RecoveryGroupID		 INT  NOT NULL,
	RecoveryCounselorID		 INT  NOT NULL,
	RecoveryGroupSessionDateTime		 DATETIME  NOT NULL,
	ScheduledGroup		 BIT  NOT NULL,
	Comments		 VARCHAR(2000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE RecoveryGroupSessions ADD CONSTRAINT PK_RecoveryGroiupSessions PRIMARY KEY (RecoveryGroupSessionID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryPrograms' AND TYPE = 'U')
	DROP TABLE RecoveryPrograms;
GO

CREATE TABLE RecoveryPrograms
(
	RecoveryProgramID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NULL,
	RecoveryTypeID		 INT  NOT NULL,
	ProgramName		 VARCHAR(50)  NOT NULL,
	start_dt		 DATETIME  NOT NULL,
	end_dt		 DATETIME  NULL,
	sober_dt		 DATETIME  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE RecoveryPrograms ADD CONSTRAINT PK_RecoveryPrograms PRIMARY KEY (RecoveryProgramID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryTypes' AND TYPE = 'U')
	DROP TABLE RecoveryTypes;
GO

CREATE TABLE RecoveryTypes
(
	RecoveryTypeID		IDENTITY (1001,1) INT  NOT NULL,
	RecoveryTypeName		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE RecoveryTypes ADD CONSTRAINT PK_RecoveryTypes PRIMARY KEY (RecoveryTypeID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryUrine' AND TYPE = 'U')
	DROP TABLE RecoveryUrine;
GO

CREATE TABLE RecoveryUrine
(
	RecoveryUrineID		IDENTITY (1001,1) INT  NOT NULL,
	RecoveryProgramID		 INT  NOT NULL,
	RecoveryUrineDateTime		 DATETIME  NOT NULL,
	RecoveryUrineResult		 BIT DEFAULT ((0)) NOT NULL,
	RecoveryUrineDescription		 VARCHAR(1000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE RecoveryUrine ADD CONSTRAINT PK_RecoveryUrine PRIMARY KEY (RecoveryUrineID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ReferencedBy' AND TYPE = 'U')
	DROP TABLE ReferencedBy;
GO

CREATE TABLE ReferencedBy
(
	ReferencedByID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	OrderNum		 INT  NOT NULL,
	ReferencedByName		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE ReferencedBy ADD CONSTRAINT PK_ReferencedBy PRIMARY KEY (ReferencedByID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Reminders' AND TYPE = 'U')
	DROP TABLE Reminders;
GO

CREATE TABLE Reminders
(
	ReminderID		IDENTITY (1000,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	ReminderDate		 SMALLDATETIME  NULL,
	ReminderDesc		 VARCHAR(100)  NOT NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Reminders ADD CONSTRAINT IDX_Reminders_ReminderID PRIMARY KEY (ReminderID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeDownloads' AND TYPE = 'U')
	DROP TABLE ResumeDownloads;
GO

CREATE TABLE ResumeDownloads
(
	ResumeDownloadID		IDENTITY (1001,1) INT  NOT NULL,
	FullName		 VARCHAR(50)  NULL,
	Company		 VARCHAR(50)  NULL,
	Phone		 VARCHAR(50)  NULL,
	Email		 VARCHAR(50)  NOT NULL,
	Comments		 VARCHAR(1000)  NULL,
	Website		 VARCHAR(100)  NULL,
	ReferencedByID		 INT  NOT NULL,
	ResumeDownloadTypeID		 INT  NOT NULL,
	Referer		 VARCHAR(1000)  NULL,
	SessionID		 VARCHAR(50)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE ResumeDownloads ADD CONSTRAINT PK_ResumeDownloads PRIMARY KEY (ResumeDownloadID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeDownloadType' AND TYPE = 'U')
	DROP TABLE ResumeDownloadType;
GO

CREATE TABLE ResumeDownloadType
(
	ResumeDownloadTypeID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	ResumeDownloadTypeName		 VARCHAR(100)  NOT NULL,
	ResumeDownloadTypeFileName		 VARCHAR(100)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE ResumeDownloadType ADD CONSTRAINT PK_ResumeType PRIMARY KEY (ResumeDownloadTypeID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeFile' AND TYPE = 'U')
	DROP TABLE ResumeFile;
GO

CREATE TABLE ResumeFile
(
	ResumeFileID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	ResumeFileName		 VARCHAR(50)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE ResumeFile ADD CONSTRAINT PK_ResumeFile_ResumeFileID PRIMARY KEY (ResumeFileID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeQueue' AND TYPE = 'U')
	DROP TABLE ResumeQueue;
GO

CREATE TABLE ResumeQueue
(
	ResumeQueueID		IDENTITY (1001,1) INT  NOT NULL,
	CompanyID		 INT  NOT NULL,
	Status		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE ResumeQueue ADD CONSTRAINT PK_ResumeQueue_ResumeQueueID PRIMARY KEY (ResumeQueueID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeText' AND TYPE = 'U')
	DROP TABLE ResumeText;
GO

CREATE TABLE ResumeText
(
	ResumeTextID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	ResumeTextName		 VARCHAR(50)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE ResumeText ADD CONSTRAINT PK_ResumeText_ResumeTextID PRIMARY KEY (ResumeTextID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Sessions' AND TYPE = 'U')
	DROP TABLE Sessions;
GO

CREATE TABLE Sessions
(
	SessionID		IDENTITY (1001,1) INT  NOT NULL,
	Session_ID		 VARCHAR(50)  NULL,
	Application		 VARCHAR(100)  NOT NULL,
	SCRIPT_NAME		 VARCHAR(500)  NOT NULL,
	IPAddress		 VARCHAR(20)  NOT NULL,
	Browser		 VARCHAR(500)  NOT NULL,
	Referer		 VARCHAR(1000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Sessions ADD CONSTRAINT PK_Sessions PRIMARY KEY (SessionID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Settings' AND TYPE = 'U')
	DROP TABLE Settings;
GO

CREATE TABLE Settings
(
	SettingsID		IDENTITY (1,1) INT  NOT NULL,
	UserID		 INT  NULL,
	DebuggingSetting		 BIT DEFAULT ((0)) NULL,
	AdministratorEmail		 VARCHAR(50)  NOT NULL,
	DocumentsDirectory		 VARCHAR(200)  NULL,
	ContactsPhotosDirectory		 VARCHAR(200)  NULL,
	PhotosDirectory		 VARCHAR(200)  NULL,
	MoviesDirectory		 VARCHAR(200)  NULL,
	MusicDirectory		 VARCHAR(200)  NULL,
	SMTPServer		 VARCHAR(100)  NULL,
	SMTPServerPort		 VARCHAR(10)  NULL,
	SMTPServerUserName		 VARCHAR(50)  NULL,
	SMTPServerPassword		 VARCHAR(50)  NULL,
	POP3Server		 VARCHAR(100)  NULL,
	POP3ServerPort		 VARCHAR(10)  NULL,
	POP3ServerUserName		 VARCHAR(50)  NULL,
	POP3ServerPassword		 VARCHAR(50)  NULL,
	PreviousPage		 VARCHAR(MAX)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Settings ADD CONSTRAINT PK_Settings PRIMARY KEY (SettingsID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'SickDays' AND TYPE = 'U')
	DROP TABLE SickDays;
GO

CREATE TABLE SickDays
(
	SickDayID		IDENTITY (1001,1) INT  NOT NULL,
	CompanyID		 INT  NOT NULL,
	SickDate		 SMALLDATETIME  NOT NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE SickDays ADD CONSTRAINT IDX_SickDays_SickDayID PRIMARY KEY (SickDayID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'SnippetFolderImport' AND TYPE = 'U')
	DROP TABLE SnippetFolderImport;
GO

CREATE TABLE SnippetFolderImport
(
	SnippetFolderID		 INT  NOT NULL,
	UserID		 VARCHAR(100)  NOT NULL,
	SnippetFolderName		 VARCHAR(30)  NOT NULL,
	DateCreated		 DATETIME  NOT NULL

);
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'SnippetGroups' AND TYPE = 'U')
	DROP TABLE SnippetGroups;
GO

CREATE TABLE SnippetGroups
(
	SnippetGroupID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	SnippetGroupName		 VARCHAR(100)  NOT NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE SnippetGroups ADD CONSTRAINT IDX_SnippetGroups_SnippetGroupID PRIMARY KEY (SnippetGroupID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'SnippetImport' AND TYPE = 'U')
	DROP TABLE SnippetImport;
GO

CREATE TABLE SnippetImport
(
	SnippetID		 INT  NOT NULL,
	SnippetFolderID		 INT  NOT NULL,
	SnippetName		 VARCHAR(30)  NOT NULL,
	SnippetDescription		 TEXT  NOT NULL,
	SnippetShare		 BIT  NOT NULL,
	DateCreated		 DATETIME  NOT NULL

);
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Snippets' AND TYPE = 'U')
	DROP TABLE Snippets;
GO

CREATE TABLE Snippets
(
	SnippetID		IDENTITY (1001,1) INT  NOT NULL,
	SnippetGroupID		 INT  NOT NULL,
	SnippetName		 VARCHAR(100)  NOT NULL,
	Snippet		 VARCHAR(MAX)  NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL,
	update_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Snippets ADD CONSTRAINT IDX_Snippets_SnippetID PRIMARY KEY (SnippetID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'SQLScripts' AND TYPE = 'U')
	DROP TABLE SQLScripts;
GO

CREATE TABLE SQLScripts
(
	SQLScriptID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	SQLScript		 VARCHAR(1000)  NOT NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE SQLScripts ADD CONSTRAINT IDX_SQLScripts_SQLScriptID PRIMARY KEY (SQLScriptID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'States' AND TYPE = 'U')
	DROP TABLE States;
GO

CREATE TABLE States
(
	StateID		IDENTITY (1001,1) INT  NOT NULL,
	State		 VARCHAR(30)  NULL,
	StateAbbr		 VARCHAR(2)  NULL

);
GO

ALTER TABLE States ADD CONSTRAINT IDX_States_StateID PRIMARY KEY (StateID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Sugar' AND TYPE = 'U')
	DROP TABLE Sugar;
GO

CREATE TABLE Sugar
(
	SugarID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	SugarDateTime		 DATETIME  NOT NULL,
	Sugar		 SMALLINT  NOT NULL,
	SugarComments		 VARCHAR(2000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Sugar ADD CONSTRAINT PK_Sugar_SugarID PRIMARY KEY (SugarID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sysdiagrams' AND TYPE = 'U')
	DROP TABLE sysdiagrams;
GO

CREATE TABLE sysdiagrams
(
	name		IDENTITY (1,1) NVARCHAR(256)  NOT NULL,
	name		 SYSNAME(256)  NOT NULL,
	principal_id		 INT  NOT NULL,
	diagram_id		 INT  NOT NULL,
	version		 INT  NULL,
	definition		 VARBINARY  NULL

);
GO

ALTER TABLE sysdiagrams ADD CONSTRAINT PK__sysdiagrams__59B045BD PRIMARY KEY (diagram_id);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TableRows' AND TYPE = 'U')
	DROP TABLE TableRows;
GO

CREATE TABLE TableRows
(
	ObjectID		 VARCHAR(50)  NOT NULL,
	ObjectName		 VARCHAR(50)  NOT NULL,
	TableOwner		 VARCHAR(50)  NOT NULL,
	TableRows		 INT  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Task' AND TYPE = 'U')
	DROP TABLE Task;
GO

CREATE TABLE Task
(
	TaskID		IDENTITY (1001,1) INT  NOT NULL,
	TaskProjectID		 INT  NOT NULL,
	TaskDate		 DATETIME  NOT NULL,
	TaskName		 VARCHAR(100)  NOT NULL,
	TaskDueDate		 DATE  NULL,
	TaskDescription		 VARCHAR(MAX)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Task ADD CONSTRAINT PK_Task PRIMARY KEY (TaskID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TaskProject' AND TYPE = 'U')
	DROP TABLE TaskProject;
GO

CREATE TABLE TaskProject
(
	TaskProjectID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	TaskProjectName		 VARCHAR(100)  NOT NULL,
	TaksProjectDescription		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE TaskProject ADD CONSTRAINT PK_TaskProject PRIMARY KEY (TaskProjectID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Temperature' AND TYPE = 'U')
	DROP TABLE Temperature;
GO

CREATE TABLE Temperature
(
	TemperatureID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	TemperatureDateTime		 DATETIME  NOT NULL,
	Temperature		 NUMERIC(5,1)  NOT NULL,
	TemperatureComments		 VARCHAR(2000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Temperature ADD CONSTRAINT PK_Temperature_TemperatureID PRIMARY KEY (TemperatureID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Test' AND TYPE = 'U')
	DROP TABLE Test;
GO

CREATE TABLE Test
(
	TestID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	TestTypeID		 INT  NOT NULL,
	TestResultID		 INT  NOT NULL,
	TestDate		 SMALLDATETIME  NOT NULL,
	TestLocation		 VARCHAR(50)  NOT NULL,
	TestComments		 VARCHAR(200)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Test ADD CONSTRAINT PK_Test_TestID PRIMARY KEY (TestID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TestResult' AND TYPE = 'U')
	DROP TABLE TestResult;
GO

CREATE TABLE TestResult
(
	TestResultID		 INT  NOT NULL,
	TestResultName		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE TestResult ADD CONSTRAINT PK_TestResult PRIMARY KEY (TestResultID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TestType' AND TYPE = 'U')
	DROP TABLE TestType;
GO

CREATE TABLE TestType
(
	TestTypeID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	TestTypeName		 VARCHAR(50)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE TestType ADD CONSTRAINT PK_TestType_TestTypeID PRIMARY KEY (TestTypeID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TextMessage' AND TYPE = 'U')
	DROP TABLE TextMessage;
GO

CREATE TABLE TextMessage
(
	TextMessageID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	TextMessageFromEmail		 VARCHAR(50)  NOT NULL,
	TextMessage		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE TextMessage ADD CONSTRAINT PK_TextMessage PRIMARY KEY (TextMessageID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Timesheet' AND TYPE = 'U')
	DROP TABLE Timesheet;
GO

CREATE TABLE Timesheet
(
	TimesheetID		IDENTITY (1001,1) INT  NOT NULL,
	TimesheetCompanyID		 INT  NOT NULL,
	TimesheetInvoiceDate		 DATETIME DEFAULT (getdate()) NOT NULL,
	TimesheetInvoiceNumber		 VARCHAR(50)  NOT NULL,
	TimesheetHourlyRate		 NUMERIC(9,2)  NOT NULL,
	TimesheetStartDate		 DATETIME  NOT NULL,
	TimesheetEndDate		 DATETIME  NOT NULL,
	TimesheetHTML		 VARCHAR(MAX)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Timesheet ADD CONSTRAINT PK_Timesheet PRIMARY KEY (TimesheetID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TimesheetCompany' AND TYPE = 'U')
	DROP TABLE TimesheetCompany;
GO

CREATE TABLE TimesheetCompany
(
	TimeSheetCompanyID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	TimesheetCompanyName		 VARCHAR(100)  NOT NULL,
	TimesheetCompanyAddress1		 VARCHAR(100)  NULL,
	TimesheetCompanyAddress2		 VARCHAR(100)  NULL,
	TimesheetCompanyCity		 VARCHAR(100)  NULL,
	TimesheetCompanyStateID		 INT  NULL,
	TimesheetCompanyZipCode		 VARCHAR(20)  NULL,
	TimesheetCompanyPhone		 VARCHAR(50)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE TimesheetCompany ADD CONSTRAINT PK_TimesheetCompany PRIMARY KEY (TimeSheetCompanyID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TimesheetDetail' AND TYPE = 'U')
	DROP TABLE TimesheetDetail;
GO

CREATE TABLE TimesheetDetail
(
	TimesheetDetailID		IDENTITY (1001,1) INT  NOT NULL,
	TimesheetID		 INT  NOT NULL,
	TimesheetDetailDate		 DATETIME  NOT NULL,
	TimesheetHours		 NUMERIC(9,2)  NOT NULL,
	TimesheetDescription		 VARCHAR(2000)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE TimesheetDetail ADD CONSTRAINT PK_TimesheetDetail PRIMARY KEY (TimesheetDetailID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TimesheetPayment' AND TYPE = 'U')
	DROP TABLE TimesheetPayment;
GO

CREATE TABLE TimesheetPayment
(
	TimesheetPaymentID		 INT  NOT NULL,
	TimesheetCompanyID		 INT  NOT NULL,
	TimesheetPaymentDate		 DATETIME  NOT NULL,
	TimesheetPayment		 NUMERIC(9,2)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME  NOT NULL

);
GO

ALTER TABLE TimesheetPayment ADD CONSTRAINT PK_TimesheetPayment PRIMARY KEY (TimesheetPaymentID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Transactions' AND TYPE = 'U')
	DROP TABLE Transactions;
GO

CREATE TABLE Transactions
(
	TransactionID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	Description		 VARCHAR(1000)  NULL,
	Active		 CHAR(1) DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Transactions ADD CONSTRAINT PK_Transactions PRIMARY KEY (TransactionID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Unit' AND TYPE = 'U')
	DROP TABLE Unit;
GO

CREATE TABLE Unit
(
	UnitID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	UnitName		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Unit ADD CONSTRAINT PK_Unit_UnitID PRIMARY KEY (UnitID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Users' AND TYPE = 'U')
	DROP TABLE Users;
GO

CREATE TABLE Users
(
	UserID		IDENTITY (1,1) INT  NOT NULL,
	UserName		 VARCHAR(20)  NOT NULL,
	Password		 VARCHAR(20)  NOT NULL,
	FirstName		 VARCHAR(30)  NOT NULL,
	LastName		 VARCHAR(30)  NOT NULL,
	Administrator		 INT  NOT NULL,
	Email		 VARCHAR(100)  NOT NULL,
	MobileEmail		 VARCHAR(100)  NULL,
	Address1		 VARCHAR(100)  NULL,
	Address2		 VARCHAR(100)  NULL,
	City		 VARCHAR(100)  NULL,
	StateID		 INT  NULL,
	ZipCode		 VARCHAR(20)  NULL,
	Phone		 VARCHAR(50)  NULL,
	Administration		 BIT DEFAULT ((0)) NOT NULL,
	Contacts		 BIT DEFAULT ((1)) NOT NULL,
	PersonalInformation		 BIT DEFAULT ((1)) NOT NULL,
	Documents		 BIT DEFAULT ((1)) NOT NULL,
	Banking		 BIT DEFAULT ((1)) NOT NULL,
	CreditCards		 BIT DEFAULT ((1)) NOT NULL,
	Photos		 BIT DEFAULT ((1)) NOT NULL,
	Music		 BIT  NOT NULL,
	MovieCollection		 BIT DEFAULT ((1)) NOT NULL,
	Movies		 BIT DEFAULT ((1)) NOT NULL,
	Snippets		 BIT DEFAULT ((1)) NOT NULL,
	Health		 BIT DEFAULT ((1)) NOT NULL,
	Jobs		 BIT DEFAULT ((1)) NOT NULL,
	Recovery		 BIT  NOT NULL,
	Timesheet		 BIT DEFAULT ((1)) NOT NULL,
	tiradoonline		 BIT  NOT NULL,
	Notes		 BIT DEFAULT ((1)) NOT NULL,
	AIM		 VARCHAR(50)  NULL,
	Yahoo		 VARCHAR(50)  NULL,
	Hotmail		 VARCHAR(50)  NULL,
	Skype		 VARCHAR(50)  NULL,
	Gmail		 VARCHAR(50)  NULL,
	Active		 BIT  NOT NULL,
	update_by		 INT  NULL,
	update_dt		 DATETIME DEFAULT (getdate()) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Users ADD CONSTRAINT IDX_Users_UserID PRIMARY KEY (UserID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'WebsiteEmail' AND TYPE = 'U')
	DROP TABLE WebsiteEmail;
GO

CREATE TABLE WebsiteEmail
(
	WebsiteEmailID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	WebsiteFromEmail		 VARCHAR(50)  NOT NULL,
	WebsiteEmailBodyText		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE WebsiteEmail ADD CONSTRAINT PK_WebsiteEmail PRIMARY KEY (WebsiteEmailID);
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Weight' AND TYPE = 'U')
	DROP TABLE Weight;
GO

CREATE TABLE Weight
(
	WeightID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	WeightDateTime		 DATETIME  NOT NULL,
	Weight		 INT  NOT NULL,
	WeightLocation		 VARCHAR(100)  NULL,
	WeightComments		 VARCHAR(2000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE Weight ADD CONSTRAINT PK_Weight PRIMARY KEY (WeightID);
GO



