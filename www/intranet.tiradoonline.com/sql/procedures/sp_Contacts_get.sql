IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Contacts_get' AND TYPE = 'P')
DROP PROCEDURE sp_Contacts_get;
GO





CREATE PROCEDURE [dbo].[sp_Contacts_get]
	@UserID		INT,
	@Letter		VARCHAR(10) = null
AS 
	IF @Letter <> ''
		BEGIN
			SET @Letter = @Letter + '%';

			SELECT
				*,
				HomeState = (SELECT State FROM States WHERE StateID = Contacts.HomeAddressState),
				BusinessState = (SELECT State FROM States WHERE StateID = Contacts.BusinessAddressState)
			FROM 
				Contacts
			WHERE
				UserID = @UserID AND
				FileAs LIKE @Letter AND
				Active = 1
			ORDER BY
				FileAs;
		END
	ELSE
		BEGIN
			SELECT
				*,
				HomeState = HomeAddressState,
				BusinessState = BusinessAddressState
			FROM 
				Contacts
			WHERE
				UserID = @UserID AND
				Active = 1
			ORDER BY
				FileAs;

		END



GO

