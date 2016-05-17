IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ContactsOutlookExport' AND TYPE = 'U')
DROP TABLE ContactsOutlookExport;
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




GO

GO

