IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ReferencedBy' AND TYPE = 'U')
DROP TABLE ReferencedBy;
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




GO

GO

