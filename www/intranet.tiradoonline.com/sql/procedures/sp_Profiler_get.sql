IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Profiler_get' AND TYPE = 'P')
DROP PROCEDURE sp_Profiler_get;
GO



CREATE PROCEDURE [dbo].[sp_Profiler_get]
	@ProfilerType		INT = 3
AS

	IF (@ProfilerType = 1)
		BEGIN	

			SELECT TOP 50
				create_dt AS Time,
				ApplicationName AS Application,
				ExecutedSQLScript AS SQL
			FROM
				ExecutedSQLScripts
			ORDER BY
				create_dt 
			DESC;
		
		END

	ELSE IF (@ProfilerType = 2)
		BEGIN	

			SELECT TOP 50
				create_dt AS Time,
				ApplicationName AS Application,
				LogDesc AS [Log]
			FROM
				Logs
			ORDER BY
				create_dt 
			DESC;
		
		END

	ELSE IF (@ProfilerType = 3)
		BEGIN	
			CREATE TABLE #Profiler
			(
				Time		DATETIME NOT NULL,
				[Application]	VARCHAR(1000),
				[SQL/Log]	VARCHAR(1000)
			);

			INSERT INTO #Profiler
				([Time], [Application], [SQL/Log])
				SELECT TOP 50
					create_dt AS Time,
					ApplicationName AS Application,
					LogDesc AS [Log]
				FROM
					Logs
				ORDER BY
					create_dt 
				DESC;
		
			INSERT INTO #Profiler
				([Time], [Application], [SQL/Log])
			SELECT TOP 50
				create_dt AS Time,
				ApplicationName AS Application,
				ExecutedSQLScript AS SQL
			FROM
				ExecutedSQLScripts
			ORDER BY
				create_dt 
			DESC;

			SELECT 
				*
			FROM
				#Profiler
			ORDER BY
				[TIME]
			DESC;
			
		END



GO

