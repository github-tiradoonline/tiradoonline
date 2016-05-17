IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ResumeAnonymous_get' AND TYPE = 'P')
	DROP PROCEDURE sp_ResumeAnonymous_get;
GO

CREATE PROCEDURE sp_ResumeAnonymous_get
AS
	
	SELECT 
		*
	FROM
		ResumeAnonymous
	ORDER BY
		create_dt DESC;



GO

exec sp_ResumeAnonymous_get