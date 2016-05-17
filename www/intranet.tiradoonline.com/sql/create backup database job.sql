USE [msdb]
GO

/****** Object:  Job [sp_Jobs_tiradoonline]    Script Date: 3/15/2015 2:17:48 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 3/15/2015 2:17:48 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'sp_Jobs_tiradoonline', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'tiradoonline_user', 
		@notify_email_operator_name=N'sp_Jobs_tiradoonline_Operator', 
		@notify_netsend_operator_name=N'sp_Jobs_tiradoonline_Operator', 
		@notify_page_operator_name=N'sp_Jobs_tiradoonline_Operator', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [sp_Jobs_tiradoonline_Step1]    Script Date: 3/15/2015 2:17:49 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'sp_Jobs_tiradoonline_Step1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE TIRADOONLINE;
GO

DECLARE @SQL						NVARCHAR(1000);


DECLARE @DATABASE_NAME					VARCHAR(100);
DECLARE @BACKUP_DEVICE_PATH				VARCHAR(1000);
DECLARE @BACKUP_FILE_NAME				VARCHAR(1000);
DECLARE @BACKUP_DATABASE_DEVICE_NAME			VARCHAR(1000);
DECLARE @BACKUP_DATABASE_DEVICE_FILENAME		VARCHAR(1000);
DECLARE @BACKUP_LOG_DEVICE_NAME				VARCHAR(1000);
DECLARE @BACKUP_LOG_DEVICE_FILENAME			VARCHAR(1000);
DECLARE @BACKUP_DATE					DATETIME;
DECLARE @BACKUP_DATE_STRING				VARCHAR(100);
DECLARE @BACKUP_TIME_STRING 				VARCHAR(100);

SET @BACKUP_DATE = GETDATE();

SET @BACKUP_DATE_STRING = '''';
SET @BACKUP_TIME_STRING = '''';

SET @BACKUP_DATE_STRING = @BACKUP_DATE_STRING + CONVERT(VARCHAR, DATEPART(MONTH, @BACKUP_DATE));
SET @BACKUP_DATE_STRING = @BACKUP_DATE_STRING + ''-'' + CONVERT(VARCHAR, DATEPART(DAY, @BACKUP_DATE));
SET @BACKUP_DATE_STRING = @BACKUP_DATE_STRING + ''-'' + CONVERT(VARCHAR, DATEPART(YEAR, @BACKUP_DATE));

SET @DATABASE_NAME		= ''tiradoonline'';
SET @BACKUP_DATABASE_DEVICE_NAME = @DATABASE_NAME + ''_backup_database_device''
SET @BACKUP_LOG_DEVICE_NAME = @DATABASE_NAME + ''_backup_log_device''

--SET @BACKUP_DEVICE_PATH	= ''C:\Storage\www\tiradoonline.com\intranet.tiradoonline.com\database\Backups'';
SET @BACKUP_DEVICE_PATH		= ''C:\Storage\www\tiradoonline.com\intranet.tiradoonline.com\database\Backups'';


SET @SQL = ''ALTER DATABASE '' + @DATABASE_NAME + '' SET RECOVERY FULL;''
PRINT '''';
PRINT @SQL;
EXEC(@SQL);


-- CREATE BACKUP DATABASE DEVICE
IF NOT EXISTS (SELECT * FROM MASTER..SYSDEVICES WHERE NAME = @BACKUP_DATABASE_DEVICE_NAME)
	BEGIN
		
		SET @BACKUP_DATABASE_DEVICE_FILENAME = @BACKUP_DEVICE_PATH + ''\'' + @BACKUP_DATABASE_DEVICE_NAME + ''.bak'';
		SET @SQL = ''EXEC MASTER..sp_addumpdevice ''''disk'''', '''''' + @BACKUP_DATABASE_DEVICE_NAME + '''''', '''''' + @BACKUP_DATABASE_DEVICE_FILENAME + '''''';'';

		BEGIN TRY
			PRINT '''';
			PRINT @SQL;
			EXEC(@SQL);
		END TRY
		BEGIN CATCH
			PRINT ''ERROR: '' + @SQL			

			SELECT
			    ERROR_NUMBER() AS ErrorNumber
			    ,ERROR_SEVERITY() AS ErrorSeverity
			    ,ERROR_STATE() AS ErrorState
			    ,ERROR_PROCEDURE() AS ErrorProcedure
			    ,ERROR_LINE() AS ErrorLine
			    ,ERROR_MESSAGE() AS ErrorMessage;		

		END CATCH; 

		SET @SQL = ''BACKUP DATABASE '' + @DATABASE_NAME + '' TO '' + @BACKUP_DATABASE_DEVICE_NAME + '';''
		BEGIN TRY
			PRINT '''';
			PRINT @SQL;
			EXEC(@SQL);
		END TRY
		BEGIN CATCH
			PRINT ''ERROR: '' + @SQL			

			SELECT
			    ERROR_NUMBER() AS ErrorNumber
			    ,ERROR_SEVERITY() AS ErrorSeverity
			    ,ERROR_STATE() AS ErrorState
			    ,ERROR_PROCEDURE() AS ErrorProcedure
			    ,ERROR_LINE() AS ErrorLine
			    ,ERROR_MESSAGE() AS ErrorMessage;		

		END CATCH; 
	END

-- CREATE BACKUP DATABASE LOG DEVICE
IF NOT EXISTS (SELECT * FROM MASTER..SYSDEVICES WHERE NAME = @BACKUP_LOG_DEVICE_NAME)
	BEGIN
		SET @BACKUP_LOG_DEVICE_FILENAME = @BACKUP_DEVICE_PATH + ''\'' + @BACKUP_LOG_DEVICE_NAME + ''.bak'';
		SET @SQL = ''EXEC MASTER..sp_addumpdevice ''''disk'''', '''''' + @BACKUP_LOG_DEVICE_NAME + '''''', '''''' + @BACKUP_LOG_DEVICE_FILENAME + '''''';'';

		BEGIN TRY
			PRINT '''';
			PRINT @SQL;
			EXEC(@SQL);

			SELECT
			    ERROR_NUMBER() AS ErrorNumber
			    ,ERROR_SEVERITY() AS ErrorSeverity
			    ,ERROR_STATE() AS ErrorState
			    ,ERROR_PROCEDURE() AS ErrorProcedure
			    ,ERROR_LINE() AS ErrorLine
			    ,ERROR_MESSAGE() AS ErrorMessage;		

		END TRY
		BEGIN CATCH
			PRINT ''ERROR: '' + @SQL			
		END CATCH; 

		SET @SQL = ''BACKUP LOG '' + @DATABASE_NAME + '' TO '' + @BACKUP_LOG_DEVICE_NAME + '';''
		BEGIN TRY
			PRINT '''';
			PRINT @SQL;
			EXEC(@SQL);
		END TRY
		BEGIN CATCH
			PRINT ''ERROR: '' + @SQL			

			SELECT
			    ERROR_NUMBER() AS ErrorNumber
			    ,ERROR_SEVERITY() AS ErrorSeverity
			    ,ERROR_STATE() AS ErrorState
			    ,ERROR_PROCEDURE() AS ErrorProcedure
			    ,ERROR_LINE() AS ErrorLine
			    ,ERROR_MESSAGE() AS ErrorMessage;		

		END CATCH; 
	END

SET @BACKUP_FILE_NAME = @BACKUP_DEVICE_PATH + ''\'' + @DATABASE_NAME + ''_'' + @BACKUP_DATE_STRING;
SET @BACKUP_TIME_STRING = SUBSTRING(CONVERT(VARCHAR, @BACKUP_DATE), CHARINDEX(''  '', CONVERT(VARCHAR(20), @BACKUP_DATE)), LEN(CONVERT(VARCHAR, @BACKUP_DATE)));
SET @BACKUP_TIME_STRING = REPLACE(@BACKUP_TIME_STRING, ''  '', '''');
SET @BACKUP_TIME_STRING = REPLACE(@BACKUP_TIME_STRING, '':'', ''_'');
SET @BACKUP_TIME_STRING = REPLACE(@BACKUP_TIME_STRING, ''AM'', ''_AM'');
SET @BACKUP_TIME_STRING = REPLACE(@BACKUP_TIME_STRING, ''PM'', ''_PM'');
SET @BACKUP_FILE_NAME = @BACKUP_FILE_NAME + ''____'' + @BACKUP_TIME_STRING + ''.bak'';

SET @SQL = ''BACKUP DATABASE '' + @DATABASE_NAME + '' TO DISK = '''''' + @BACKUP_FILE_NAME + '''''';'';
PRINT '''';
PRINT @SQL;
EXEC(@SQL);
', 
		@database_name=N'tiradoonline', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'sp_Jobs_tiradoonline_Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150314, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'0e174667-33e0-4602-b14e-e4ad4c34965e'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

