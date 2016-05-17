IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Reminders_alert' AND TYPE = 'P')
	DROP PROCEDURE sp_Reminders_alert;
GO

CREATE PROCEDURE sp_Reminders_alert
	@UserID			INT,
	@TotalDays		TINYINT
AS
	
	SELECT
		*
	FROM
		Reminders
	WHERE
		UserID = @UserID
		AND ReminderDateTime BETWEEN GETDATE() - 1 AND (GETDATE() + (@TotalDays + 1))
	ORDER BY
		ReminderDateTime;

GO


