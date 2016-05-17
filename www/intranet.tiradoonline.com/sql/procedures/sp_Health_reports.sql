IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Health_reports' AND TYPE = 'P')
DROP PROCEDURE sp_Health_reports;
GO


CREATE PROCEDURE [dbo].[sp_Health_reports]
	@UserID			INT,
	@TotalDays		INT,
	@ReportType		TINYINT = 1
	-- 1 = AVERAGE OF ALL: HeartRate, Sugar, Temperature, BloodPressure
	-- 2 = ALL MEDICINES TAKEN AND AMOUNT
	-- 3 = SHOWS ALL HEALTH, 
AS
	SET NOCOUNT ON;

	IF @ReportType = 1
		BEGIN	
			DECLARE @SQL		NVARCHAR(2000);
		
			SET @SQL = '';
			SET @SQL = @SQL + 'DECLARE @HeartRate		NUMERIC(9,2);' + CHAR(13);
			SET @SQL = @SQL + 'SELECT TOP ' + CONVERT(VARCHAR, @TotalDays) + ' HeartRate INTO #HeartRate FROM HeartRate WHERE UserID = ' + CONVERT(VARCHAR, @UserID) + ' ORDER BY create_dt DESC;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT @HeartRate = SUM(HeartRate) / ' + CONVERT(VARCHAR, @TotalDays) + ' FROM #HeartRate;' + CHAR(13);
			SET @SQL = @SQL + 'DECLARE @Sugar		NUMERIC(9,2);' + CHAR(13);
			SET @SQL = @SQL + 'SELECT TOP ' + CONVERT(VARCHAR, @TotalDays) + ' Sugar INTO #Sugar FROM Sugar WHERE UserID = ' + CONVERT(VARCHAR, @UserID) + ' ORDER BY create_dt DESC;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT @Sugar = SUM(Sugar) / ' + CONVERT(VARCHAR, @TotalDays) + ' FROM #Sugar;' + CHAR(13);
			SET @SQL = @SQL + 'DECLARE @Temperature		NUMERIC(9,2);' + CHAR(13);
			SET @SQL = @SQL + 'SELECT TOP ' + CONVERT(VARCHAR, @TotalDays) + ' Temperature INTO #Temperature FROM Temperature WHERE UserID = ' + CONVERT(VARCHAR, @UserID) + ' ORDER BY create_dt DESC;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT @Temperature = SUM(Temperature) / ' + CONVERT(VARCHAR, @TotalDays) + ' FROM #Temperature;' + CHAR(13);
			SET @SQL = @SQL + 'DECLARE @BloodPressureTop		NUMERIC(9,2);' + CHAR(13);
			SET @SQL = @SQL + 'SELECT TOP ' + CONVERT(VARCHAR, @TotalDays) + ' BloodPressureTop INTO #BloodPressureTop FROM BloodPressure WHERE UserID = ' + CONVERT(VARCHAR, @UserID) + ' ORDER BY create_dt DESC;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT @BloodPressureTop = SUM(BloodPressureTop) / ' + CONVERT(VARCHAR, @TotalDays) + ' FROM #BloodPressureTop;' + CHAR(13);
			SET @SQL = @SQL + 'DECLARE @BloodPressureBottom		NUMERIC(9,2);' + CHAR(13);
			SET @SQL = @SQL + 'SELECT TOP ' + CONVERT(VARCHAR, @TotalDays) + ' BloodPressureBottom INTO #BloodPressureBottom FROM BloodPressure WHERE UserID = ' + CONVERT(VARCHAR, @UserID) + ' ORDER BY create_dt DESC;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT @BloodPressureBottom = SUM(BloodPressureBottom) / ' + CONVERT(VARCHAR, @TotalDays) + ' FROM #BloodPressureBottom;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT ' + CHAR(13);
			SET @SQL = @SQL + 'HeartRate = @HeartRate, ' + CHAR(13);
			SET @SQL = @SQL + 'Sugar = @Sugar, ' + CHAR(13);
			SET @SQL = @SQL + 'Temperature = @Temperature, ' + CHAR(13);
			SET @SQL = @SQL + 'BloodPressureTop = @BloodPressureTop, ' + CHAR(13);
			SET @SQL = @SQL + 'BloodPressureBottom = @BloodPressureBottom, ' + CHAR(13);
			SET @SQL = @SQL + 'BloodPressure = CONVERT(VARCHAR, @BloodPressureTop) + ''/'' + CONVERT(VARCHAR, @BloodPressureBottom)' + CHAR(13);
		
			--PRINT @SQL;
			EXEC(@SQL);
		END

	ELSE IF @ReportType = 2

		BEGIN
			SELECT 
				MedicineID,
				Medicine = Replace(MedicineName + ' (' + GenericName + ')', ' ()', ''), 
				Total = (SELECT COUNT(*) FROM MedicineDose WHERE MedicineID = Medicine.MedicineID)
			FROM 
				Medicine 
			WHERE 
				UserID = @UserID
			ORDER BY
				Medicine;
		END

	ELSE IF @ReportType = 3

		BEGIN
			SELECT 
				MedicineID,
				Medicine = Replace(MedicineName + ' (' + GenericName + ')', ' ()', ''), 
				Total = (SELECT COUNT(*) FROM MedicineDose WHERE MedicineID = Medicine.MedicineID)
			FROM 
				Medicine 
			WHERE 
				UserID = @UserID
			ORDER BY
				Medicine;
		END



GO

