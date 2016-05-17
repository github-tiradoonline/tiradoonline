IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_CreditCard_get' AND TYPE = 'P')
DROP PROCEDURE sp_CreditCard_get;
GO


CREATE PROCEDURE [dbo].[sp_CreditCard_get]
	@UserID		INT
AS
	SELECT CreditCardID, CreditCardName FROM CreditCard WHERE USERID = @UserID ORDER BY CreditCardName;


GO

