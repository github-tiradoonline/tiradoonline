IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccount_get' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccount_get;
GO




CREATE PROCEDURE [dbo].[sp_BankingAccount_get]
	@UserID 		INT
AS
	
	
	SELECT 
		a.BankingAccountID,
		a.BankingAccountName,
		a.ReceiveEmails,
		ActiveAccount = 1
	INTO
		#BankingAccount
	FROM
		BankingAccount a
	WHERE
		a.UserID = @UserID
		AND a.Active = 1

	SET IDENTITY_INSERT #BankingAccount ON

	INSERT INTO #BankingAccount
		(BankingAccountID, BankingAccountName, ReceiveEmails, ActiveAccount)
	SELECT
		b.BankingAccountID,
		b.BankingAccountName,
		b.ReceiveEmails,
		0
	FROM
		BankingAccountLinked a,
		BankingAccount b
	WHERE
		a.LinkedUserID = @UserID
		AND a.BankingAccountID = b.BankingAccountID;
	
	ALTER TABLE #BankingAccount ADD TotalBanking NUMERIC(9,2) NULL;	

	UPDATE
		#BankingAccount
	SET
		TotalBanking = (SELECT ISNULL(SUM(a.Payment), 0) FROM Banking a WHERE 
					BankingAccountID = #BankingAccount.BankingAccountID OR
					SubBankingAccountID = #BankingAccount.BankingAccountID);
					-- OR
					--#BankingAccount.BankingAccountID IN (SELECT BankingAccountID FROM Banking WHERE BankingAccountID = #BankingAccount.BankingAccountID) OR
					--#BankingAccount.BankingAccountID IN (SELECT BankingAccountID FROM Banking c WHERE SubBankingAccountID = a.BankingAccountID) OR

	SELECT
		* 
	FROM 
		#BankingAccount
	ORDER BY
		BankingAccountName;


	--UPDATE Banking
		--SET 




GO


exec sp_BankingAccount_get 1001
exec sp_BankingAccount_get 1002
exec sp_BankingAccount_get 1042
