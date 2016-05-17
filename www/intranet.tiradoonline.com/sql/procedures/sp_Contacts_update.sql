IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Contacts_update' AND TYPE = 'P')
DROP PROCEDURE sp_Contacts_update;
GO



CREATE PROCEDURE [dbo].[sp_Contacts_update]
	@ContactID int,
        @EntryID varchar(50),
	@FileAs varchar(100),
        @FirstName varchar(20),
        @LastName varchar(20),
        @FullName varchar(50),
        @CompanyName varchar(100),
        @JobTitle varchar(50),
        @Email1Address varchar(100),
        @Email2Address varchar(100),
        @Email3Address varchar(100),
        @WebPage varchar(100),
        @IMAddress varchar(20),
        @MobileTelephoneNumber varchar(50),
        @HomeTelephoneNumber varchar(50),
        @BusinessTelephoneNumber varchar(50),
        @BusinessFaxNumber varchar(50),
        @HomeAddressStreet varchar(50),
        @HomeAddressCity varchar(50),
        @HomeAddressState varchar(50),
        @HomeAddressPostalCode varchar(50),
        @BusinessAddressStreet varchar(50),
        @BusinessAddressCity varchar(50),
        @BusinessAddressState varchar(50),
        @BusinessAddressPostalCode varchar(50),
	@HasPicture bit,
	@LastModificationTime datetime
AS
	
	UPDATE Contacts SET
		EntryID = @EntryID,
		FileAs = @FileAs,
		FirstName = @FirstName,
		LastName = @LastName,
		FullName = @FullName,
		CompanyName = @CompanyName,
		JobTitle = @JobTitle,
		Email1Address = @Email1Address,
		Email2Address = @Email2Address,
		Email3Address = @Email3Address,
		WebPage = @WebPage,
		IMAddress = @IMAddress,
		MobileTelephoneNumber = dbo.fn_FormatPhoneNumber(@MobileTelephoneNumber), 
		HomeTelephoneNumber = dbo.fn_FormatPhoneNumber(@HomeTelephoneNumber),
		BusinessTelephoneNumber = dbo.fn_FormatPhoneNumber(@BusinessTelephoneNumber),
		BusinessFaxNumber = dbo.fn_FormatPhoneNumber(@BusinessFaxNumber),
		HomeAddressStreet = @HomeAddressStreet,
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
		ContactID = @ContactID;



GO

