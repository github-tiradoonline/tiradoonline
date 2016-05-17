IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Users_update' AND TYPE = 'P')
DROP PROCEDURE sp_Users_update;
GO



CREATE PROCEDURE sp_Users_update
	@UserID				INT,
	@UserName			VARCHAR(100),
	@Password			VARCHAR(100),
	@FirstName			VARCHAR(50),
	@LastName			VARCHAR(50),
	@Email				VARCHAR(100),
	@MobileEmail		VARCHAR(100),
	@Address1			VARCHAR(100),
	@Address2			VARCHAR(100),
	@City				VARCHAR(100),
	@StateID			INT,
	@Phone				VARCHAR(50),
	@AIM				VARCHAR(50),
	@Yahoo				VARCHAR(50),
	@Hotmail			VARCHAR(50),
	@Skype				VARCHAR(50),
	@Gmail				VARCHAR(50),
	@UserTypeID			BIT,
	@Contacts			BIT,
	@PersonalInformation		BIT,
	@Documents			BIT,
	@Banking			BIT,
	@CreditCards			BIT,
	@Photos				BIT,
	@Music				BIT,
	@MovieCollection		BIT,
	@Movies				BIT,
	@Snippets			BIT,
	@Health				BIT,
	@Jobs				BIT,
	@Recovery			BIT,
	@Timesheet			BIT,
	@Notes				BIT,
	@tiradoonline			BIT,
	@Active				BIT,
	@update_by			INT,
	@update_dt			DATETIME
AS

	UPDATE Users SET
		UserName = @UserName,
		Password = @Password,
		FirstName = @FirstName,
		LastName = @LastName,
		Email = @Email,
		Address1 = @Address1,
		Address2 = @Address2,
		City = @City,
		StateID = @StateID,
		Phone = @Phone,
		AIM = @AIM,
		Yahoo = @Yahoo,
		Hotmail = @Hotmail,
		Skype = @Skype,
		Gmail = @Gmail,
		UserTypeID = @UserTypeID,
		Contacts = @Contacts,
		PersonalInformation = @PersonalInformation,
		Documents = @Documents,
		Banking = @Banking,
		CreditCards = @CreditCards,
		Photos = @Photos,
		Music = @Music,
		MovieCollection = @MovieCollection,
		Movies = @Movies,
		Snippets = @Snippets,
		Health = @Health,
		Jobs = @Jobs,
		Recovery = @Recovery,
		Timesheet = @Timesheet,
		Notes = @Notes,
		tiradoonline = @tiradoonline,
		Active = @Active,
		update_by = @update_by,
		update_dt = @update_dt
	WHERE	
		UserID = @UserID


GO

