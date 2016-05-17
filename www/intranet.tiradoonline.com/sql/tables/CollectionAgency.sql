IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE OBJECT_NAME(ID) = 'CollectionAgency')
	DROP TABLE CollectionAgency;
GO

CREATE TABLE CollectionAgency
(
	CollectionAgencyID			INT IDENTITY(1001, 1) NOT NULL,
	UserID					INT NOT NULL REFERENCES Users(UserID),
	CollectionAgencyName			VARCHAR(100) NOT NULL,
	CollectionAgencyAddress1		VARCHAR(100) NOT NULL,
	CollectionAgencyAddress2		VARCHAR(100) NULL,
	CollectionAgencyCity			VARCHAR(100) NOT NULL,
	StateID			INT NOT NULL,
	CollectionAgencyZipCode			VARCHAR(20) NOT NULL,
	CollectionAgencyPhone			VARCHAR(20) NULL,
	CollectionAgencyFax			VARCHAR(20) NULL,
	CollectionAgencyWebsite			VARCHAR(100) NULL,
	CollectionAgencyNotes			VARCHAR(2000) NULL,
	create_dt				DATETIME NOT NULL DEFAULT GETDATE() 
);
GO

ALTER TABLE CollectionAgency ADD CONSTRAINT PK_CollectionAgency_CollectionAgencyID PRIMARY KEY NONCLUSTERED (CollectionAgencyID);
GO


SELECT * FROM CollectionAgency;