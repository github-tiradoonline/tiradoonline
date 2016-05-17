IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_TextMessage_insert' AND TYPE = 'P')
DROP PROCEDURE sp_TextMessage_insert;
GO



CREATE PROCEDURE [dbo].[sp_TextMessage_insert]
	@UserID				INT,
	@TextMessageFromEmail		VARCHAR(50),
	@TextMessage			VARCHAR(MAX)
AS

	INSERT INTO TextMessage
		(UserID, TextMessageFromEmail, TextMessage)
	VALUES
		(@UserID, @TextMessageFromEmail, @TextMessage);



GO

