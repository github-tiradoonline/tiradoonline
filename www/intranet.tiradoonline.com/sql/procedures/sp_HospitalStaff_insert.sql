IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_HospitalStaff_insert' AND TYPE = 'P')
	DROP PROCEDURE sp_HospitalStaff_insert;
GO


CREATE PROCEDURE sp_HospitalStaff_insert
	@UserID				INT,
	@HospitalID			INT,
	@HospitalPositionID		INT,
	@FirstName			VARCHAR(50),
	@LastName			VARCHAR(50),
	@Notes				VARCHAR(MAX)
AS
	
	INSERT INTO HospitalStaff
		(UserID, HospitalID, HospitalPositionID, FirstName, LastName, Notes)
	VALUES
		(@UserID, @HospitalID, @HospitalPositionID, @FirstName, @LastName, @Notes);


GO

--EXEC sp_HospitalStaff_insert 1001, '3/1/15', '3/31/15'