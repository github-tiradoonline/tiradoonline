IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_Search_get' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_Search_get;
GO



CREATE PROCEDURE sp_Banking_Search_get
	@UserID			INT,
	@BankingAccountIDs	VARCHAR(1000),
	@TransactionIDs		VARCHAR(1000),
	@DebitCredit		VARCHAR(10),
	@StartDate		DATETIME,
	@EndDate		DATETIME,
	@Comments		VARCHAR(1000)
AS


	DECLARE @SQL		NVARCHAR(3000);
	SET @Comments = '%' + @Comments + '%';

	SET @SQL = '';
	SET @SQL = @SQL + 'SELECT ';
	SET @SQL = @SQL + '	a.create_dt, ';
	SET @SQL = @SQL + '	a.update_dt, ';
	SET @SQL = @SQL + '	b.BankingAccountName, ';
	SET @SQL = @SQL + '	a.BankingDate, ';
	SET @SQL = @SQL + '	c.Description, ';
	SET @SQL = @SQL + '	a.Payment, ';
	SET @SQL = @SQL + '	a.Comment, ';
	SET @SQL = @SQL + '	a.BankingID, ';
	SET @SQL = @SQL + '	a.BankingFile, ';
	SET @SQL = @SQL + '	a.BankingFileName, ';
	SET @SQL = @SQL + '	a.SubBankingAccountID, ';
	SET @SQL = @SQL + '	SubAccountName = b.BankingAccountName, ';
	SET @SQL = @SQL + '	a.BankingAccountID ';
	SET @SQL = @SQL + 'FROM ';
	SET @SQL = @SQL + '	Banking a, ';
	SET @SQL = @SQL + '	BankingAccount b, ';
	SET @SQL = @SQL + '	Transactions c ';
	SET @SQL = @SQL + 'WHERE ';
	SET @SQL = @SQL + '  	b.UserID = ' + CONVERT(VARCHAR, @UserID) + ' ';
	SET @SQL = @SQL + '	AND a.BankingAccountID = b.BankingAccountID ';
	SET @SQL = @SQL + '	AND a.TransactionID = c.TransactionID ';

	IF @BankingAccountIDs <> ''
		SET @SQL = @SQL + '	AND a.BankingAccountID IN (' + @BankingAccountIDs + ') ';

	IF @TransactionIDs <> ''
		SET @SQL = @SQL + '	AND c.TransactionID IN (' + @TransactionIDs + ') ';

	If @DebitCredit <> ''
		BEGIN
			If @DebitCredit = 'Debit'
				BEGIN
					SET @SQL = @SQL + '	AND a.Payment <= 0 ';
				END
			ELSE
				BEGIN
					SET @SQL = @SQL + '	AND a.Payment >= 0 ';
				END
		END

	IF @StartDate <> ''
		BEGIN
			SET @SQL = @SQL + '	AND a.BankingDate >= ''' + CONVERT(VARCHAR, @StartDate) + ''' ';
			SET @SQL = @SQL + '	AND a.BankingDate <= ''' + CONVERT(VARCHAR, @EndDate) + ''' ';
		END

	IF @Comments <> ''
		SET @SQL = @SQL + '	AND a.Comment LIKE ''' + @Comments + '''; ';

	EXEC(@SQL);

GO

