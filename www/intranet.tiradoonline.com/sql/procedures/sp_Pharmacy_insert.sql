IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Pharmacy_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Pharmacy_insert;
GO



CREATE PROCEDURE [dbo].[sp_Pharmacy_insert]
	@UserID				INT,
	@PharmacyName 			VARCHAR(100),
	@PharmacyAddress        	VARCHAR(100),
	@PharmacyCity			VARCHAR(50), 
	@PharmacyStateID		INT,
	@PharmacyZipCode		VARCHAR(20), 
	@PharmacyTelephoneNumber 	VARCHAR(20)
AS
	
	INSERT INTO Pharmacy 
		(UserID, PharmacyName, PharmacyAddress, PharmacyCity, PharmacyStateID, PharmacyZipCode, PharmacyTelephoneNumber)
	VALUES
		(@UserID, @PharmacyName, @PharmacyAddress, @PharmacyCity, @PharmacyStateID, @PharmacyZipCode, dbo.fn_FormatPhoneNumber(@PharmacyTelephoneNumber));

	SELECT @@IDENTITY;



GO

