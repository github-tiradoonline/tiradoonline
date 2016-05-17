IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Users' AND TYPE = 'U')
DROP TABLE Users;
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




GO

GO

