IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Reminders_UserID_ReminderDate' AND TYPE = 'P')
DROP PROCEDURE sp_Reminders_UserID_ReminderDate;
GO


CREATE PROCEDURE [dbo].[sp_Reminders_UserID_ReminderDate]
	@UserID		INT,
	@ReminderDate	SMALLDATETIME
AS

	SELECT 
		ReminderDate, ReminderDesc
	FROM 
		Reminders 
	WHERE 
		DATEPART(month, ReminderDate) = MONTH(@ReminderDate) AND
		DATEPART(year, ReminderDate) = YEAR(@ReminderDate) AND
		UserID = @UserID
	ORDER BY
		ReminderDate



GO

