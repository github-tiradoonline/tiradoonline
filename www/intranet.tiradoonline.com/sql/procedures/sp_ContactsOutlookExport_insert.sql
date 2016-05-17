IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ContactsOutlookExport_insert' AND TYPE = 'P')
DROP PROCEDURE sp_ContactsOutlookExport_insert;
GO



CREATE PROCEDURE [dbo].[sp_ContactsOutlookExport_insert]
        @EntryID varchar(50),
        @UserID int,
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
	@HasPicture BIT,
	@LastModificationTime DATETIME

AS 

	INSERT INTO ContactsOutlookExport
	(
		EntryID,
                UserID,
		FileAs,
                FirstName,
                LastName,
                FullName,
                CompanyName,
                JobTitle,
                Email1Address,
                Email2Address,
                Email3Address,
                WebPage,
                IMAddress,
                MobileTelephoneNumber,
                HomeTelephoneNumber,
                BusinessTelephoneNumber,
                BusinessFaxNumber,
                HomeAddressStreet,
                HomeAddressCity,
                HomeAddressState,
                HomeAddressPostalCode,
                BusinessAddressStreet,
                BusinessAddressCity,
                BusinessAddressState,
                BusinessAddressPostalCode,
		HasPicture,
                LastModificationTime,
		create_dt
	)
	VALUES
	(
		@EntryID,
                @UserID,
		@FileAs,
                @FirstName,
                @LastName,
                @FullName,
                @CompanyName,
                @JobTitle,
                @Email1Address,
                @Email2Address,
                @Email3Address,
                @WebPage,
                @IMAddress,
                @MobileTelephoneNumber,
                @HomeTelephoneNumber,
                @BusinessTelephoneNumber,
                @BusinessFaxNumber,
                @HomeAddressStreet,
                @HomeAddressCity,
                @HomeAddressState,
                @HomeAddressPostalCode,
                @BusinessAddressStreet,
                @BusinessAddressCity,
                @BusinessAddressState,
                @BusinessAddressPostalCode,
		@HasPicture,
		@LastModificationTime,
		GETDATE()
	);



GO

