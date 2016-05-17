IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Health_Last_100_Transactions' AND TYPE = 'P')
	DROP PROCEDURE sp_Health_Last_100_Transactions;
GO



CREATE PROCEDURE [dbo].[sp_Health_Last_100_Transactions]
	@UserID			INT
AS

	CREATE TABLE #HealthTransactions
	(
		HealthTransactionID				INT IDENTITY(1001, 1) NOT NULL,
		HealthTransactionDateTime		DATETIME NOT NULL,
		HealthTransaction				VARCHAR(100) NOT NULL,
		HealthTransactionAmount			VARCHAR(100) NOT NULL,
		create_dt						DATETIME DEFAULT GETDATE() NOT NULL
	);

	-- MEDICINE DOSE
	INSERT INTO #HealthTransactions
		(HealthTransactionDateTime, HealthTransaction, HealthTransactionAmount)
	SELECT a.MedicineDoseDateTime, 
						CASE 
							WHEN b.GenericName = '' THEN '<B>** MEDICINE **</B> - ' + b.MedicineName
							ELSE '<B>** MEDICINE **</B> - ' + b.MedicineName + ' (' + b.GenericName + ')'
						END,
				CONVERT(VARCHAR, a.Amount) FROM MedicineDose a, Medicine b WHERE a.MedicineID = b.MedicineID AND b.UserID = @UserID;

	-- BLOOD PRESSURE
	INSERT INTO #HealthTransactions
		(HealthTransactionDateTime, HealthTransaction, HealthTransactionAmount)
	SELECT BloodPressureDateTime, 'Blood Pressure', CONVERT(VARCHAR, BloodPressureTop) + '/' + CONVERT(VARCHAR, BloodPressureBottom) FROM BloodPressure WHERE UserID = @UserID;

	-- SUGAR
	INSERT INTO #HealthTransactions
		(HealthTransactionDateTime, HealthTransaction, HealthTransactionAmount)
	SELECT SugarDateTime, 'Sugar', CONVERT(VARCHAR, Sugar) FROM Sugar WHERE UserID = @UserID;

	-- HEARTRATE
	INSERT INTO #HealthTransactions
		(HealthTransactionDateTime, HealthTransaction, HealthTransactionAmount)
	SELECT HeartRateDateTime, 'Heart Rate', CONVERT(VARCHAR, HeartRate) FROM HeartRate WHERE UserID = @UserID;
	
	-- OXYGEN
	INSERT INTO #HealthTransactions
		(HealthTransactionDateTime, HealthTransaction, HealthTransactionAmount)
	SELECT OxygenDateTime, 'Oxygen', CONVERT(VARCHAR, Oxygen) FROM Oxygen WHERE UserID = @UserID;

	-- TEMPERATURE
	INSERT INTO #HealthTransactions
		(HealthTransactionDateTime, HealthTransaction, HealthTransactionAmount)
	SELECT TemperatureDateTime, 'Temperature', CONVERT(VARCHAR, Temperature) FROM Temperature WHERE UserID = @UserID;

	-- WEIGHT
	INSERT INTO #HealthTransactions
		(HealthTransactionDateTime, HealthTransaction, HealthTransactionAmount)
	SELECT WeightDateTime, 'Weight', CONVERT(VARCHAR, Weight) FROM Weight WHERE UserID = @UserID;

	SELECT TOP 100 * FROM #HealthTransactions ORDER BY HealthTransactionDateTime DESC;
GO

EXEC sp_Health_Last_100_Transactions 1001