IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE OBJECT_NAME(ID) = 'Collection')
	DROP TABLE Collection;
GO

CREATE TABLE Collection
(
	CollectionID			INT IDENTITY(1001, 1) NOT NULL,
	CollectionAgencyID		INT NOT NULL REFERENCES CollectionAgency(CollectionAgencyID),
	Creditor			VARCHAR(100) NULL,
	CollectionStatementDate		DATETIME NOT NULL,
	CollectionNumber		VARCHAR(50) NULL,
	CollectionRepresentative	VARCHAR(100) NULL,
	CollectionAmount		NUMERIC(9, 2) NOT NULL,
	CollectionNotes			VARCHAR(2000) NOT NULL,
	create_dt			DATETIME NOT NULL DEFAULT GETDATE() 
);
GO

ALTER TABLE Collection ADD CONSTRAINT PK_Collection_CollectionID PRIMARY KEY NONCLUSTERED (CollectionID);
GO

SELECT * FROM Collection;