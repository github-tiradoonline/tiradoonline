IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobSalaryType_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobSalaryType_get;
GO




CREATE PROCEDURE [dbo].[sp_JobSalaryType_get]
AS


	SELECT
		JobSalaryTypeID,
		JobSalaryType
	FROM
		JobSalaryType
	ORDER BY
		JobSalaryType;
	


GO

