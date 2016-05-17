IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'PersonalInformationCards' AND TYPE = 'U')
DROP TABLE PersonalInformationCards;
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




GO

GO

