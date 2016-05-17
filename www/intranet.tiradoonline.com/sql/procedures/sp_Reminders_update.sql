IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Reminders_update' AND TYPE = 'P')
DROP PROCEDURE sp_Reminders_update;
GO


CREATE PROCEDURE [dbo].[sp_Reminders_update]
	@UserID		INT,
	@ReminderDate	SMALLDATETIME,
	@ReminderDesc	VARCHAR(255)
AS

	UPDATE Reminders
		SET ReminderDesc = @ReminderDesc
	WHERE 
		UserID = @UserID AND
		ReminderDate = @ReminderDate


GO

