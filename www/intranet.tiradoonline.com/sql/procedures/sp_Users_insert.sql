IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Users_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Users_insert;
GO


CREATE PROCEDURE [dbo].[sp_Users_insert]
	@UserName			VARCHAR(100),
	@Password			VARCHAR(100),
	@FirstName			VARCHAR(50),
	@LastName			VARCHAR(50),
	@Email				VARCHAR(100),
	@MobileEmail			VARCHAR(100),
	@UserTypeID			BIT,
	@Contacts			BIT,
	@PersonalInformation		BIT,
	@Documents			BIT,
	@Banking			BIT,
	@CreditCards			BIT,
	@MonthlyExpenses		BIT,
	@CollectionAgency		BIT,
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
	@ServerInformation		BIT,
	@tiradoonline			BIT
AS
		
	DECLARE @UserID		INT;

	BEGIN TRANSACTION

		BEGIN

			INSERT INTO Users
				(UserName, Password, FirstName, LastName, Email, MobileEmail, UserTypeID, Contacts, PersonalInformation,
				Documents, Banking, CreditCards, MonthlyExpenses, CollectionAgency, Photos, Music, MovieCollection, Movies, Snippets, Health, Jobs, [Recovery], Timesheet, Notes, ServerInformation, tiradoonline, Active)
			VALUES
				(@UserName, @Password, @FirstName, @LastName, @Email, @MobileEmail, @UserTypeID, @Contacts, @PersonalInformation,
				@Documents, @Banking, @CreditCards, @MonthlyExpenses, @CollectionAgency, @Photos, @Music, @MovieCollection, @Movies, @Snippets, @Health, @Jobs, @Recovery, @Timesheet, @Notes, @ServerInformation, @tiradoonline, 1);

			SET @UserID = @@IDENTITY;

			INSERT INTO Settings
				(UserID, AdministratorEmail)
			VALUES
				(@UserID, @Email);
			

			INSERT INTO Transactions
				(UserID, Description)
			VALUES
				(@UserID, 'Deposit');

			INSERT INTO Transactions
				(UserID, Description)
			VALUES
				(@UserID, 'Opening Banking');

			INSERT INTO Unit
				(UserID, UnitName)
			VALUES
				(@UserID, 'UNITS');

			INSERT INTO Unit
				(UserID, UnitName)
			VALUES
				(@UserID, 'MG');
			
			EXEC sp_BankingAccount_insert @UserID, 'Checking';

		END

	IF @@ERROR > 0
		ROLLBACK TRANSACTION;
	ELSE
		COMMIT TRANSACTION;





GO

