IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MediaFile_insert' AND TYPE = 'P')
	DROP PROCEDURE sp_MediaFile_insert;
GO

CREATE PROCEDURE sp_MediaFile_insert
	@UserID			INT,
	@MediaFileDirectory	VARCHAR(MAX),
	@MediaFileName		VARCHAR(MAX),
	@MediaFileExt		VARCHAR(100)
AS
	
	IF NOT EXISTS (SELECT 1 FROM MediaFile WHERE UserID = @UserID AND MediaFileDirectory = @MediaFileDirectory AND MediaFileName = @MediaFileName AND MediaFileExt = @MediaFileExt)
		BEGIN
		
			INSERT INTO MediaFile
				(UserID, MediaFileDirectory, MediaFileName, MediaFileExt)
			VALUES
				(@UserID, @MediaFileDirectory, @MediaFileName, @MediaFileExt);

		END

GO

exec sp_MediaFile_insert 1001, 'c:\storage\music\Bodyguard, The - Soundtrack', 'Bodyguard, The - Soundtrack - Peace, Love And Understanding (What''s So Funny ''Bout) - Curtis Stigers.mp3', 'txt';
