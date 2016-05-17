IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Logins_LoginDate' AND TYPE = 'P')
DROP PROCEDURE sp_Logins_LoginDate;
GO


CREATE PROCEDURE [dbo].[sp_Logins_LoginDate]
	@LoginDate		SMALLDATETIME
AS

	SELECT
		a.LoginDate, b.UserName, a.Browser, a.IPAddress 
	FROM 
		Logins a, Users b 
	WHERE 
		a.UserID = b.UserID AND 
		DATEPART(day, LoginDate) = DAY(@LoginDate) AND
		DATEPART(month, LoginDate) = MONTH(@LoginDate) AND
		DATEPART(year, LoginDate) = YEAR(@LoginDate)
	ORDER BY 
		a.LoginDate DESC


GO

