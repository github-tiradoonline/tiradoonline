IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_TimesheetDetail_TimesheetID_get' AND TYPE = 'P')
DROP PROCEDURE sp_TimesheetDetail_TimesheetID_get;
GO



CREATE PROCEDURE [dbo].[sp_TimesheetDetail_TimesheetID_get]
	@TimesheetID		INT
AS


	SELECT 
		TotalTimesheetEntries = 
			(
				SELECT 
					COUNT(*)
				FROM
					TimesheetDetail
				WHERE
					TimesheetID = a.TimesheetID AND
					TimesheetDetailDate = a.TimesheetDetailDate
			),
		a.* 
	FROM 
		TimesheetDetail a
	WHERE 
		a.TimesheetID = @TimesheetID
	ORDER BY 
		a.TimesheetDetailDate DESC,
		a.create_dt DESC;



GO

