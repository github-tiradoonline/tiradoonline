IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Users_UserName_Password' AND TYPE = 'P')
DROP PROCEDURE sp_Users_UserName_Password;
GO




CREATE PROCEDURE [dbo].[sp_Users_UserName_Password]
	@UserName		VARCHAR(10),
	@Password		VARCHAR(10)
AS
		SELECT 
			FullName = FirstName + ' ' + LastName,
			*
		FROM 
			Users 
		WHERE 
			UserName = @UserName AND 
			Password = @Password AND
			Active = 1;



GO

