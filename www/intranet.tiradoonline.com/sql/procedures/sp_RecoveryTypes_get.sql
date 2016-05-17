IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_RecoveryTypes_get' AND TYPE = 'P')
DROP PROCEDURE sp_RecoveryTypes_get;
GO


CREATE PROCEDURE sp_RecoveryTypes_get
	@RecoveryTypeID		INT = NULL
AS
	
	IF @RecoveryTypeID IS NULL
		 BEGIN
			SELECT 
				RecoveryTypeID,
				RecoveryTypeName
			FROM 
				RecoveryTypes
		END
	ELSE
		BEGIN
			SELECT 
				RecoveryTypeID,
				RecoveryTypeName
			FROM 
				RecoveryTypes
			WHERE
				RecoveryTypeID = @RecoveryTypeID;
		END


GO

EXEC sp_RecoveryTypes_get 1001