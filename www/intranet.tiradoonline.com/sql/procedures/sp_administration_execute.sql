IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_administration_execute' AND TYPE = 'P')
DROP PROCEDURE sp_administration_execute;
GO


CREATE PROCEDURE [dbo].[sp_administration_execute]
	@UserID		INT,
	@SQL		VARCHAR(2000)
AS
	EXEC(@SQL);
	EXEC sp_SQLScripts_insert @UserID, @SQL;



GO

