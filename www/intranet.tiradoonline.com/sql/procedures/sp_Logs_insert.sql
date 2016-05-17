IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Logs_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Logs_insert;
GO




CREATE PROCEDURE [dbo].[sp_Logs_insert]
	@ApplicationName	VARCHAR(1000),
	@LogDesc		VARCHAR(MAX)
AS
	INSERT INTO Logs
		(ApplicationName, LogDesc) 
	VALUES 
		(@ApplicationName, @LogDesc);



GO

