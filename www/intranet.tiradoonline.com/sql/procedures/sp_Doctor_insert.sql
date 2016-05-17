IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Doctor_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Doctor_insert;
GO



CREATE PROCEDURE [dbo].[sp_Doctor_insert]
	@UserID			INT,
	@FirstName		VARCHAR(20),
	@LastName		VARCHAR(50),
	@TelephoneNumber	VARCHAR(50)
AS
	
	INSERT INTO Doctor 
		(UserID, FirstName, LastName, TelephoneNumber)
	VALUES
		(@UserID, @FirstName, @LastName, dbo.fn_FormatPhoneNumber(@TelephoneNumber));

	SELECT @@IDENTITY;



GO

