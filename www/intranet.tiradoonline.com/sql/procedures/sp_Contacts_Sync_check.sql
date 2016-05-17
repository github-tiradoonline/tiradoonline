IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Contacts_Sync_check' AND TYPE = 'P')
DROP PROCEDURE sp_Contacts_Sync_check;
GO


xNumber = b.BusinessFaxNumber,
	        ContactsOutlookExportHomeAddressStreet = b.HomeAddressStreet,
	        ContactsOutlookExportHomeAddressCity = b.HomeAddressCity,
	        ContactsOutlookExportHomeAddressState = b.HomeAddressState,
	        ContactsOutlookExportHomeAddressPostalCode = b.HomeAddressPostalCode,
	        ContactsOutlookExportBusinessAddressStreet = b.BusinessAddressStreet,
	        ContactsOutlookExportBusinessAddressCity = b.BusinessAddressCity,
	        ContactsOutlookExportBusinessAddressState = b.BusinessAddressState,
	        ContactsOutlookExportBusinessAddressPostalCode = b.BusinessAddressPostalCode,
	        ContactsOutlookExportHasPicture = b.HasPicture
	FROM
		Contacts a,
		ContactsOutlookExport b
	WHERE
		a.EntryID = b.EntryID AND
		a.UserID = @UserID AND
		a.Active = 1 AND
		a.LastModificationTime <> b.LastModificationTime;




GO

