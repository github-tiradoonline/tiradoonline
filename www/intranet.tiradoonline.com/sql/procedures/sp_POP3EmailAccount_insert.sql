IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_POP3EmailAccount_insert' AND TYPE = 'P')
	DROP PROCEDURE sp_POP3EmailAccount_insert;
GO

CREATE PROCEDURE sp_POP3EmailAccount_insert
	@UserID				INT,
	@POP3EmailAccountName		VARCHAR(50),
	@POP3EmailAccountServer		VARCHAR(100),
	@POP3EmailAccountEmail		VARCHAR(100),
	@POP3EmailAccountUserName	VARCHAR(100),
	@POP3EmailAccountPassword	VARCHAR(100),
	@POP3EmailAccountSSL		VARCHAR(100)

AS

	IF NOT EXISTS (SELECT 1 FROM POP3EmailAccount WHERE UserID = @UserID AND POP3EmailAccountName = @POP3EmailAccountName)
		BEGIN

			INSERT INTO POP3EmailAccount
				(UserID, POP3EmailAccountName, POP3EmailAccountServer, POP3EmailAccountEmail, POP3EmailAccountUserName, POP3EmailAccountPassword, POP3EmailAccountSSL)			
			VALUES
				(@UserID, @POP3EmailAccountName, @POP3EmailAccountServer, @POP3EmailAccountEmail, @POP3EmailAccountUserName, @POP3EmailAccountPassword, @POP3EmailAccountSSL)

			DECLARE @POP3EmailAccountID		INT;
			SET @POP3EmailAccountID = @@IDENTITY;

			IF NOT EXISTS (SELECT 1 FROM POP3EmailFolder WHERE POP3EmailAccountID = @POP3EmailAccountID AND POP3EmailFolderName = 'Inbox')
				BEGIN
					INSERT INTO POP3EmailFolder
						(POP3EmailAccountID, POP3EmailFolderName)
					VALUES
						(@POP3EmailAccountID, 'Inbox');
				END

			IF NOT EXISTS (SELECT 1 FROM POP3EmailFolder WHERE POP3EmailAccountID = @POP3EmailAccountID AND POP3EmailFolderName = 'Sent Mail')
				BEGIN
					INSERT INTO POP3EmailFolder
						(POP3EmailAccountID, POP3EmailFolderName)
					VALUES
						(@POP3EmailAccountID, 'Sent Mail');
				END
		END
	


GO

--EXEC sp_POP3EmailAccount_insert 1001