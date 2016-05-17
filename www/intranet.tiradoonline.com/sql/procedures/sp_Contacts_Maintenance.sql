IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Contacts_Maintenance' AND TYPE = 'P')
DROP PROCEDURE sp_Contacts_Maintenance;
GO




CREATE PROCEDURE [dbo].[sp_Contacts_Maintenance]
AS

	UPDATE Contacts SET
	        MobileTelephoneNumber = dbo.fn_FormatPhoneNumber(MobileTelephoneNumber),
	        HomeTelephoneNumber = dbo.fn_FormatPhoneNumber(HomeTelephoneNumber),
	        BusinessTelephoneNumber = dbo.fn_FormatPhoneNumber(BusinessTelephoneNumber),
	        BusinessFaxNumber = dbo.fn_FormatPhoneNumber(BusinessFaxNumber),
		LastModificationTime = GETDATE();



GO

