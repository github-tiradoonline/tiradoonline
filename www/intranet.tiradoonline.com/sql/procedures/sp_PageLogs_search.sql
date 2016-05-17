IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_PageLogs_search' AND TYPE = 'P')
DROP PROCEDURE sp_PageLogs_search;
GO


CREATE PROCEDURE [dbo].[sp_PageLogs_search]
	@Keyword		VARCHAR(100)

AS

	SET @Keyword = '%' + @Keyword + '%';

	SELECT 
		
		FullName = b.FirstName + ' ' + b.LastName,
		a.* 
	FROM 
		PageLogs a,
		Users b
	WHERE
		a.UserID = b.UserID AND
		(UPPER(QUERY_STRING) LIKE UPPER(@Keyword) OR 
		UPPER(FORM) LIKE UPPER(@Keyword))
	ORDER BY 
		a.create_dt DESC;




GO

