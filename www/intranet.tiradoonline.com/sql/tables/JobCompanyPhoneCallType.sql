IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompanyPhoneCallType' AND TYPE = 'U')
DROP TABLE JobCompanyPhoneCallType;
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




GO

GO

