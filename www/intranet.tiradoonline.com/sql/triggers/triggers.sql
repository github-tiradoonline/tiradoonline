SELECT TOP 1 * INTO BankingMonthlyExpense_updated FROM BankingMonthlyExpense;
DELETE FROM BankingMonthlyExpense_updated;

SELECT TOP 1 * INTO BankingMonthlyExpense_deleted FROM BankingMonthlyExpense;
DELETE FROM BankingMonthlyExpense_deleted;

SELECT TOP 1 * INTO CreditCard_updated FROM CreditCard;
DELETE FROM CreditCard_updated;

SELECT TOP 1 * INTO CreditCard_deleted FROM CreditCard;
DELETE FROM CreditCard_deleted;
