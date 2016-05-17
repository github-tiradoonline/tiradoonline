IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_SQLScripts_insert' AND TYPE = 'P')
DROP PROCEDURE sp_SQLScripts_insert;
GO


CREATE PROCEDURE [dbo].[sp_SQLScripts_insert]
	@UserID		INT,
	@SQL		VARCHAR(2000)
AS
	IF NOT EXISTS(SELECT UserID FROM SQLScripts WHERE UserID = @UserID AND SQLScript = @SQL)
		INSERT INTO SQLScripts (UserID, SQLScript) VALUES (@UserID, @SQL);



GO

