IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Doctor_update' AND TYPE = 'P')
DROP PROCEDURE sp_Doctor_update;
GO


CREATE PROCEDURE [dbo].[sp_Doctor_update]
	@DoctorID			INT,
	@FirstName		VARCHAR(20),
	@LastName		VARCHAR(50),
	@TelephoneNumber	VARCHAR(50)
AS
	
	UPDATE Doctor SET
		FirstName = @FirstName,
		LastName = @LastName, 
		TelephoneNumber =  dbo.fn_FormatPhoneNumber(@TelephoneNumber)
	WHERE
		DoctorID = @DoctorID;




GO

