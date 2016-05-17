IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TextMessage' AND TYPE = 'U')
DROP TABLE TextMessage;
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




GO

GO

