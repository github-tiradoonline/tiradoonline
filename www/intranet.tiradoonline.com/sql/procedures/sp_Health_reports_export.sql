IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Health_reports_export' AND TYPE = 'P')
DROP PROCEDURE sp_Health_reports_export;
GO


e, Temperature)
		(
			SELECT
				TemperatureDateTime, 
				Temperature
			FROM 
				#Temperature_tmp
		);

	SET @MaxRows_tmp = @@ROWCOUNT;
	IF @MaxRows_tmp > @MaxRows
		SET @MaxRows = @MaxRows_tmp;

	SELECT
		BloodPressureDateTime, 
		BloodPressure = CONVERT(VARCHAR, BloodPressureTop) + '/' + CONVERT(VARCHAR, BloodPressureBottom)
	INTO
		#BloodPressure_tmp
	FROM 
		BloodPressure
	WHERE
		UserID = @UserID AND
		BloodPressureDateTime >= @StartDate AND
		BloodPressureDateTime <= @EndDate
	ORDER BY
		BloodPressureDateTime DESC;

	CREATE TABLE #BloodPressure
	(
		BloodPressureID		INT IDENTITY(1,1) NOT NULL,
		BloodPressureDateTime	DATETIME NULL,
		BloodPressure		VARCHAR(1000) NULL

	);

	INSERT INTO #BloodPressure
		(BloodPressureDateTime, BloodPressure)
		(
			SELECT
				BloodPressureDateTime, 
				BloodPressure
			FROM 
				#BloodPressure_tmp
		);

	SET @MaxRows_tmp = @@ROWCOUNT;
	--PRINT 'BloodPressure: ' + CONVERT(VARCHAR, @MaxRows_tmp);
	IF @MaxRows_tmp > @MaxRows
		SET @MaxRows = @MaxRows_tmp;
		
	WHILE (@MaxRows >= @RowID)
		BEGIN
			INSERT INTO #HealthReports (HealthReportID) VALUES (@RowID);
			SET @RowID = @RowID + 1;
		END

	UPDATE #HealthReports SET
		SugarDateTime = (SELECT SugarDateTime FROM #Sugar WHERE SugarID = #HealthReports.HealthReportID)
		, Sugar = (SELECT Sugar FROM #Sugar WHERE SugarID = #HealthReports.HealthReportID)
		, SugarComments = (SELECT SugarComments FROM #Sugar WHERE SugarID = #HealthReports.HealthReportID)
		, MedicineDoseDateTime = (SELECT MedicineDoseDateTime FROM #MedicineDose WHERE MedicineDoseID = #HealthReports.HealthReportID)
		, Medicine = (SELECT Medicine FROM #MedicineDose WHERE MedicineDoseID = #HealthReports.HealthReportID)
		, MedicineDoseAmount = (SELECT MedicineDoseAmount FROM #MedicineDose WHERE MedicineDoseID = #HealthReports.HealthReportID)
		, MedicineDoseDescription = (SELECT MedicineDoseDescription FROM #MedicineDose WHERE MedicineDoseID = #HealthReports.HealthReportID)
		, HeartRateDateTime = (SELECT HeartRateDateTime FROM #HeartRate WHERE HeartRateID = #HealthReports.HealthReportID)
		, HeartRate = (SELECT HeartRate FROM #HeartRate WHERE HeartRateID = #HealthReports.HealthReportID)
		, BloodPressureDateTime = (SELECT BloodPressureDateTime FROM #BloodPressure WHERE BloodPressureID = #HealthReports.HealthReportID)
		, BloodPressure = (SELECT BloodPressure FROM #BloodPressure WHERE BloodPressureID = #HealthReports.HealthReportID)
		, TemperatureDateTime = (SELECT TemperatureDateTime FROM #Temperature WHERE TemperatureID = #HealthReports.HealthReportID)
		, Temperature = (SELECT Temperature FROM #Temperature WHERE TemperatureID = #HealthReports.HealthReportID)
					

	/*
	SELECT * FROM #Medicine;
	SELECT * FROM #HeartRate;
	SELECT * FROM #Sugar;
	SELECT * FROM #Temperature;
	SELECT * FROM #BloodPressure;
	*/

	SELECT * FROM #HealthReports;


GO

