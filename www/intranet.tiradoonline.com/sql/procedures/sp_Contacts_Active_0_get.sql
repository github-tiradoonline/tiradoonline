IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Contacts_Active_0_get' AND TYPE = 'P')
DROP PROCEDURE sp_Contacts_Active_0_get;
GO



CREATE PROCEDURE [dbo].[sp_Contacts_Active_0_get]
	@UserID		INT
AS

	SELECT 
		* 
	FROM 
		Contacts
	WHERE		
		UserID = @UserID AND
		Active = 0 AND
		EntryID <> '0';



GO

