IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_States_get' AND TYPE = 'P')
DROP PROCEDURE sp_States_get;
GO




CREATE PROCEDURE [dbo].[sp_States_get]
AS
	SELECT
 		StateID, 
		State 
	FROM 
		States 
	ORDER BY 
		State;



GO

