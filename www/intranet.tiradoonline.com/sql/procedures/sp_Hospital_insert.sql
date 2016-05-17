	IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Hospital_insert' AND TYPE = 'P')
	DROP PROCEDURE sp_Hospital_insert;
	GO
	
	
	
	CREATE PROCEDURE [dbo].[sp_Hospital_insert]
		@UserID					INT,
		@HospitalName 				VARCHAR(100),
		@HospitalAddress 			VARCHAR(100),
		@HospitalCity 				VARCHAR(50),
		@HospitalStateID 			INT,
		@HospitalZipCode 			VARCHAR(20),
		@HospitalPhone				VARCHAR(50),
		@HospitalWebsite			VARCHAR(200)
	AS
		
		INSERT INTO Hospital
			(UserID, HospitalName, HospitalAddress, HospitalCity, HospitalStateID, HospitalZipCode, HospitalPhone, HospitalWebsite)
		VALUES
			(@UserID, @HospitalName, @HospitalAddress, @HospitalCity, @HospitalStateID, @HospitalZipCode, dbo.fn_FormatPhoneNumber(@HospitalPhone), @HospitalWebsite)
	
		SELECT @@IDENTITY;
	
	GO
	
