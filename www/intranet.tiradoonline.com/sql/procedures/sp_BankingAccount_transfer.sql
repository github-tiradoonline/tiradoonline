IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccount_transfer' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccount_transfer;
GO


CREATE PROCEDURE [dbo].[sp_BankingAccount_transfer]
AS
DECLARE @TransactionID	INT
DECLARE @BankingAccountID	INT

SET @BankingAccountID = 1017;
SET @TransactionID = 1004;

INSERT INTO Banking
	(BankingAccountID, TransactionID, BankingDate, Payment, Comment, update_dt)
	
select 
	BankingAccountID = @BankingAccountID,
	TransactionID,
	BankingDate,
	Payment,
	Comment,
	update_dt = GETDATE()
from 
	Banking 
where 
	Bankingaccountid = 1012 and TransactionID = @TransactionID;
	
select * from BankingAccount where userid= 1027


GO

