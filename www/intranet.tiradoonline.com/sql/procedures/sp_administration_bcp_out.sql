IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_administration_bcp_out' AND TYPE = 'P')
DROP PROCEDURE sp_administration_bcp_out;
GO


CREATE PROCEDURE [dbo].[sp_administration_bcp_out]
AS

	DECLARE @dbname 		VARCHAR(30);
	DECLARE @FilePath		VARCHAR(200);
	DECLARE @FileName		VARCHAR(200);
	DECLARE @tablename 		VARCHAR(30);
	DECLARE @tableowner 		VARCHAR(30);
	DECLARE @sql_string 		VARCHAR(200);

	SET @dbname = 'teddy';
	SET @FilePath = 'D:\www\teddy\data\backup\' + CONVERT(VARCHAR, DATEPART(month, GETDATE())) + '_' + CONVERT(VARCHAR, DATEPART(day, GETDATE())) + '_' + CONVERT(VARCHAR, DATEPART(year, GETDATE())) + '_' + CONVERT(VARCHAR, DATEPART(hour, GETDATE())) + '_' + CONVERT(VARCHAR, DATEPART(minute, GETDATE())) + '_' + CONVERT(VARCHAR, DATEPART(second, GETDATE())) + '_' + RIGHT(CONVERT(VARCHAR, GETDATE()), 2);
	SET @sql_string = 'MKDIR ' + @FilePath;
	PRINT @sql_string;
	EXEC master..xp_cmdshell @sql_string

	PRINT 'SELECT NAME, USER_NAME(UID) AS TABLEOWNER FROM SYSOBJECTS WHERE TYPE = ''U'' AND LEFT(NAME, 2) <> ''dt'' ORDER BY NAME';
	DECLARE cNames 	CURSOR FOR SELECT NAME, USER_NAME(UID) AS TABLEOWNER FROM teddy..SYSOBJECTS WHERE TYPE = 'U' AND LEFT(NAME, 2) <> 'dt' ORDER BY NAME;

	OPEN cNames
	FETCH NEXT FROM cNames INTO @tablename, @tableowner
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @sql_string = '"C:\Program Files\Microsoft SQL Server\80\Tools\Binn\bcp" ' + @dbname + '.' + @tableowner + '.' + @tablename + ' out ' + @FilePath + '\' + @tablename + '.txt -c -Usa -Psixpak';
		PRINT @sql_string;
		EXEC master..xp_cmdshell @sql_string
		FETCH NEXT FROM cNames INTO @tablename, @tableowner
	END
	CLOSE cNames
	DEALLOCATE cNames



GO

