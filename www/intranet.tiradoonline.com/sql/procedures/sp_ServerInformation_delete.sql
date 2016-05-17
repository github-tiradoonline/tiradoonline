IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ServerInformation_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_ServerInformation_delete;
GO

CREATE PROCEDURE sp_ServerInformation_delete
	@ServerInformationID		INT,
	@ServerID			INT
AS
	DECLARE @ServerInformationOrderNum		TINYINT;
	DECLARE @OrderNum				TINYINT;
	DECLARE @SQL					NVARCHAR(1000);

	BEGIN TRANSACTION DeleteServerInformation

	DELETE FROM ServerInformation WHERE ServerInformationID = @ServerInformationID;


	DECLARE ServerInformation_cursor CURSOR FOR 
		SELECT ServerInformationID FROM ServerInformation WHERE ServerID = @ServerID ORDER BY ServerInformationOrderNum;

	OPEN ServerInformation_cursor
	FETCH NEXT FROM ServerInformation_cursor INTO @ServerInformationID

	SET @OrderNum = 1;
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @SQL = 'UPDATE ServerInformation SET ServerInformationOrderNum = ' + CONVERT(NVARCHAR, @OrderNum) + ' WHERE ServerInformationID = ' + CONVERT(NVARCHAR, @ServerInformationID)
			PRINT @SQL
			EXEC sp_executesql @SQL;
			SET @OrderNum = @OrderNum + 1;
			FETCH NEXT FROM ServerInformation_cursor INTO @ServerInformationID
		END

	CLOSE ServerInformation_cursor
	DEALLOCATE ServerInformation_cursor



	IF @@ERROR = 0
		COMMIT TRANSACTION DeleteServerInformation;
	ELSE
		ROLLBACK TRANSACTION DeleteServerInformation;

GO

-- EXEC sp_ServerInformation_delete 1010, 1011;
-- 
-- SELECT * FROM ServerInformation where serverid = 1011 order by serverinformationordernum