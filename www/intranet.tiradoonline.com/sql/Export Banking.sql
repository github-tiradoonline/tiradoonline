select BankingDate, BankingTransaction = (SELECT [description] FROM [TRANSACTIONS] where transactionid = banking.transactionid), Payment from banking where bankingaccountid = 1097 and bankingdate >= '12/1/15' order by bankingdate desc
