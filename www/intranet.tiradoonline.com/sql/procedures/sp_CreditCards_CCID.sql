IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_CreditCards_CCID' AND TYPE = 'P')
DROP PROCEDURE sp_CreditCards_CCID;
GO


CREATE PROCEDURE [dbo].[sp_CreditCards_CCID]
	@CCID		INT
AS
	SELECT CreditCardName, CreditLimit FROM CreditCard WHERE CreditCardID = @CCID


GO

