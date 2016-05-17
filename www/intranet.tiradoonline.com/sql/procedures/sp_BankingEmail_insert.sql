IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingEmail_insert' AND TYPE = 'P')
DROP PROCEDURE sp_BankingEmail_insert;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_BankingEmail_insert]
	@UserID			INT,
	@ToEmail		VARCHAR(100),
	@FromEmail		VARCHAR(100),
	@Subject		VARCHAR(100),
	@BodyText		TEXT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT 1 FROM BankingEmail WHERE UserID = @UserID)
		BEGIN

			INSERT INTO BankingEmail
				(UserID, ToEmail, FromEmail, Subject, BodyText)
			VALUES
				(@UserID, @ToEmail, @FromEmail, @Subject, @BodyText);

		END
	ELSE
		BEGIN

			UPDATE BankingEmail SET
				ToEmail = @ToEmail,
				FromEmail = @FromEmail,
				Subject = @Subject,
				BodyText = @BodyText
			WHERE
				UserID = @UserID;
		END
		
END



GO

