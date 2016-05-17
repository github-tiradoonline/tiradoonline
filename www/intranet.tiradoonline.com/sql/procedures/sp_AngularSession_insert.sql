IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_AngularSession_insert' AND TYPE = 'P')
	DROP PROCEDURE sp_AngularSession_insert;
GO

CREATE PROCEDURE sp_AngularSession_insert
	@UserID				INT,
	@AngularSessionName 		VARCHAR(100),
	@AngularSessionValue 		VARCHAR(MAX)
AS
	
	IF NOT EXISTS (SELECT 1 FROM AngularSession WHERE UserID = @UserID AND AngularSessionName = @AngularSessionName)
		BEGIN
			INSERT INTO AngularSession  
				(UserID, AngularSessionName, AngularSessionValue)
			VALUES
				(@UserID, @AngularSessionName, @AngularSessionValue);
		END
	ELSE
		BEGIN
			UPDATE AngularSession SET
				AngularSessionName = @AngularSessionName, 
				AngularSessionValue = @AngularSessionValue
			WHERE
				UserID = @UserID
				AND AngularSessionName = @AngularSessionName;
		END

GO

EXEC sp_AngularSession_insert 1001, 'LoggedIn', '1';
go

SELECT * FROM AngularSession