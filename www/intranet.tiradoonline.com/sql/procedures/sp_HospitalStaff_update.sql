IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_HospitalStaff_update' AND TYPE = 'P')
	DROP PROCEDURE sp_HospitalStaff_update;
GO


CREATE PROCEDURE sp_HospitalStaff_update
	@HospitalStaffID		INT,	
	@HospitalID			INT,
	@HospitalPositionID		INT,
	@FirstName			VARCHAR(50),
	@LastName			VARCHAR(50),
	@Notes				VARCHAR(MAX)
AS
	
	UPDATE HospitalStaff SET
		HospitalID = @HospitalID, 
		HospitalPositionID = @HospitalPositionID, 
		FirstName = @FirstName, 
		LastName = @LastName,
		Notes = @Notes
	WHERE
		HospitalStaffID = @HospitalStaffID;


GO

--EXEC sp_HospitalStaff_update 1001, '3/1/15', '3/31/15'