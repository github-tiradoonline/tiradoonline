IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_HospitalPosition_update' AND TYPE = 'P')
	DROP PROCEDURE sp_HospitalPosition_update;
GO


CREATE PROCEDURE sp_HospitalPosition_update
	@HospitalPositionID		INT,	
	@HospitalPositionName		VARCHAR(100)
AS
	
	UPDATE HospitalPosition SET
		HospitalPositionName = @HospitalPositionName 
	WHERE
		HospitalPositionID = @HospitalPositionID;


GO

--EXEC sp_HospitalPosition_update 1001, '3/1/15', '3/31/15'