IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Reminders_get_ReminderID' AND TYPE = 'P')
DROP PROCEDURE sp_Reminders_get_ReminderID;
GO


CREATE PROCEDURE [dbo].[sp_Reminders_get_ReminderID]
	@UserID		INT,
	@ReminderDate	SMALLDATETIME
AS

	SELECT
		ReminderID
	FROM
		Reminders
	WHERE 
		UserID = @UserID AND
		ReminderDate = @ReminderDate
	ORDER BY
		ReminderDate


GO

