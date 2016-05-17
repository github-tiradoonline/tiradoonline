IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MediaFile_Drop_Table' AND TYPE = 'P')
	DROP PROCEDURE sp_MediaFile_Drop_Table;
GO

CREATE PROCEDURE sp_MediaFile_Drop_Table
AS
	

GO

EXEC sp_MediaFile_Drop_Table 