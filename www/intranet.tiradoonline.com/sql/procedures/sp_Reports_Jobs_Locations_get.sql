IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Reports_Jobs_Locations_get' AND TYPE = 'P')
DROP PROCEDURE sp_Reports_Jobs_Locations_get;
GO




CREATE PROCEDURE [dbo].[sp_Reports_Jobs_Locations_get]
	@UserID				INT
AS

	SELECT DISTINCT 
		City = JobCity,
		StateID = JobStateID,
		State = 'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS',
		TotalJobs = COUNT(*)
	INTO
		#Jobs
	FROM
		Jobs
	GROUP BY
		JobCity,
		JobStateID
	ORDER BY
		COUNT(*) DESC,
		JobStateID,
		JobCity;
	
	UPDATE #Jobs SET
		State = '';

	UPDATE #Jobs SET
		State = (SELECT State FROM States WHERE StateID = #Jobs.StateID)
	WHERE
		StateID IS NOT NULL;

	SELECT * FROM #Jobs ORDER BY TotalJobs DESC, State, City;
	
	


GO

