IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ReferencedBy_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_ReferencedBy_UserID_get;
GO




CREATE PROCEDURE [dbo].[sp_ReferencedBy_UserID_get]
	@UserID			INT
AS
	
	
	SELECT 
		ReferencedByID, 
		ReferencedByName
	FROM 
		ReferencedBy
	WHERE 
		UserID = @UserID 
	ORDER BY 
		 OrderNum;


GO

