IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ServerInformation_insert' AND TYPE = 'P')
	DROP PROCEDURE sp_ServerInformation_insert;
GO

CREATE PROCEDURE sp_ServerInformation_insert
	@ServerID			INT,
	@ServerInformationName		VARCHAR(50),
	@ServerInformationValue		VARCHAR(MAX)
AS
	DECLARE @ServerInformationOrderNum		TINYINT;

	IF NOT EXISTS (SELECT 1 FROM ServerInformation WHERE ServerID = @ServerID AND ServerInformationName = @ServerInformationName)
		BEGIN
			SET @ServerInformationOrderNum = (SELECT ISNULL(MAX(ServerInformationOrderNum), 0) + 1 FROM ServerInformation WHERE ServerID = @ServerID);
			INSERT INTO ServerInformation
				(ServerID, ServerInformationOrderNum, ServerInformationName, ServerInformationValue)
			VALUES
				(@ServerID, @ServerInformationOrderNum, @ServerInformationName, @ServerInformationValue);

			PRINT convert(varchar, @ServerInformationOrderNum);
			SELECT @@IDENTITY;
		END
	ELSE
		SELECT ServerInformationID = 0
GO

--EXEC sp_ServerInformation_insert 1006, 'test3', 'test';