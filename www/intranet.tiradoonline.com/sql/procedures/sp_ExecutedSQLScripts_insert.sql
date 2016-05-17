IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ExecutedSQLScripts_insert' AND TYPE = 'P')
DROP PROCEDURE sp_ExecutedSQLScripts_insert;
GO




CREATE PROCEDURE [dbo].[sp_ExecutedSQLScripts_insert]
	@ApplicationName	VARCHAR(100),
	@ExecutedSQLScript	VARCHAR(1000)
AS
	
	INSERT INTO ExecutedSQLScripts
		(ApplicationName, ExecutedSQLScript)
	VALUES
		(@ApplicationName, @ExecutedSQLScript);




GO

