IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Reminders_ALL_RemindersDate_get' AND TYPE = 'P')
	DROP PROCEDURE sp_Reminders_ALL_RemindersDate_get;
GO

CREATE PROCEDURE sp_Reminders_ALL_RemindersDate_get
	@UserID				INT,
	@RemindersDate		SMALLDATETIME
AS

	SELECT
		*
	FROM 
		Reminders
	WHERE
		UserID = @UserID
		AND DATEPART(month, ReminderDateTime) = MONTH(@RemindersDate)
		AND DATEPART(year, ReminderDateTime) = YEAR(@RemindersDate)
	ORDER BY
		ReminderDateTime



GO
EXEC sp_Reminders_ALL_RemindersDate_get 1001, '5/1/15'