IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'LyricType' AND TYPE = 'U')
DROP TABLE LyricType;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'LyricType' AND TYPE = 'U')
	DROP TABLE LyricType;
GO

CREATE TABLE LyricType
(
	LyricTypeID		IDENTITY (1001,1) INT  NOT NULL,
	LyricTypeName		 VARCHAR(50)  NOT NULL,
	LyricCategory		 VARCHAR(50)  NOT NULL,
	LyricPersonType		 VARCHAR(50)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

