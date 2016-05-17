IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Artists' AND TYPE = 'U')
DROP TABLE Artists;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Artists' AND TYPE = 'U')
	DROP TABLE Artists;
GO

CREATE TABLE Artists
(
	ArtistID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	MovieID		 INT  NULL,
	ArtistFirstName		 VARCHAR(50)  NOT NULL,
	ArtistLastName		 VARCHAR(50)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

