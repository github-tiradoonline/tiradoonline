IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_RecoveryDrugTestType_get' AND TYPE = 'P')
DROP PROCEDURE sp_RecoveryDrugTestType_get;
GO



CREATE PROCEDURE sp_RecoveryDrugTestType_get
AS
	
	SELECT
		* 
	FROM
		RecoveryDrugTestType

GO

EXEC sp_RecoveryDrugTestType_get