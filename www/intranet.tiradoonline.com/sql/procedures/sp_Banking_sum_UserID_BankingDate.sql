IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_sum_UserID_BankingDate' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_sum_UserID_BankingDate;
GO




CREATE PROCEDURE [dbo].[sp_Banking_sum_UserID_BankingDate]
	@BankingAccountID		INT,
	@BankingDate			SMALLDATETIME
AS

	DECLARE @firstDayoftheMonth	DATETIME;
	SET @firstDayoftheMonth = CONVERT(DATETIME, CONVERT(VARCHAR, DATEPART(month, @BankingDate)) + '/1/' + CONVERT(VARCHAR, DATEPART(year, @BankingDate)));
	DECLARE @lastDayoftheMonth	DATETIME;
	SET @lastDayoftheMonth = DATEADD(month, 1, @firstDayoftheMonth);
	SET @lastDayoftheMonth = DATEADD(day, -1, @lastDayoftheMonth);

	SELECT 
		PreviousBanking = (SELECT ISNULL(SUM(Payment), 0) FROM Banking WHERE BankingDate < @firstDayoftheMonth AND BankingAccountID = @BankingAccountID),
		TotalBanking = (SELECT ISNULL(SUM(Payment), 0) FROM Banking WHERE BankingDate <= @lastDayoftheMonth AND BankingAccountID = @BankingAccountID)



GO

