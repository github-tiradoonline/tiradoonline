IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Reminders' AND TYPE = 'U')
	DROP TABLE Reminders;
GO

CREATE TABLE Reminders
(
	ReminderID		INT IDENTITY(1001, 1) NOT NULL,
	UserID			INT NOT NULL,
	ReminderDateTime	DATETIME NOT NULL,
	ReminderName		VARCHAR(200) NOT NULL,
	ReminderDescription	VARCHAR(MAX) NULL,
	create_dt		DATETIME NOT NULL DEFAULT GETDATE()
);
GO

ALTER TABLE Reminders ADD CONSTRAINT PK_Reminders_ReminderID PRIMARY KEY NONCLUSTERED (ReminderID);
GO

ALTER TABLE Reminders ADD CONSTRAINT FK_Reminders_UserID_Users_UserID FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO
