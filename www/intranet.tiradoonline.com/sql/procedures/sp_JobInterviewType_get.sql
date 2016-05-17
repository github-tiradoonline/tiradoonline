IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobInterviewType_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobInterviewType_get;
GO




CREATE PROCEDURE [dbo].[sp_JobInterviewType_get]
AS


	SELECT
		JobInterviewTypeID,
		JobInterviewType
	FROM
		JobInterviewType
	ORDER BY
		JobInterviewType;
	


GO

