IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobInterview_ALL_JobInterviewDateTime_get' AND TYPE = 'P')
	DROP PROCEDURE sp_JobInterview_ALL_JobInterviewDateTime_get;
GO

CREATE PROCEDURE sp_JobInterview_ALL_JobInterviewDateTime_get
	@UserID				INT,
	@JobInterviewDateTime			SMALLDATETIME
AS

	SELECT DISTINCT 
		a.JobInterviewID,
		JobInterviewDateTime = a.JobInterviewDateTime,
		JobCompanyName = b.JobCompanyName,
		c.JobInterviewType
	FROM 
		JobInterview a,
		JobCompany b,
		JobInterviewType c
	WHERE
		a.JobInterviewClientID = b.JobCompanyID
		AND a.JobInterviewTypeID = c.JobInterviewTypeID
		AND b.UserID = @UserID
		AND DATEPART(month, a.JobInterviewDateTime) = MONTH(@JobInterviewDateTime)
		AND DATEPART(year, a.JobInterviewDateTime) = YEAR(@JobInterviewDateTime)
	GROUP BY
		a.JobInterviewID,
		a.JobInterviewDateTime,
		b.JobCompanyName,
		c.JobInterviewType


GO
EXEC sp_JobInterview_ALL_JobInterviewDateTime_get 1001, '6/1/15'