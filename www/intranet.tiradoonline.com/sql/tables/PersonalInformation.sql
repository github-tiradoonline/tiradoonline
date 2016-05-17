IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'PersonalInformation' AND TYPE = 'U')
DROP TABLE PersonalInformation;
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




GO


GO

