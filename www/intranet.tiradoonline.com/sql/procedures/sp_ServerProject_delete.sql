IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ServerProject_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_ServerProject_delete;
GO

CREATE PROCEDURE sp_ServerProject_delete
	@ServerProjectID		INT
AS

	BEGIN TRANSACTION DELETE_SERVER

	DELETE FROM ServerInformation WHERE ServerID IN (SELECT ServerID FROM Server WHERE ServerProjectID = @ServerProjectID);
	DELETE FROM Server WHERE ServerProjectID = @ServerProjectID;
	DELETE FROM ServerProject WHERE ServerProjectID = @ServerProjectID;

	IF @@ERROR = 0
		COMMIT TRANSACTION DELETE_SERVER;
	ELSE
		ROLLBACK TRANSACTION DELETE_SERVER;

GO

--EXEC sp_ServerProject_delete 1006, 'test3', 'test';