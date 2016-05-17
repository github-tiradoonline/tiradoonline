IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Contacts_0_get' AND TYPE = 'P')
DROP PROCEDURE sp_Contacts_0_get;
GO



CREATE PROCEDURE [dbo].[sp_Contacts_0_get]
        @UserID int

AS 

	SELECT 
		HomeStateName = (SELECT State FROM States where StateID = Contacts.HomeAddressState),
		BusinessStateName = (SELECT State FROM States where StateID = Contacts.BusinessAddressState),
		* 
	FROM
		Contacts
	WHERE
		UserID = @UserID AND
		EntryID = '0' AND
		Active = 1;


GO

