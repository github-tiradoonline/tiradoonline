IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ServerInformation_ServerInformationOrderNum' AND TYPE = 'P')
	DROP PROCEDURE sp_ServerInformation_ServerInformationOrderNum;
GO

CREATE PROCEDURE sp_ServerInformation_ServerInformationOrderNum
	@ServerInformationID		INT,
	@ServerID			INT,
	@OldOrderNumber			TINYINT,
	@NewOrderNumber			TINYINT
AS

	BEGIN TRANSACTION ChangeOrderNumber

	UPDATE ServerInformation SET
		ServerInformationOrderNum = @OldOrderNumber
	WHERE
		ServerID = @ServerID
		AND ServerInformationOrderNum = @NewOrderNumber

	UPDATE ServerInformation SET
		ServerInformationOrderNum = @NewOrderNumber
	WHERE
		ServerInformationID = @ServerInformationID;

	IF @@ERROR = 0 
		COMMIT TRANSACTION ChangeOrderNumber;	
	ELSE
		ROLLBACK TRANSACTION ChangeOrderNumber;	


GO

--EXEC sp_ServerInformation_ServerInformationOrderNum 1019, 1014, 2, 1
