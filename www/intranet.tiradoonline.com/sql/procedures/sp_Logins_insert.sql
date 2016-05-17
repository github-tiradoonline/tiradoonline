IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Logins_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Logins_insert;
GO


CREATE PROCEDURE [dbo].[sp_Logins_insert]
	@UserID		INT,
	@Browser	VARCHAR(100),
	@IPAddress	VARCHAR(15)
AS
	INSERT INTO Logins (UserID, Browser, IPAddress) VALUES (@UserID, @Browser, @IPAddress);


GO

