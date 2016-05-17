IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_HospitalPosition_insert' AND TYPE = 'P')
	DROP PROCEDURE sp_HospitalPosition_insert;
GO


CREATE PROCEDURE sp_HospitalPosition_insert
	@UserID				INT,
	@HospitalPositionName		VARCHAR(100)
AS
	
	INSERT INTO HospitalPosition
		(UserID, HospitalPositionName)
	VALUES
		(@UserID, @HospitalPositionName);


GO

--EXEC sp_HospitalPosition_insert 1001, '3/1/15', '3/31/15'