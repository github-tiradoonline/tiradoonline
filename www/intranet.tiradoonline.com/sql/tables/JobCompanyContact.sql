IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompanyContact' AND TYPE = 'U')
DROP TABLE JobCompanyContact;
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




GO


GO

