IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Hospital_update' AND TYPE = 'P')
	DROP PROCEDURE sp_Hospital_update;
GO

CREATE PROCEDURE [dbo].[sp_Hospital_update]
	@HospitalID				INT,
	@HospitalName 				VARCHAR(100),
	@HospitalAddress 			VARCHAR(100),
	@HospitalCity 				VARCHAR(50),
	@HospitalStateID 			INT,
	@HospitalZipCode 			VARCHAR(20),
	@HospitalPhone				VARCHAR(50),
	@HospitalWebsite			VARCHAR(200)
AS
	
	UPDATE Hospital SET
		HospitalName = @HospitalName,
		HospitalAddress = @HospitalAddress,
		HospitalCity = @HospitalCity,
		HospitalStateID = @HospitalStateID,
		HospitalZipCode = @HospitalZipCode,	
		HospitalPhone = dbo.fn_FormatPhoneNumber(@HospitalPhone),
		HospitalWebsite = @HospitalWebsite
	WHERE
		HospitalID = @HospitalID;




GO

