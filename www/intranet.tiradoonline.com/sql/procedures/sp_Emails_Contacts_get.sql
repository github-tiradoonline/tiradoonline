IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Emails_Contacts_get' AND TYPE = 'P')
DROP PROCEDURE sp_Emails_Contacts_get;
GO


CREATE PROCEDURE [dbo].[sp_Emails_Contacts_get]
	@UserID		INT
AS

	SELECT 
		FullName = (FirstName + ' ' + LastName), 
		Email1Address
	FROM 
		Contacts 
	WHERE 
		UserID = @UserID AND 
		LTRIM(RTRIM(Email1Address)) <> '' 
	ORDER BY 
		FirstName


GO

