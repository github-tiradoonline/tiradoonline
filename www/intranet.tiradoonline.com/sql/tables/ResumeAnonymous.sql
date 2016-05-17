IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeAnonymous' AND TYPE = 'U')
	DROP TABLE ResumeAnonymous;
GO

CREATE TABLE ResumeAnonymous
(
	ResumeAnonymousID		INT IDENTITY(1001, 1) NOT NULL,
	SessionID			VARCHAR(100) NULL,
	IPAddress			VARCHAR(100) NULL,
	Browser				VARCHAR(500) NULL,
	Referer				VARCHAR(500) NULL,
    	ResumeFile			VARCHAR(50) NULL,
	create_dt 			DATETIME NOT NULL DEFAULT GETDATE()
);

GO

ALTER TABLE ResumeAnonymous ADD CONSTRAINT PK_ResumeAnonymous_ResumeAnonymousID  PRIMARY KEY NONCLUSTERED (ResumeAnonymousID);
GO