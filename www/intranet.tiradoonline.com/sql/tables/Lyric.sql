IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Lyric' AND TYPE = 'U')
DROP TABLE Lyric;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Lyric' AND TYPE = 'U')
	DROP TABLE Lyric;
GO

CREATE TABLE Lyric
(
	LyricID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	LyricTypeID		 INT  NOT NULL,
	LyricName		 VARCHAR(1000)  NOT NULL,
	LyricActorArtist		 VARCHAR(100)  NOT NULL,
	LyricContent		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

