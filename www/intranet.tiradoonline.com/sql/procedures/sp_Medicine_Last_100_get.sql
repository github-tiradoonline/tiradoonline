IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Medicine_Last_100_get' AND TYPE = 'P')
DROP PROCEDURE sp_Medicine_Last_100_get;
GO



CREATE PROCEDURE [dbo].[sp_Medicine_Last_100_get]
	@UserID			INT = NULL
AS
	
	SELECT TOP 100 
		MedicineDateTime = a.MedicineDoseDateTime,
		b.MedicineName, 
		b.GenericName, 
		MedicineAmount = CONVERT(VARCHAR, a.Amount) + ' ' + c.UnitName , a.*, MedicineDoseAmount = CONVERT(VARCHAR, a.Amount) + ' ' + c.UnitName  
	INTO
		#Medicine
	FROM 
		MedicineDose a, 
		Medicine b, 
		Unit c 
	WHERE 
		a.MedicineID = b.MedicineID 
		AND b.UnitID = c.UnitID 
		AND b.UserID = @UserID;
	
	SELECT TOP 100
		MedicineDateTime = SugarDateTime,
		MedicineName = '', 
		GenericName = 'SUGAR', 
		MedicineAmount = CONVERT(VARCHAR, Sugar)
	INTO
		#Medicine2
	FROM Sugar  

	SELECT * INTO #Medicine3 FROM #Medicine2;

	TRUNCATE TABLE #Medicine3;

	INSERT INTO #Medicine3
	(
		MedicineDateTime,
		MedicineName, 
		GenericName, 
		MedicineAmount)

		SELECT
			MedicineDateTime,
			MedicineName, 
			GenericName, 
			MedicineAmount
		FROM
			#Medicine
		UNION

		SELECT
			MedicineDateTime,
			MedicineName, 
			GenericName, 
			MedicineAmount
		FROM
			#Medicine2;
		

	SELECT 
		* 
	FROM 
		#Medicine3
	ORDER BY
		MedicineDateTime DESC;


GO

