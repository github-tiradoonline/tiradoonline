IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Companies_Count' AND TYPE = 'P')
DROP PROCEDURE sp_Companies_Count;
GO


CREATE PROCEDURE [dbo].[sp_Companies_Count]
	@UserID		INT
AS
	SELECT COUNT(*) AS TOTAL FROM Companies WHERE UserID = @UserID


GO

