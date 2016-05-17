IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Sessions_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Sessions_insert;
GO



CREATE PROCEDURE [dbo].[sp_Sessions_insert]
	@SessionID	VARCHAR(50),
	@SCRIPT_NAME	VARCHAR(500),
	@Application	VARCHAR(100),
	@IPAddress	VARCHAR(50),
	@Browser	VARCHAR(500),
	@Referer	VARCHAR(1000)
AS

	IF 
		NOT EXISTS (SELECT * FROM FilteredIPAddresses WHERE IPAddress = @IPAddress) AND
		NOT EXISTS (SELECT * FROM FilteredBrowsers WHERE Browser = @Browser) AND
		NOT EXISTS (SELECT * FROM Sessions WHERE Session_ID = @SessionID AND SCRIPT_NAME = @SCRIPT_NAME)
			BEGIN
				INSERT INTO Sessions
					(Session_ID, SCRIPT_NAME, Application, IPAddress, Browser, Referer)
				VALUES
					(@SessionID, @SCRIPT_NAME, @Application, @IPAddress, @Browser, @Referer);
			END

	IF @@IDENTITY IS NULL
		SELECT 0;
	ELSE
		SELECT 1;



GO

