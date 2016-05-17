IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Contacts_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Contacts_insert;
GO


               HomeAddressCity = @HomeAddressCity,
	                HomeAddressState = @HomeAddressState,
	                HomeAddressPostalCode = @HomeAddressPostalCode,
	                BusinessAddressStreet = @BusinessAddressStreet,
	                BusinessAddressCity = @BusinessAddressCity,
	                BusinessAddressState = @BusinessAddressState,
	     		BusinessAddressPostalCode = @BusinessAddressPostalCode,
			HasPicture = @HasPicture,
	                LastModificationTime = @LastModificationTime	
	WHERE
			EntryID = @EntryID;
	END




GO

