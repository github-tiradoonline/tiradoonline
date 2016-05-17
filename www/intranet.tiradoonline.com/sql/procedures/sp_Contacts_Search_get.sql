IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Contacts_Search_get' AND TYPE = 'P')
DROP PROCEDURE sp_Contacts_Search_get;
GO



CREATE PROCEDURE [dbo].[sp_Contacts_Search_get]
	@UserID		INT,
	@SearchString	VARCHAR(100)
AS

	IF @SearchString <> ''
		SET @SearchString = '%' + UPPER(@SearchString) + '%';

	SELECT 
		* 
	FROM 
		Contacts
	WHERE		
		UserID = @UserID AND
		Active = 1 AND
		(
		        UPPER(FirstName) LIKE @SearchString OR
		        UPPER(LastName) LIKE @SearchString OR
		        UPPER(FullName) LIKE @SearchString OR
		        UPPER(CompanyName) LIKE @SearchString OR
		        UPPER(JobTitle) LIKE @SearchString OR
		        UPPER(Email1Address) LIKE @SearchString OR
		        UPPER(Email2Address) LIKE @SearchString OR
		        UPPER(Email3Address) LIKE @SearchString OR
		        UPPER(WebPage) LIKE @SearchString OR
		        UPPER(IMAddress) LIKE @SearchString OR
		        UPPER(MobileTelephoneNumber) LIKE @SearchString OR
		        UPPER(HomeTelephoneNumber) LIKE @SearchString OR
		        UPPER(BusinessTelephoneNumber) LIKE @SearchString OR
		        UPPER(BusinessFaxNumber) LIKE @SearchString OR
		        UPPER(HomeAddressStreet) LIKE @SearchString OR
		        UPPER(HomeAddressCity) LIKE @SearchString OR
		        UPPER(HomeAddressState) LIKE @SearchString OR
		        UPPER(HomeAddressPostalCode) LIKE @SearchString OR
		        UPPER(BusinessAddressStreet) LIKE @SearchString OR
		        UPPER(BusinessAddressCity) LIKE @SearchString OR
		        UPPER(BusinessAddressState) LIKE @SearchString OR
		        UPPER(BusinessAddressPostalCode) LIKE @SearchString
		)
	ORDER BY
		FileAs;


GO

