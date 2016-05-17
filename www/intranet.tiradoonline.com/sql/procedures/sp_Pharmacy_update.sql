IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Pharmacy_update' AND TYPE = 'P')
DROP PROCEDURE sp_Pharmacy_update;
GO



CREATE PROCEDURE [dbo].[sp_Pharmacy_update]
	@PharmacyID			INT,
	@PharmacyName 			VARCHAR(100),
	@PharmacyAddress        	VARCHAR(100),
	@PharmacyCity			VARCHAR(50), 
	@PharmacyStateID		INT,
	@PharmacyZipCode		VARCHAR(20), 
	@PharmacyTelephoneNumber 	VARCHAR(20)
AS
	
	UPDATE Pharmacy SET
		PharmacyName = @PharmacyName,
		PharmacyAddress = @PharmacyAddress,
		PharmacyCity = @PharmacyCity,
		PharmacyStateID = @PharmacyStateID,
		@PharmacyZipCode = @PharmacyZipCode,
		PharmacyTelephoneNumber = dbo.fn_FormatPhoneNumber(@PharmacyTelephoneNumber)
	WHERE
		PharmacyID = @PharmacyID;


GO

