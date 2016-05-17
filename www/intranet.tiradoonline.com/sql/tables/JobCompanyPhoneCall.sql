IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompanyPhoneCall' AND TYPE = 'U')
DROP TABLE JobCompanyPhoneCall;
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




GO


GO

