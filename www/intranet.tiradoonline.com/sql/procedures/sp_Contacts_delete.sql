IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Contacts_delete' AND TYPE = 'P')
DROP PROCEDURE sp_Contacts_delete;
GO




CREATE PROCEDURE [dbo].[sp_Contacts_delete]
	@ContactID		INT
AS

	UPDATE Contacts SET 
		Active = 0
	WHERE
		ContactID = @ContactID;



GO

