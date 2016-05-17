IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ResumeAnonymous_ResumeFile_get' AND TYPE = 'P')
	DROP PROCEDURE sp_ResumeAnonymous_ResumeFile_get;
GO

CREATE PROCEDURE sp_ResumeAnonymous_ResumeFile_get
AS
	
	SELECT 
		ResumeFile,
		TotalDownloads = COUNT(*)
	FROM
		ResumeAnonymous
	GROUP BY
		ResumeFile
	ORDER BY
		COUNT(*) DESC;



GO

exec sp_ResumeAnonymous_ResumeFile_get