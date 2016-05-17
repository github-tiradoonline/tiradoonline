IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_CreditCardSum' AND TYPE = 'P')
DROP PROCEDURE sp_CreditCardSum;
GO


CREATE PROCEDURE [dbo].[sp_CreditCardSum]
	@CurrentDate		VARCHAR(20),
	@CCID			INT
	AS
		DECLARE @Counter			INT
		DECLARE @CCBalance		NUMERIC(9,2)
		DECLARE @CCPayment		NUMERIC(9,2)

		DECLARE CreditCard_cursor CURSOR FOR 
			SELECT a.CCPayment FROM CCBalance a, CreditCard b WHERE 
			a.CCDate < CONVERT(DATETIME, @CurrentDate) AND
			a.CCID = b.CreditCardID AND b.CreditCardID = @CCID

		SELECT @Counter = 1
		OPEN CreditCard_cursor
		FETCH NEXT FROM CreditCard_cursor INTO @CCPayment

		WHILE @@FETCH_STATUS = 0
			BEGIN
				IF @Counter = 1
					BEGIN
						SELECT @CCBalance = 0 - @CCPayment
					END
				ELSE
					BEGIN
						SELECT @CCBalance = @CCBalance - @CCPayment
					END
		
				SELECT @Counter = @Counter + 1
				FETCH NEXT FROM CreditCard_cursor INTO @CCPayment
			END
	
		CLOSE CreditCard_cursor
		DEALLOCATE CreditCard_cursor

		SELECT TOTALSUM = @CCBalance, CCLIMIT = (SELECT CreditLimit FROM CreditCard WHERE CreditCardID = @CCID)





GO

