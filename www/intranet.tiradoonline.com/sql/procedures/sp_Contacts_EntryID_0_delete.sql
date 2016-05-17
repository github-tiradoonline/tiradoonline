IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Contacts_EntryID_0_delete' AND TYPE = 'P')
DROP PROCEDURE sp_Contacts_EntryID_0_delete;
GO



CREATE PROCEDURE [dbo].[sp_Contacts_EntryID_0_delete]
	@UserID		INT
AS

	DELETE FROM 
		Contacts 
	WHERE 
		EntryID = '0' AND 
		Active = 1 AND 
		UserID = @UserID;



GO

