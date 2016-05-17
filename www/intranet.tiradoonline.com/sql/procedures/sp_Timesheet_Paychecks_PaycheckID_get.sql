IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timesheet_Paychecks_PaycheckID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Timesheet_Paychecks_PaycheckID_get;
GO



CREATE PROCEDURE [dbo].[sp_Timesheet_Paychecks_PaycheckID_get]
	@PaycheckID			INT
AS
	
	SELECT 
		*			
	FROM 		
			
		Paychecks
	WHERE 
		PaycheckID = @PaycheckID;



GO

