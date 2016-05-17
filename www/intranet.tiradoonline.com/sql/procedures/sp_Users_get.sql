IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Users_get' AND TYPE = 'P')
DROP PROCEDURE sp_Users_get;
GO




CREATE PROCEDURE [dbo].[sp_Users_get]
AS
	SELECT 
		UserID, 
		UserName, 
		Password,
		Email
	FROM 
		Users 
	ORDER BY 
		UserName;



GO

