IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_Transaction_Reports' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_Transaction_Reports;
GO


CREATE  PROCEDURE [dbo].[sp_Banking_Transaction_Reports]
	@BankingAccountID		INT
AS
	DECLARE @MinDate	DATETIME;
	DECLARE @TotalMonths	INT;

	SET @MinDate = (SELECT MIN(BankingDate) FROM Banking WHERE BankingAccountID = @BankingAccountID);
	SET @TotalMonths = DATEDIFF(month, @MinDate, GETDATE());
	IF @TotalMonths = 0 
		SET @TotalMonths = 1;
	
	SELECT 
		getdate(),
		b.TransactionID,
		b.Description,
		SUM(a.Payment) AS Amount,
		SUM(a.Payment) / @TotalMonths AS Monthly
	FROM 
		Banking a, 
		Transactions b 
	WHERE 
		a.BankingAccountID = @BankingAccountID AND
		a.TransactionID = b.TransactionID
	GROUP BY
		b.TransactionID,
		b.Description
	ORDER BY
		b.Description;



GO

