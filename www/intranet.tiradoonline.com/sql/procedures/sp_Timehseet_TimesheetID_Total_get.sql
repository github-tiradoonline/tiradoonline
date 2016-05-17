IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timehseet_TimesheetID_Total_get' AND TYPE = 'P')
	DROP PROCEDURE sp_Timehseet_TimesheetID_Total_get;
GO

CREATE PROCEDURE sp_Timehseet_TimesheetID_Total_get
	@TimesheetID			INT
AS
	

	DECLARE @TimesheetType 		VARCHAR(50);
	DECLARE @TimesheetHours		NUMERIC(8,2);
	DECLARE @TimesheetHourlyRate	NUMERIC(8,2);
	DECLARE @TotalPay		NUMERIC(8,2) = 0.0;

	SELECT 
		@TimesheetType = b.TimesheetType,
		@TimesheetHourlyRate = a.TimesheetHourlyRate	
	FROM 
		Timesheet a,
		TimesheetType b
	WHERE
		a.TimesheetTypeID = b.TimesheetTypeID
		AND a.TimesheetID = @TimesheetID;

	IF @TimesheetType = 'Daily'
		BEGIN
			DECLARE @TotalDays 	INT = 0;
			
			SELECT 
				DISTINCT TimesheetDetailDate
			INTO
				#TimesheetDetail
			FROM 	
				TimesheetDetail
			WHERE
				TimesheetID = @TimesheetID;

			SELECT @TotalDays = COUNT(*) FROM #TimesheetDetail;
			SET @TotalPay = @TimesheetHourlyRate * @TotalDays;
		END


	ELSE IF @TimesheetType = 'Hourly'
		BEGIN

			DECLARE timesheetCURSOR CURSOR FOR
				SELECT 
					b.TimesheetHours
				FROM 
					Timesheet a,
					TimesheetDetail b
				WHERE
					a.TimesheetID = b.TimesheetID
					AND b.TimesheetBillable = 1
					AND a.TimesheetID = @TimesheetID;
			
			OPEN timesheetCURSOR;
			
			FETCH NEXT FROM timesheetCURSOR INTO @TimesheetHours;

			WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @TotalPay = @TotalPay + (@TimesheetHours * @TimesheetHourlyRate);
					PRINT '@TimesheetHours:' + CONVERT(VARCHAR, @TimesheetHours);
					PRINT '@TimesheetHourlyRate:' + CONVERT(VARCHAR, @TimesheetHourlyRate);
					FETCH NEXT FROM timesheetCURSOR INTO @TimesheetHours;
				END
		
			CLOSE timesheetCURSOR;
			DEALLOCATE timesheetCURSOR;

		END
	ELSE
		BEGIN
			SELECT @TotalPay = @TimesheetHourlyRate;
		END

	SELECT @TotalPay;
GO

EXEC sp_Timehseet_TimesheetID_Total_get 1007