IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_SQLScripts_get' AND TYPE = 'P')
DROP PROCEDURE sp_SQLScripts_get;
GO




CREATE PROCEDURE [dbo].[sp_SQLScripts_get]
	@UserID		INT
AS
	
	SELECT 
		SQLScriptID, 
		SQLScriptShow = CASE 
				WHEN LEN(SQLScript) > 30 THEN 
			            Left(SQLScript, 30) + '...............'
                                ELSE 
				    SQLScript
			   END,
		SQLScript
	FROM 
		SQLScripts 
	WHERE 
		UserID = @UserID 
	ORDER BY 
		create_dt DESC;



GO

