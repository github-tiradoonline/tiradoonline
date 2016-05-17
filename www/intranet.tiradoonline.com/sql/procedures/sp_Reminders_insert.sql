IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Reminders_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Reminders_insert;
GO


CREATE PROCEDURE [dbo].[sp_Reminders_insert]
	@UserID		INT,
	@ReminderDate	SMALLDATETIME,
	@ReminderDesc	VARCHAR(255)
AS

	INSERT INTO Reminders 
		(UserID, ReminderDate, ReminderDesc)
	VALUES
		(@UserID, @ReminderDate, @ReminderDesc);


GO

