

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Accounts_AccountID_get]
	@Accountid				INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT * FROM Accounts WHERE Accountid = @Accountid;

END





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Accounts_get]
	@UserID				INT,
	@Letter				VARCHAR(3) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 IF @Letter IS NOT NULL
		SET @Letter = @Letter + '%';

	 IF @Letter IS NOT NULL
		BEGIN
		 IF @Letter = 'ALL'
			SELECT * FROM Accounts WHERE UserID = @UserID AND Active = 1 ORDER BY AccountName;
		 ELSE
			SELECT * FROM Accounts WHERE UserID = @UserID AND LEFT(AccountName, 1) LIKE @Letter AND Active = 1 ORDER BY AccountName;
		END
	ELSE
		SELECT * FROM Accounts WHERE UserID = @UserID  AND Active = 1 ORDER BY AccountName;

END



CREATE PROCEDURE [dbo].[sp_administration_backup]
	@UserID	INT
AS
	BEGIN
		BACKUP DATABASE teddy TO teddy_dmp;
		BACKUP LOG teddy TO teddy_dmp;
		INSERT INTO Backups (UserID) VALUES (@UserID);
	END




CREATE PROCEDURE [dbo].[sp_administration_bcp_out]
AS

	DECLARE @dbname 		VARCHAR(30);
	DECLARE @FilePath		VARCHAR(200);
	DECLARE @FileName		VARCHAR(200);
	DECLARE @tablename 		VARCHAR(30);
	DECLARE @tableowner 		VARCHAR(30);
	DECLARE @sql_string 		VARCHAR(200);

	SET @dbname = 'teddy';
	SET @FilePath = 'D:\www\teddy\data\backup\' + CONVERT(VARCHAR, DATEPART(month, GETDATE())) + '_' + CONVERT(VARCHAR, DATEPART(day, GETDATE())) + '_' + CONVERT(VARCHAR, DATEPART(year, GETDATE())) + '_' + CONVERT(VARCHAR, DATEPART(hour, GETDATE())) + '_' + CONVERT(VARCHAR, DATEPART(minute, GETDATE())) + '_' + CONVERT(VARCHAR, DATEPART(second, GETDATE())) + '_' + RIGHT(CONVERT(VARCHAR, GETDATE()), 2);
	SET @sql_string = 'MKDIR ' + @FilePath;
	PRINT @sql_string;
	EXEC master..xp_cmdshell @sql_string

	PRINT 'SELECT NAME, USER_NAME(UID) AS TABLEOWNER FROM SYSOBJECTS WHERE TYPE = ''U'' AND LEFT(NAME, 2) <> ''dt'' ORDER BY NAME';
	DECLARE cNames 	CURSOR FOR SELECT NAME, USER_NAME(UID) AS TABLEOWNER FROM teddy..SYSOBJECTS WHERE TYPE = 'U' AND LEFT(NAME, 2) <> 'dt' ORDER BY NAME;

	OPEN cNames
	FETCH NEXT FROM cNames INTO @tablename, @tableowner
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @sql_string = '"C:\Program Files\Microsoft SQL Server\80\Tools\Binn\bcp" ' + @dbname + '.' + @tableowner + '.' + @tablename + ' out ' + @FilePath + '\' + @tablename + '.txt -c -Usa -Psixpak';
		PRINT @sql_string;
		EXEC master..xp_cmdshell @sql_string
		FETCH NEXT FROM cNames INTO @tablename, @tableowner
	END
	CLOSE cNames
	DEALLOCATE cNames



CREATE PROCEDURE [dbo].[sp_administration_DecryptString]
	@teststring VARCHAR(255) OUTPUT
AS
	DECLARE @x tinyint
	DECLARE @DecryptedString VARCHAR(20)
	SET @DecryptedString = ""

	SET @x = 1

	WHILE @x <= LEN(@teststring)
		BEGIN

			SET @DecryptedString = @DecryptedString + CHAR(ASCII(SUBSTRING(@teststring, @x, 1)) - 11)
			SET @x = @x + 1
			CONTINUE
		END
	
	SELECT @DecryptedString


CREATE PROCEDURE [dbo].[sp_administration_EncryptString]
	@teststring VARCHAR(255) OUTPUT
AS
	DECLARE @x tinyint
	DECLARE @EncryptedString VARCHAR(20)
	SET @EncryptedString = ''

	SET @x = 1

	WHILE @x <= LEN(@teststring)
		BEGIN

			SET @EncryptedString = @EncryptedString + CHAR(ASCII(SUBSTRING(@teststring, @x, 1)) + 11)
			SET @x = @x + 1
			CONTINUE
		END
	
	SELECT EncryptedString = @EncryptedString



CREATE PROCEDURE [dbo].[sp_administration_execute]
	@UserID		INT,
	@SQL		VARCHAR(2000)
AS
	EXEC(@SQL);
	EXEC sp_SQLScripts_insert @UserID, @SQL;



CREATE PROCEDURE [dbo].[sp_administration_reindex]
AS
	DECLARE @SQL 		VARCHAR(1000)
	DECLARE @TABLE_NAME 	VARCHAR(20)

	DECLARE TABLES_CURSOR CURSOR FOR 
		SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME <> 'dtproperties' ORDER BY NAME

	OPEN TABLES_CURSOR
	FETCH NEXT FROM TABLES_CURSOR INTO @TABLE_NAME

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @SQL = 'DBCC DBREINDEX (''' + @TABLE_NAME + ''');'
			PRINT @SQL
			EXEC(@SQL)
			FETCH NEXT FROM TABLES_CURSOR INTO @TABLE_NAME
		END

	CLOSE TABLES_CURSOR
	DEALLOCATE TABLES_CURSOR




CREATE PROCEDURE [dbo].[sp_administration_schema_objectid]
	@ObjectID	INT
AS
	DECLARE @SQL		VARCHAR(100)

	SET @SQL = 'sp_helptext ' + OBJECT_NAME(@ObjectID)
	--PRINT @SQL
	EXEC(@SQL)


CREATE PROCEDURE [dbo].[sp_administration_schema_type]
	@OBJECTTYPE	VARCHAR(2)
AS

	SELECT 
		ID AS OBJECTID,
		NAME AS OBJECTNAME
	FROM 
		SYSOBJECTS
	WHERE 
		LEFT(NAME, 2) <> 'DT' AND 
		LEFT(NAME, 2) <> 'SYS' AND 
		TYPE = @OBJECTTYPE
		--  AND USER_NAME(UID) = 'TEDDY_USER'
	ORDER BY 
		NAME



CREATE PROCEDURE [dbo].[sp_administration_totalrows]
AS
	DECLARE @SQL		NVARCHAR(1000);
	DECLARE @ObjectID	VARCHAR(50);
	DECLARE @ObjectName	VARCHAR(50);
	DECLARE @TableOwner	VARCHAR(50);
	DECLARE @TableRows	INT;

	IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TableRows')
		BEGIN
			SET @SQL = 'DROP TABLE TableRows';
			EXEC sp_executesql @SQL;
		END
	

		CREATE TABLE TableRows
		(
			ObjectID	VARCHAR(50) NOT NULL,
			ObjectName	VARCHAR(50) NOT NULL,
			TableOwner	VARCHAR(50) NOT NULL,
			TableRows	INT NOT NULL,
			create_dt	DATETIME DEFAULT GETDATE() NOT NULL
		);

	DECLARE Table_cursor CURSOR FOR 
		SELECT ObjectID = ID, ObjectName = NAME, TableOwner = USER_NAME(UID) FROM SYSOBJECTS WHERE TYPE = 'U' AND LEFT(NAME, 2) <> 'dt' AND NAME <> 'TableRows' ORDER BY NAME

	OPEN Table_cursor
	FETCH NEXT FROM Table_cursor INTO @ObjectID, @ObjectName, @TableOwner
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @SQL = 'INSERT INTO TableRows (ObjectID, ObjectName, TableOwner, TableRows) SELECT ObjectID = ' + @ObjectID + ', ObjectName = ''' + @ObjectName + ''', TableOwner = ''' + @TableOwner + ''', TableRows = (SELECT COUNT(*) FROM ' + @TableOwner + '.' + @ObjectName + ')'
			PRINT @SQL
			EXEC sp_executesql @SQL
			FETCH NEXT FROM Table_cursor INTO @ObjectID, @ObjectName, @TableOwner
		END

	CLOSE Table_cursor
	DEALLOCATE Table_cursor

	/*
	SELECT 
		ObjectID,
		TableName = CASE 
                               WHEN 
                                   TableOwner <> USER THEN ObjectName + '(' + TableOwner + ')'
                               ELSE
                                   ObjectName
                           END,
		TableRows
	FROM 
		TableRows 
	ORDER BY 
		ObjectName, 
		TableOwner;
	*/



CREATE PROCEDURE [dbo].[sp_Backups_BackupDate]
	@BackupDate		SMALLDATETIME
AS

	SELECT
		a.BackupDate, b.UserName
	FROM
		Backups a, Users b
	WHERE 
		a.UserID = b.UserID AND
		DATEPART(day, a.BackupDate) = DAY(@BackupDate) AND
		DATEPART(month, a.BackupDate) = MONTH(@BackupDate) AND
		DATEPART(year, a.BackupDate) = YEAR(@BackupDate)
	ORDER BY 
		a.BackupDate DESC


CREATE PROCEDURE [dbo].[sp_Backups_get]
	@UserID			INT
AS
	DECLARE @MediaSetID	INT;
	SET @MediaSetID = (SELECT MAX(media_set_id) FROM MSDB..backupmediafamily WHERE logical_device_name = 'teddy_dmp');
	--PRINT @MediaSetID;

	SELECT 
		c.backup_finish_date AS BackupDate
	FROM
		MSDB..backupmediaset b,
		MSDB..backupset c
	WHERE 
		b.media_set_id = @MediaSetID AND
		b.media_set_id = c.media_set_id and
		c.user_name = user_name(@UserID)
	GROUP BY
		c.media_set_id, c.backup_finish_date 
	ORDER BY
		c.backup_finish_date DESC








CREATE PROCEDURE [dbo].[sp_Balance_BalanceID]
	@BalanceID		INT
AS

	SELECT
		BalanceDate, 
		BalanceAccountID,
		SubBalanceAccountID,
		TransactionID, 
		Payment, 
		Comment,
		BankingFile,
		BankingFileName
	FROM 
		Balance 
	WHERE 
		BalanceID = @BalanceID



CREATE PROCEDURE [dbo].[sp_BalanceAccount_insert]
	@UserID 		INT,
	@BalanceAccountName	VARCHAR(20)
AS

	IF NOT EXISTS (SELECT BalanceAccountID FROM BalanceAccounts WHERE UserID = @UserID AND BalanceAccountName = @BalanceAccountName)
		BEGIN
			INSERT INTO BalanceAccounts 
				(UserID, BalanceAccountName) 
			VALUES 
				(@UserID, @BalanceAccountName);
		END

	SELECT @@IDENTITY AS BalanceAccountID, @UserID AS UserID;





CREATE PROCEDURE [dbo].[sp_Banking_BankingAccountID_BankingDate_get]
	@BankingAccountID		INT,
	@BankingDate			SMALLDATETIME
AS

	SELECT
		a.BankingID,
		BankingAccountID = @BankingAccountID,
		a.SubBankingAccountID,	
		BankingAccountName = (SELECT BankingAccountName FROM BankingAccount WHERE BankingAccountID = @BankingAccountID),
		SubAccountName = CASE 
					WHEN SubBankingAccountID IS NOT NULL THEN
						(SELECT BankingAccountName FROM BankingAccount WHERE BankingAccountID = a.SubBankingAccountID)
					ELSE
						NULL
				END,
		a.BankingDate,
		a.Payment,
		a.Comment,
		b.Description,
		a.BankingFile,
		a.BankingFileName
	FROM 
		Banking a, 
		Transactions b
	WHERE
		DATEPART(month, a.BankingDate) = MONTH(@BankingDate) AND 
		DATEPART(year, a.BankingDate) = YEAR(@BankingDate) AND 
		a.TransactionID = b.TransactionID AND
		(a.BankingAccountID = @BankingAccountID OR
		a.SubBankingAccountID = @BankingAccountID)
	ORDER BY
		a.BankingDate,
		a.create_dt;



CREATE PROCEDURE [dbo].[sp_Banking_BankingAccountID_TransactionID_get]
	@BankingAccountID		INT,
	@TransactionID			INT
AS

	SELECT
		a.BankingID, 
		a.BankingDate, 
		a.Payment, 
		a.Comment, 
		b.Description
	FROM 
		Banking a, 
		Transactions b
	WHERE
		b.TransactionID = @TransactionID AND
		a.TransactionID = b.TransactionID AND
		a.BankingAccountID = @BankingAccountID
	ORDER BY
		a.BankingDate;




CREATE PROCEDURE [dbo].[sp_Banking_BankingID]
	@BankingID		INT
AS

	SELECT
		BankingDate, 
		BankingAccountID,
		SubBankingAccountID,
		TransactionID, 
		Payment, 
		Comment,
		BankingFile,
		BankingFileName
	FROM 
		Banking 
	WHERE 
		BankingID = @BankingID





CREATE PROCEDURE [dbo].[sp_Banking_delete]
	@BankingID			INT
AS
	
	DELETE FROM Banking WHERE BankingID = @BankingiD;




CREATE PROCEDURE [dbo].[sp_Banking_get_sum]
	@UserID 	INT
AS
	DECLARE @TotalBanking	INT
	DECLARE @TotalGross	INT
        DECLARE @TotalNet       INT

	SET @TotalBanking = (SELECT ISNULL(SUM(b.Payment), 0) TotalBanking FROM BankingAccount a, Banking b WHERE a.UserID = @UserID AND a.BankingAccountID = b.BankingAccountID)
	
	SET @TotalNet = (SELECT SUM(a.Gross) - SUM(a.Federal + a.SocialSecurity + a.Medicare + a.NY_Withholding + a.NY_Disability + a.NY_City) FROM Paychecks a, Companies b WHERE a.TimesheetCompanyID = b.CompanyID AND DATEPART(year, a.PaymentDate) = DATEPART(year, getdate()) AND b.UserID = @UserID)

	SELECT 
             @TotalBanking TotalBanking, 
             @TotalGross TotalGross,
             @TotalNet TotalNet





CREATE PROCEDURE [dbo].[sp_Banking_insert]
	@UserID				INT,
	@BankingAccountID		INT, 
	@SubBankingAccountID		INT, 
	@BankingDate			SMALLDATETIME, 
	@TransactionID			INT OUTPUT, 
	@TransactionText		VARCHAR(100), 
	@Comment			VARCHAR(255), 
	@Payment			NUMERIC(8,2),
	@BankingFile			BIT,
	@BankingFileName		VARCHAR(200)
AS
	
	IF @TransactionID IS NULL AND @TransactionText <> ''
		BEGIN
			EXEC sp_Transactions_insert @TransactionID OUTPUT, @UserID, @TransactionText;
		END
	
	INSERT INTO Banking
		(BankingAccountID, SubBankingAccountID, BankingDate, TransactionID, Comment, Payment, BankingFile, BankingFileName, update_dt) 
	VALUES 
		(@BankingAccountID, @SubBankingAccountID, @BankingDate, @TransactionID, @Comment, @Payment, @BankingFile, @BankingFileName, GETDATE());

	SELECT @@IDENTITY;




CREATE PROCEDURE sp_Banking_Last_Created_Transactions_UserID_get
	@UserID			INT
AS


	SELECT TOP 300
		a.create_dt,
		a.update_dt,
		b.BankingAccountName, 
		a.BankingDate, 
		c.Description, 
		a.Payment, 
		a.Comment, 
		a.BankingID, 
		a.BankingFile, 
		a.BankingFileName, 
		a.SubBankingAccountID, 
		SubAccountName = b.BankingAccountName, 
		a.BankingAccountID 
	FROM 
		Banking a, 
		BankingAccount b, 
		Transactions c 
	WHERE 
	  	b.UserID = @UserID 
		AND a.BankingAccountID = b.BankingAccountID 
		AND a.TransactionID = c.TransactionID 
	ORDER BY
		a.create_dt DESC



CREATE PROCEDURE sp_Banking_Last_Updated_Transactions_UserID_get
	@UserID			INT
AS


	SELECT TOP 300
		a.create_dt,
		a.update_dt,
		b.BankingAccountName, 
		a.BankingDate, 
		c.Description, 
		a.Payment, 
		a.Comment, 
		a.BankingID, 
		a.BankingFile, 
		a.BankingFileName, 
		a.SubBankingAccountID, 
		SubAccountName = b.BankingAccountName, 
		a.BankingAccountID 
	FROM 
		Banking a, 
		BankingAccount b, 
		Transactions c 
	WHERE 
	  	b.UserID = @UserID 
		AND CONVERT(SMALLDATETIME, a.create_dt) <> CONVERT(SMALLDATETIME, a.update_dt)
		AND a.BankingAccountID = b.BankingAccountID 
		AND a.TransactionID = c.TransactionID 
	ORDER BY
		a.update_dt DESC



CREATE PROCEDURE sp_Banking_Search_get
	@UserID			INT,
	@BankingAccountIDs	VARCHAR(1000),
	@TransactionIDs		VARCHAR(1000),
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

	IF @StartDate <> ''
		BEGIN
			SET @SQL = @SQL + '	AND a.BankingDate >= ''' + CONVERT(VARCHAR, @StartDate) + ''' ';
			SET @SQL = @SQL + '	AND a.BankingDate <= ''' + CONVERT(VARCHAR, @EndDate) + ''' ';
		END

	IF @Comments <> ''
		SET @SQL = @SQL + '	AND a.Comment LIKE ''' + @Comments + '''; ';

	EXEC(@SQL);



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





CREATE PROCEDURE [dbo].[sp_Banking_update]
	@UserID				INT,
	@BankingID			INT,
	@BankingDate			SMALLDATETIME, 
	@TransactionID			INT OUTPUT, 
	@TransactionText		VARCHAR(100), 
	@Comment			VARCHAR(255), 
	@Payment			NUMERIC(8,2),
	@BankingFile			BIT,
	@BankingFileName		VARCHAR(200)
AS
	
	IF @TransactionID IS NULL AND @TransactionText <> ''
		BEGIN
			EXEC sp_Transactions_insert @TransactionID OUTPUT, @UserID, @TransactionText;
		END
	

	UPDATE Banking SET
		BankingDate = @BankingDate, 
		TransactionID = @TransactionID, 
		Comment = @Comment, 
		Payment = @Payment, 
		BankingFile = @BankingFile, 
		BankingFileName = @BankingFileName, 
		update_dt = GETDATE()
	WHERE 
		BankingID = @BankingID;





CREATE PROCEDURE [dbo].[sp_Banking_UserID_BankingDate_email]
	@BankingAccountID		INT,
	@BankingDate			SMALLDATETIME
AS

	SELECT TOP 20
		a.BankingID, 
		a.BankingDate, 
		a.Payment, 
		a.Comment, 
		b.Description
	FROM 
		Banking a, Transactions b
	WHERE
		--DATEPART(month, a.BankingDate) = MONTH(@BankingDate) AND 
		--DATEPART(year, a.BankingDate) = YEAR(@BankingDate) AND 
		a.TransactionID = b.TransactionID AND
		a.BankingAccountID = @BankingAccountID
	ORDER BY
		a.BankingDate DESC


CREATE PROCEDURE [dbo].[sp_BankingAccount_active_get]
	@UserID			INT,
	@Active			BIT,
	@Administrator		BIT
AS

	IF @Administrator = 0
		BEGIN
	
			SELECT
				a.BankingAccountID,
				FullName = (SELECT FirstName + ' ' + LastName + ' (' + UserName + ')' FROM Users WHERE UserID = a.UserID),
				a.BankingAccountName,
				Balance = (SELECT ISNULL(SUM(Payment), 0) FROM Banking WHERE BankingAccountID = a.BankingAccountID),
				a.ReceiveEmails,
				a.UserID
			FROM
				BankingAccount a
			WHERE
				a.UserID = @UserID AND
				a.Active = @Active
			ORDER BY
				a.BankingAccountName;
		END

	ELSE

		BEGIN
	
			SELECT
				a.BankingAccountID,
				FullName = (SELECT FirstName + ' ' + LastName + ' (' + UserName + ')' FROM Users WHERE UserID = a.UserID),
				a.BankingAccountName,
				Balance = (SELECT ISNULL(SUM(Payment), 0) FROM Banking WHERE BankingAccountID = a.BankingAccountID),
				a.ReceiveEmails,
				a.UserID
			FROM
				BankingAccount a
			WHERE
				a.Active = @Active
			ORDER BY
				a.BankingAccountName;
		END



CREATE PROCEDURE [dbo].[sp_BankingAccount_BankingAccountID_get]
	@BankingAccountID	INT

AS

	SELECT
		TotalBanking = (SELECT SUM(Payment) FROM Banking WHERE BankingAccountID = @BankingAccountID),
		*
	FROM
		BankingAccount
	WHERE
		BankingAccountID = @BankingAccountID;



CREATE PROCEDURE [dbo].[sp_BankingAccount_delete] 
	@BankingAccountID	INT
AS

	/*
	BEGIN TRANSACTION DeleteBankingAccount

	DECLARE @BankingAccountName		VARCHAR(50);

	DELETE FROM Banking WHERE BankingAccountID = @BankingAccountID;
	DELETE FROM BankingAccount WHERE BankingAccountID = @BankingAccountID;

	IF @@ERROR = 0
		COMMIT TRANSACTION DeleteBankingAccount;
	ELSE
		ROLLBACK TRANSACTION DeleteBankingAccount;

	SELECT @BankingAccountName;
	*/
	UPDATE BankingAccount SET Active = 0  WHERE BankingAccountID = @BankingAccountID;
	SELECT BankingAccountName FROM BankingAccount WHERE BankingAccountID = @BankingAccountID;




CREATE PROCEDURE [dbo].[sp_BankingAccount_get]
	@UserID 		INT
AS
	
	
	SELECT 
		BankingAccountID,
		BankingAccountName,
		ReceiveEmails
	INTO
		#BankingAccount
	FROM
		BankingAccount
	WHERE
		UserID = @UserID AND
		Active = 1
	ORDER BY
		BankingAccountName;
	
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
		#BankingAccount;
	--UPDATE Banking
		--SET 




CREATE PROCEDURE [dbo].[sp_BankingAccount_insert]
	@UserID 		INT,
	@BankingAccountName	VARCHAR(20)
AS

	IF NOT EXISTS (SELECT BankingAccountID FROM BankingAccount WHERE UserID = @UserID AND BankingAccountName = @BankingAccountName)
		BEGIN
			INSERT INTO BankingAccount 
				(UserID, BankingAccountName) 
			VALUES 
				(@UserID, @BankingAccountName);
		END

	SELECT @@IDENTITY AS BankingAccountID, @UserID AS UserID;



CREATE PROCEDURE [dbo].[sp_BankingAccount_ReceiveEmail_get]
	@UserID		INT = NULL
AS

	IF @UserID IS NULL 
		BEGIN
			SELECT
				a.BankingAccountID,
				FullName = (SELECT FirstName + ' ' + LastName + ' (' + UserName + ')' FROM Users WHERE UserID = a.UserID),
				Email = (SELECT Email FROM Users WHERE UserID = a.UserID),
				a.BankingAccountName,
				Balance = (SELECT ISNULL(SUM(Payment), 0) FROM Banking WHERE BankingAccountID = a.BankingAccountID),
				a.ReceiveEmails,
				a.UserID
			FROM
				BankingAccount a
			WHERE
				a.ReceiveEmails = 1
				AND a.Active = 1
			ORDER BY
				a.BankingAccountName;
		END
	ELSE
		BEGIN
			SELECT
				a.BankingAccountID,
				FullName = (SELECT FirstName + ' ' + LastName + ' (' + UserName + ')' FROM Users WHERE UserID = a.UserID),
				Email = (SELECT Email FROM Users WHERE UserID = a.UserID),
				a.BankingAccountName,
				Balance = (SELECT ISNULL(SUM(Payment), 0) FROM Banking WHERE BankingAccountID = a.BankingAccountID),
				a.ReceiveEmails,
				a.UserID
			FROM
				BankingAccount a
			WHERE
				a.UserID = @UserID
				AND a.ReceiveEmails = 1
				AND a.Active = 1
			ORDER BY
				a.BankingAccountName;
		END
		


CREATE PROCEDURE [dbo].[sp_BankingAccount_SubAccounts_get]
	@BankingAccountID		INT
AS

	--SET @BankingAccountID = 1049;

	SELECT 
		DISTINCT a.BankingAccountName,
		SubBankingTotal = SUM(Payment)
	FROM 
		BankingAccount a, 
		Banking b 
	WHERE 
		a.BankingAccountID = b.SubBankingAccountID AND 
		(b.BankingAccountID = @BankingAccountID OR
		b.SubBankingAccountID = @BankingAccountID)
		/*
b.SubBankingAccountID IN 
			(SELECT 
					c.SubBankingAccountID 
			FROM 
				Banking c
			WHERE 
				c.BankingAccountID = @BankingAccountID)
		*/
			GROUP BY a.BankingAccountName
	ORDER BY
		a.BankingAccountName


CREATE PROCEDURE [dbo].[sp_BankingAccount_SubBankingAccountID_get]
	@UserID				INT,
	@BankingAccountID		INT
AS

	SELECT
		BankingAccountID,
		BankingAccountName
	FROM 
		BankingAccount
	WHERE
		UserID = @UserID AND
		BankingAccountID <> @BankingAccountID AND
		Active = 1
	ORDER BY
		BankingAccountName;


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


CREATE PROCEDURE [dbo].[sp_BankingAccount_update]
	@BankingAccountID	INT,
	@BankingAccountName	VARCHAR(50)
AS

	UPDATE BankingAccount SET
		BankingAccountName = @BankingAccountName
	WHERE
		BankingAccountID = @BankingAccountID




CREATE PROCEDURE [dbo].[sp_BankingAccountLinked_delete]
        @BankingAccountLinkedID              	INT
AS

	DELETE FROM BankingAccountLinked WHERE @BankingAccountLinkedID = BankingAccountLinkedID;




CREATE PROCEDURE [dbo].[sp_BankingAccountLinked_get]
         @BankingAccountID              INT
AS

	SELECT
		BankingAccountLinkedID,
		Email
	FROM
		BankingAccountLinked
	WHERE
		BankingAccountID = @BankingAccountID		
	ORDER BY
		Email



CREATE PROCEDURE [dbo].[sp_BankingAccountLinked_insert]
        @BankingAccountID              	INT,
	@Email				VARCHAR(50)
AS

	INSERT INTO BankingAccountLinked
		(BankingAccountID, Email)
	VALUES
		(@BankingAccountID, @Email)




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_BankingEmail_insert]
	@UserID			INT,
	@ToEmail		VARCHAR(100),
	@FromEmail		VARCHAR(100),
	@Subject		VARCHAR(100),
	@BodyText		TEXT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT 1 FROM BankingEmail WHERE UserID = @UserID)
		BEGIN

			INSERT INTO BankingEmail
				(UserID, ToEmail, FromEmail, Subject, BodyText)
			VALUES
				(@UserID, @ToEmail, @FromEmail, @Subject, @BodyText);

		END
	ELSE
		BEGIN

			UPDATE BankingEmail SET
				ToEmail = @ToEmail,
				FromEmail = @FromEmail,
				Subject = @Subject,
				BodyText = @BodyText
			WHERE
				UserID = @UserID;
		END
		
END




CREATE PROCEDURE [dbo].[sp_BloodPressure_insert]
	@UserID			INT = NULL,
	@BloodPressureDateTime	DATETIME,
	@BloodPressureTop		SMALLINT, 
	@BloodPressureBottom		SMALLINT, 
	@BloodPressureComments	VARCHAR(2000)
AS
	
	INSERT INTO BloodPressure
		(UserID, BloodPressureDateTime, BloodPressureTop, BloodPressureBottom, BloodPressureComments)
	VALUES
		(@UserID, @BloodPressureDateTime, @BloodPressureTop, @BloodPressureBottom, @BloodPressureComments)

	SELECT @@IDENTITY;



CREATE PROCEDURE [dbo].[sp_BloodPressure_update]
	@BloodPressureID			INT,
	@BloodPressureDateTime	DATETIME,
	@BloodPressureTop		SMALLINT, 
	@BloodPressureBottom		SMALLINT, 
	@BloodPressureComments	VARCHAR(2000)
AS
	
	UPDATE BloodPressure SET
		BloodPressureDateTime = @BloodPressureDateTime, 
		BloodPressureTop = @BloodPressureTop,
		BloodPressureBottom = @BloodPressureBottom,
		BloodPressureComments = @BloodPressureComments
	WHERE
		BloodPressureID = @BloodPressureID;


CREATE PROCEDURE [dbo].[sp_Companies_CompanyID_CompanyName]
	@UserID		INT
AS
	SELECT CompanyID, CompanyName FROM Companies WHERE UserID = @UserID ORDER BY CompanyName


CREATE PROCEDURE [dbo].[sp_Companies_Count]
	@UserID		INT
AS
	SELECT COUNT(*) AS TOTAL FROM Companies WHERE UserID = @UserID




CREATE PROCEDURE [dbo].[sp_Companies_get]
	@UserID		INT
AS

	SELECT 
		CompanyID, 
		CompanyName 
	FROM 
		Companies 
	WHERE 
		UserID = @UserID 




CREATE PROCEDURE [dbo].[sp_Companies_get_CompanyID]
	@CompanyID	INT
AS
	SELECT 
		CompanyID, 
		CompanyName,
		StartDate,
		EndDate
	FROM 
		Companies 
	WHERE 
		CompanyID = @CompanyID



CREATE PROCEDURE [dbo].[sp_Companies_UserID]
	@UserID		INT
AS
	SELECT 
        	CompanyID,
                CompanyName
	FROM
		Companies 
	WHERE 
		UserID = @UserID



CREATE PROCEDURE [dbo].[sp_Contacts_0_get]
        @UserID int

AS 

	SELECT 
		HomeStateName = (SELECT State FROM States where StateID = Contacts.HomeAddressState),
		BusinessStateName = (SELECT State FROM States where StateID = Contacts.BusinessAddressState),
		* 
	FROM
		Contacts
	WHERE
		UserID = @UserID AND
		EntryID = '0' AND
		Active = 1;



CREATE PROCEDURE [dbo].[sp_Contacts_Active_0_get]
	@UserID		INT
AS

	SELECT 
		* 
	FROM 
		Contacts
	WHERE		
		UserID = @UserID AND
		Active = 0 AND
		EntryID <> '0';





CREATE PROCEDURE [dbo].[sp_Contacts_delete]
	@ContactID		INT
AS

	UPDATE Contacts SET 
		Active = 0
	WHERE
		ContactID = @ContactID;




CREATE PROCEDURE [dbo].[sp_Contacts_EntryID_0_delete]
	@UserID		INT
AS

	DELETE FROM 
		Contacts 
	WHERE 
		EntryID = '0' AND 
		Active = 1 AND 
		UserID = @UserID;






CREATE PROCEDURE [dbo].[sp_Contacts_get]
	@UserID		INT,
	@Letter		VARCHAR(10) = null
AS 
	IF @Letter <> ''
		BEGIN
			SET @Letter = @Letter + '%';

			SELECT
				*,
				HomeState = (SELECT State FROM States WHERE StateID = Contacts.HomeAddressState),
				BusinessState = (SELECT State FROM States WHERE StateID = Contacts.BusinessAddressState)
			FROM 
				Contacts
			WHERE
				UserID = @UserID AND
				FileAs LIKE @Letter AND
				Active = 1
			ORDER BY
				FileAs;
		END
	ELSE
		BEGIN
			SELECT
				*,
				HomeState = HomeAddressState,
				BusinessState = BusinessAddressState
			FROM 
				Contacts
			WHERE
				UserID = @UserID AND
				Active = 1
			ORDER BY
				FileAs;

		END




CREATE PROCEDURE [dbo].[sp_Contacts_insert]
        @EntryID varchar(50),
        @UserID int,
	@FileAs varchar(100),
        @FirstName varchar(20),
        @LastName varchar(20),
        @FullName varchar(50),
        @CompanyName varchar(100),
        @JobTitle varchar(50),
        @Email1Address varchar(100),
        @Email2Address varchar(100),
        @Email3Address varchar(100),
        @WebPage varchar(100),
        @IMAddress varchar(20),
        @MobileTelephoneNumber varchar(50),
        @HomeTelephoneNumber varchar(50),
        @BusinessTelephoneNumber varchar(50),
        @BusinessFaxNumber varchar(50),
        @HomeAddressStreet varchar(50),
        @HomeAddressCity varchar(50),
        @HomeAddressState varchar(50),
        @HomeAddressPostalCode varchar(50),
        @BusinessAddressStreet varchar(50),
        @BusinessAddressCity varchar(50),
        @BusinessAddressState varchar(50),
        @BusinessAddressPostalCode varchar(50),
	@HasPicture BIT,
	@LastModificationTime DATETIME

AS 

IF NOT EXISTS (SELECT 1 FROM Contacts WHERE EntryID = @EntryID AND Active = 1)
	BEGIN
		INSERT INTO Contacts
		(
			EntryID,
	                UserID,
			FileAs,
	                FirstName,
	                LastName,
	                FullName,
	                CompanyName,
	                JobTitle,
	                Email1Address,
	                Email2Address,
	                Email3Address,
	                WebPage,
	                IMAddress,
	                MobileTelephoneNumber,
	                HomeTelephoneNumber,
	                BusinessTelephoneNumber,
	                BusinessFaxNumber,
	                HomeAddressStreet,
	                HomeAddressCity,
	                HomeAddressState,
	                HomeAddressPostalCode,
	                BusinessAddressStreet,
	                BusinessAddressCity,
	                BusinessAddressState,
	                BusinessAddressPostalCode,
			HasPicture,
	                LastModificationTime,
			create_dt
		)
		VALUES
		(
			@EntryID,
	                @UserID,
			@FileAs,
	                @FirstName,
	                @LastName,
	                @FullName,
	                @CompanyName,
	                @JobTitle,
	                @Email1Address,
	                @Email2Address,
	                @Email3Address,
	                @WebPage,
	                @IMAddress,
	                dbo.fn_FormatPhoneNumber(@MobileTelephoneNumber),
	                dbo.fn_FormatPhoneNumber(@HomeTelephoneNumber),
	                dbo.fn_FormatPhoneNumber(@BusinessTelephoneNumber),
	                dbo.fn_FormatPhoneNumber(@BusinessFaxNumber),
	                @HomeAddressStreet,
	                @HomeAddressCity,
	                @HomeAddressState,
	                @HomeAddressPostalCode,
	                @BusinessAddressStreet,
	                @BusinessAddressCity,
	                @BusinessAddressState,
	                @BusinessAddressPostalCode,
			@HasPicture,
			@LastModificationTime,
			GETDATE()
		);
	END
ELSE
	BEGIN
		UPDATE Contacts SET
	                FirstName = @FirstName,
	                LastName = @LastName,
	                FullName = @FullName,
	                CompanyName = @CompanyName, 
	                JobTitle = @JobTitle,
	                Email1Address = @Email1Address,
	                Email2Address = @Email2Address,
	                Email3Address = @Email3Address,
	                WebPage = @WebPage,
	                IMAddress = @IMAddress,
	                MobileTelephoneNumber = dbo.fn_FormatPhoneNumber(@MobileTelephoneNumber),
	                HomeTelephoneNumber = dbo.fn_FormatPhoneNumber(@HomeTelephoneNumber),
	                BusinessTelephoneNumber = dbo.fn_FormatPhoneNumber(@BusinessTelephoneNumber),
	                BusinessFaxNumber = dbo.fn_FormatPhoneNumber(@BusinessFaxNumber),
	                HomeAddressStreet = @HomeAddressStreet,
	 
               HomeAddressCity = @HomeAddressCity,
	                HomeAddressState = @HomeAddressState,
	                HomeAddressPostalCode = @HomeAddressPostalCode,
	                BusinessAddressStreet = @BusinessAddressStreet,
	                BusinessAddressCity = @BusinessAddressCity,
	                BusinessAddressState = @BusinessAddressState,
	     		BusinessAddressPostalCode = @BusinessAddressPostalCode,
			HasPicture = @HasPicture,
	                LastModificationTime = @LastModificationTime	
	WHERE
			EntryID = @EntryID;
	END






CREATE PROCEDURE [dbo].[sp_Contacts_Maintenance]
AS

	UPDATE Contacts SET
	        MobileTelephoneNumber = dbo.fn_FormatPhoneNumber(MobileTelephoneNumber),
	        HomeTelephoneNumber = dbo.fn_FormatPhoneNumber(HomeTelephoneNumber),
	        BusinessTelephoneNumber = dbo.fn_FormatPhoneNumber(BusinessTelephoneNumber),
	        BusinessFaxNumber = dbo.fn_FormatPhoneNumber(BusinessFaxNumber),
		LastModificationTime = GETDATE();




CREATE PROCEDURE [dbo].[sp_Contacts_Search_get]
	@UserID		INT,
	@SearchString	VARCHAR(100)
AS

	IF @SearchString <> ''
		SET @SearchString = '%' + UPPER(@SearchString) + '%';

	SELECT 
		* 
	FROM 
		Contacts
	WHERE		
		UserID = @UserID AND
		Active = 1 AND
		(
		        UPPER(FirstName) LIKE @SearchString OR
		        UPPER(LastName) LIKE @SearchString OR
		        UPPER(FullName) LIKE @SearchString OR
		        UPPER(CompanyName) LIKE @SearchString OR
		        UPPER(JobTitle) LIKE @SearchString OR
		        UPPER(Email1Address) LIKE @SearchString OR
		        UPPER(Email2Address) LIKE @SearchString OR
		        UPPER(Email3Address) LIKE @SearchString OR
		        UPPER(WebPage) LIKE @SearchString OR
		        UPPER(IMAddress) LIKE @SearchString OR
		        UPPER(MobileTelephoneNumber) LIKE @SearchString OR
		        UPPER(HomeTelephoneNumber) LIKE @SearchString OR
		        UPPER(BusinessTelephoneNumber) LIKE @SearchString OR
		        UPPER(BusinessFaxNumber) LIKE @SearchString OR
		        UPPER(HomeAddressStreet) LIKE @SearchString OR
		        UPPER(HomeAddressCity) LIKE @SearchString OR
		        UPPER(HomeAddressState) LIKE @SearchString OR
		        UPPER(HomeAddressPostalCode) LIKE @SearchString OR
		        UPPER(BusinessAddressStreet) LIKE @SearchString OR
		        UPPER(BusinessAddressCity) LIKE @SearchString OR
		        UPPER(BusinessAddressState) LIKE @SearchString OR
		        UPPER(BusinessAddressPostalCode) LIKE @SearchString
		)
	ORDER BY
		FileAs;



CREATE PROCEDURE [dbo].[sp_Contacts_Sync_check]
	@UserID		INT
AS

	
	INSERT INTO Contacts
	(
		EntryID,
	        UserID,
		FileAs,
	        FirstName,
	        LastName,
	        FullName,
	        CompanyName,
	        JobTitle,
	        Email1Address,
	        Email2Address,
	        Email3Address,
	        WebPage,
	        IMAddress,
	        MobileTelephoneNumber,
	        HomeTelephoneNumber,
	        BusinessTelephoneNumber,
	        BusinessFaxNumber,
	        HomeAddressStreet,
	        HomeAddressCity,
	        HomeAddressState,
	        HomeAddressPostalCode,
	        BusinessAddressStreet,
	        BusinessAddressCity,
	        BusinessAddressState,
	        BusinessAddressPostalCode,
		HasPicture,
	        LastModificationTime
	)
	SELECT 
		EntryID,
	        UserID,
		FileAs,
	        FirstName,
	        LastName,
	        FullName,
	        CompanyName,
	        JobTitle,
	        Email1Address,
	        Email2Address,
	        Email3Address,
	        WebPage,
	        IMAddress,
	        MobileTelephoneNumber,
	        HomeTelephoneNumber,
	        BusinessTelephoneNumber,
	        BusinessFaxNumber,
	        HomeAddressStreet,
	        HomeAddressCity,
	        HomeAddressState,
	        HomeAddressPostalCode,
	        BusinessAddressStreet,
	        BusinessAddressCity,
	        BusinessAddressState,
	        BusinessAddressPostalCode,
		HasPicture,
	        LastModificationTime
	FROM
		ContactsOutlookExport
	WHERE
		EntryID NOT IN
		(
			SELECT
				EntryID
			FROM 
				Contacts
			WHERE
				Active = 1
		);

	SELECT
		a.EntryID,
		ContactsDateTime = a.LastModificationTime,
		ContactsOutlookExportDateTime = b.LastModificationTime,
		
		a.ContactID,
		b.ContactsOutlookExportID,
		ContactsFileAs = a.FileAs,
	        ContactsFirstName = a.FirstName,
	        ContactsLastName = a.LastName,
	        ContactsFullName = a.FullName,
	        ContactsCompanyName = a.CompanyName,
	        ContactsJobTitle = a.JobTitle,
	        ContactsEmail1Address = a.Email1Address,
	        ContactsEmail2Address = a.Email2Address,
	        ContactsEmail3Address = a.Email3Address,
	        ContactsWebPage = a.WebPage,
	        ContactsIMAddress = a.IMAddress,
	        ContactsMobileTelephoneNumber = a.MobileTelephoneNumber,
	        ContactsHomeTelephoneNumber = a.HomeTelephoneNumber,
	        ContactsBusinessTelephoneNumber = a.BusinessTelephoneNumber,
	        ContactsBusinessFaxNumber = a.BusinessFaxNumber,
	        ContactsHomeAddressStreet = a.HomeAddressStreet,
	        ContactsHomeAddressCity = a.HomeAddressCity,
	        ContactsHomeAddressState = a.HomeAddressState,
	        ContactsHomeAddressPostalCode = a.HomeAddressPostalCode,
	        ContactsBusinessAddressStreet = a.BusinessAddressStreet,
	        ContactsBusinessAddressCity = a.BusinessAddressCity,
	        ContactsBusinessAddressState = a.BusinessAddressState,
	        ContactsBusinessAddressPostalCode = a.BusinessAddressPostalCode,
	        ContactsHasPicture = b.HasPicture,

		ContactsOutlookExportFileAs = b.FileAs,
	        ContactsOutlookExportFirstName = b.FirstName,
	        ContactsOutlookExportLastName = b.LastName,
	        ContactsOutlookExportFullName = b.FullName,
	        ContactsOutlookExportCompanyName = b.CompanyName,
	        ContactsOutlookExportJobTitle = b.JobTitle,
	        ContactsOutlookExportEmail1Address = b.Email1Address,
	        ContactsOutlookExportEmail2Address = b.Email2Address,
	        ContactsOutlookExportEmail3Address = b.Email3Address,
	        ContactsOutlookExportWebPage = b.WebPage,
	        ContactsOutlookExportIMAddress = b.IMAddress,
	        ContactsOutlookExportMobileTelephoneNumber = b.MobileTelephoneNumber,
	        ContactsOutlookExportHomeTelephoneNumber = b.HomeTelephoneNumber,
	        ContactsOutlookExportBusinessTelephoneNumber = b.BusinessTelephoneNumber,
	        ContactsOutlookExportBusinessFa
xNumber = b.BusinessFaxNumber,
	        ContactsOutlookExportHomeAddressStreet = b.HomeAddressStreet,
	        ContactsOutlookExportHomeAddressCity = b.HomeAddressCity,
	        ContactsOutlookExportHomeAddressState = b.HomeAddressState,
	        ContactsOutlookExportHomeAddressPostalCode = b.HomeAddressPostalCode,
	        ContactsOutlookExportBusinessAddressStreet = b.BusinessAddressStreet,
	        ContactsOutlookExportBusinessAddressCity = b.BusinessAddressCity,
	        ContactsOutlookExportBusinessAddressState = b.BusinessAddressState,
	        ContactsOutlookExportBusinessAddressPostalCode = b.BusinessAddressPostalCode,
	        ContactsOutlookExportHasPicture = b.HasPicture
	FROM
		Contacts a,
		ContactsOutlookExport b
	WHERE
		a.EntryID = b.EntryID AND
		a.UserID = @UserID AND
		a.Active = 1 AND
		a.LastModificationTime <> b.LastModificationTime;





CREATE PROCEDURE [dbo].[sp_Contacts_update]
	@ContactID int,
        @EntryID varchar(50),
	@FileAs varchar(100),
        @FirstName varchar(20),
        @LastName varchar(20),
        @FullName varchar(50),
        @CompanyName varchar(100),
        @JobTitle varchar(50),
        @Email1Address varchar(100),
        @Email2Address varchar(100),
        @Email3Address varchar(100),
        @WebPage varchar(100),
        @IMAddress varchar(20),
        @MobileTelephoneNumber varchar(50),
        @HomeTelephoneNumber varchar(50),
        @BusinessTelephoneNumber varchar(50),
        @BusinessFaxNumber varchar(50),
        @HomeAddressStreet varchar(50),
        @HomeAddressCity varchar(50),
        @HomeAddressState varchar(50),
        @HomeAddressPostalCode varchar(50),
        @BusinessAddressStreet varchar(50),
        @BusinessAddressCity varchar(50),
        @BusinessAddressState varchar(50),
        @BusinessAddressPostalCode varchar(50),
	@HasPicture bit,
	@LastModificationTime datetime
AS
	
	UPDATE Contacts SET
		EntryID = @EntryID,
		FileAs = @FileAs,
		FirstName = @FirstName,
		LastName = @LastName,
		FullName = @FullName,
		CompanyName = @CompanyName,
		JobTitle = @JobTitle,
		Email1Address = @Email1Address,
		Email2Address = @Email2Address,
		Email3Address = @Email3Address,
		WebPage = @WebPage,
		IMAddress = @IMAddress,
		MobileTelephoneNumber = dbo.fn_FormatPhoneNumber(@MobileTelephoneNumber), 
		HomeTelephoneNumber = dbo.fn_FormatPhoneNumber(@HomeTelephoneNumber),
		BusinessTelephoneNumber = dbo.fn_FormatPhoneNumber(@BusinessTelephoneNumber),
		BusinessFaxNumber = dbo.fn_FormatPhoneNumber(@BusinessFaxNumber),
		HomeAddressStreet = @HomeAddressStreet,
		HomeAddressCity = @HomeAddressCity,
		HomeAddressState = @HomeAddressState,
		HomeAddressPostalCode = @HomeAddressPostalCode,
		BusinessAddressStreet = @BusinessAddressStreet,
		BusinessAddressCity = @BusinessAddressCity,
		BusinessAddressState = @BusinessAddressState,
		BusinessAddressPostalCode = @BusinessAddressPostalCode,
		HasPicture = @HasPicture,
		LastModificationTime = @LastModificationTime
	WHERE
		ContactID = @ContactID;




CREATE PROCEDURE [dbo].[sp_ContactsOutlookExport_delete]

AS 

	TRUNCATE TABLE ContactsOutlookExport;




CREATE PROCEDURE [dbo].[sp_ContactsOutlookExport_insert]
        @EntryID varchar(50),
        @UserID int,
	@FileAs varchar(100),
        @FirstName varchar(20),
        @LastName varchar(20),
        @FullName varchar(50),
        @CompanyName varchar(100),
        @JobTitle varchar(50),
        @Email1Address varchar(100),
        @Email2Address varchar(100),
        @Email3Address varchar(100),
        @WebPage varchar(100),
        @IMAddress varchar(20),
        @MobileTelephoneNumber varchar(50),
        @HomeTelephoneNumber varchar(50),
        @BusinessTelephoneNumber varchar(50),
        @BusinessFaxNumber varchar(50),
        @HomeAddressStreet varchar(50),
        @HomeAddressCity varchar(50),
        @HomeAddressState varchar(50),
        @HomeAddressPostalCode varchar(50),
        @BusinessAddressStreet varchar(50),
        @BusinessAddressCity varchar(50),
        @BusinessAddressState varchar(50),
        @BusinessAddressPostalCode varchar(50),
	@HasPicture BIT,
	@LastModificationTime DATETIME

AS 

	INSERT INTO ContactsOutlookExport
	(
		EntryID,
                UserID,
		FileAs,
                FirstName,
                LastName,
                FullName,
                CompanyName,
                JobTitle,
                Email1Address,
                Email2Address,
                Email3Address,
                WebPage,
                IMAddress,
                MobileTelephoneNumber,
                HomeTelephoneNumber,
                BusinessTelephoneNumber,
                BusinessFaxNumber,
                HomeAddressStreet,
                HomeAddressCity,
                HomeAddressState,
                HomeAddressPostalCode,
                BusinessAddressStreet,
                BusinessAddressCity,
                BusinessAddressState,
                BusinessAddressPostalCode,
		HasPicture,
                LastModificationTime,
		create_dt
	)
	VALUES
	(
		@EntryID,
                @UserID,
		@FileAs,
                @FirstName,
                @LastName,
                @FullName,
                @CompanyName,
                @JobTitle,
                @Email1Address,
                @Email2Address,
                @Email3Address,
                @WebPage,
                @IMAddress,
                @MobileTelephoneNumber,
                @HomeTelephoneNumber,
                @BusinessTelephoneNumber,
                @BusinessFaxNumber,
                @HomeAddressStreet,
                @HomeAddressCity,
                @HomeAddressState,
                @HomeAddressPostalCode,
                @BusinessAddressStreet,
                @BusinessAddressCity,
                @BusinessAddressState,
                @BusinessAddressPostalCode,
		@HasPicture,
		@LastModificationTime,
		GETDATE()
	);



CREATE PROCEDURE [dbo].[sp_CreditCard_delete]
	@CCID	INT
AS
	BEGIN TRANSACTION
		DELETE FROM CCBALANCE WHERE CCID = @CCID;
		IF @@ERROR <> 0 ROLLBACK TRANSACTION
		DELETE FROM CREDITCARD WHERE CreditCardID = @CCID;
		IF @@ERROR <> 0 ROLLBACK TRANSACTION
	COMMIT TRANSACTION


CREATE PROCEDURE [dbo].[sp_CreditCard_get]
	@UserID		INT
AS
	SELECT CreditCardID, CreditCardName FROM CreditCard WHERE USERID = @UserID ORDER BY CreditCardName;


CREATE PROCEDURE [dbo].[sp_CreditCards_CCID]
	@CCID		INT
AS
	SELECT CreditCardName, CreditLimit FROM CreditCard WHERE CreditCardID = @CCID


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





CREATE PROCEDURE [dbo].[sp_DeleteUser] 
	@UserID	INT
AS

	BEGIN TRANSACTION
		DELETE FROM Companies WHERE UserID = @UserID;
		IF @@ERROR <> 0 ROLLBACK TRANSACTION
		DELETE FROM CreditCard  WHERE UserID = @UserID;
		IF @@ERROR <> 0 ROLLBACK TRANSACTION
		DELETE FROM Logins WHERE UserID = @UserID;
		IF @@ERROR <> 0 ROLLBACK TRANSACTION
		DELETE FROM Users WHERE UserID = @UserID;
		IF @@ERROR <> 0 ROLLBACK TRANSACTION
	COMMIT TRANSACTION


CREATE PROCEDURE [dbo].[sp_Doctor_insert]
	@UserID			INT,
	@FirstName		VARCHAR(20),
	@LastName		VARCHAR(50),
	@TelephoneNumber	VARCHAR(50)
AS
	
	INSERT INTO Doctor 
		(UserID, FirstName, LastName, TelephoneNumber)
	VALUES
		(@UserID, @FirstName, @LastName, dbo.fn_FormatPhoneNumber(@TelephoneNumber));

	SELECT @@IDENTITY;



CREATE PROCEDURE [dbo].[sp_Doctor_update]
	@DoctorID			INT,
	@FirstName		VARCHAR(20),
	@LastName		VARCHAR(50),
	@TelephoneNumber	VARCHAR(50)
AS
	
	UPDATE Doctor SET
		FirstName = @FirstName,
		LastName = @LastName, 
		TelephoneNumber =  dbo.fn_FormatPhoneNumber(@TelephoneNumber)
	WHERE
		DoctorID = @DoctorID;






-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Doctor_UserID_get]
	@UserID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		DoctorID,
		DoctorName =
			CASE 
				WHEN FirstName <> '' THEN
					LastName + ', ' + FirstName
				ELSE
					LastName
			END,
		FirstName,
		LastName,
		TelephoneNumber,
		TotalDoctors = (SELECT COUNT(*) FROM Doctor WHERE UserID = @UserID)
	FROM
		Doctor
	WHERE
		UserID = @UserID
	ORDER BY
		DoctorName
	
		
END



CREATE PROCEDURE [dbo].[sp_Emails_Contacts_get]
	@UserID		INT
AS

	SELECT 
		FullName = (FirstName + ' ' + LastName), 
		Email1Address
	FROM 
		Contacts 
	WHERE 
		UserID = @UserID AND 
		LTRIM(RTRIM(Email1Address)) <> '' 
	ORDER BY 
		FirstName




CREATE PROCEDURE [dbo].[sp_EmailTemplates_get]
	@UserID				INT
AS


	SELECT * FROM EmailTemplates WHERE UserID = @UserID;




CREATE PROCEDURE [dbo].[sp_EmailTemplates_update]
	@UserID				INT, 
	@CreateAccountSubject		VARCHAR(200), 
	@CreateAccountEmail		VARCHAR(MAX), 
	@ForgotPasswordSubject		VARCHAR(200), 
	@ForgotPasswordEmail		VARCHAR(MAX)
AS

	IF NOT EXISTS (SELECT 1 FROM EmailTemplates WHERE UserID = @UserID)
		BEGIN
			INSERT INTO EmailTemplates
				(UserID, CreateAccountSubject, CreateAccountEmail, ForgotPasswordSubject, ForgotPasswordEmail)
			VALUES
				(@UserID, @CreateAccountSubject, @CreateAccountEmail, @ForgotPasswordSubject, @ForgotPasswordEmail);
		END 	
	ELSE
		BEGIN
			UPDATE EmailTemplates SET
				CreateAccountSubject = @CreateAccountSubject,
				CreateAccountEmail = @CreateAccountEmail, 
				ForgotPasswordSubject = @ForgotPasswordSubject,
				ForgotPasswordEmail = @ForgotPasswordEmail
			WHERE
				UserID = @UserID;
		END 	





CREATE PROCEDURE [dbo].[sp_ExecutedSQLScripts_get]
AS
	
	SELECT TOP 50
		create_dt AS Time,
		ApplicationName AS Application,
		ExecutedSQLScript AS SQL
	FROM
		ExecutedSQLScripts
	ORDER BY
		create_dt 
	DESC;





CREATE PROCEDURE [dbo].[sp_ExecutedSQLScripts_insert]
	@ApplicationName	VARCHAR(100),
	@ExecutedSQLScript	VARCHAR(1000)
AS
	
	INSERT INTO ExecutedSQLScripts
		(ApplicationName, ExecutedSQLScript)
	VALUES
		(@ApplicationName, @ExecutedSQLScript);




CREATE PROCEDURE [dbo].[sp_Health_reports]
	@UserID			INT,
	@TotalDays		INT,
	@ReportType		TINYINT = 1
	-- 1 = AVERAGE OF ALL: HeartRate, Sugar, Temperature, BloodPressure
	-- 2 = ALL MEDICINES TAKEN AND AMOUNT
	-- 3 = SHOWS ALL HEALTH, 
AS
	SET NOCOUNT ON;

	IF @ReportType = 1
		BEGIN	
			DECLARE @SQL		NVARCHAR(2000);
		
			SET @SQL = '';
			SET @SQL = @SQL + 'DECLARE @HeartRate		NUMERIC(9,2);' + CHAR(13);
			SET @SQL = @SQL + 'SELECT TOP ' + CONVERT(VARCHAR, @TotalDays) + ' HeartRate INTO #HeartRate FROM HeartRate WHERE UserID = ' + CONVERT(VARCHAR, @UserID) + ' ORDER BY create_dt DESC;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT @HeartRate = SUM(HeartRate) / ' + CONVERT(VARCHAR, @TotalDays) + ' FROM #HeartRate;' + CHAR(13);
			SET @SQL = @SQL + 'DECLARE @Sugar		NUMERIC(9,2);' + CHAR(13);
			SET @SQL = @SQL + 'SELECT TOP ' + CONVERT(VARCHAR, @TotalDays) + ' Sugar INTO #Sugar FROM Sugar WHERE UserID = ' + CONVERT(VARCHAR, @UserID) + ' ORDER BY create_dt DESC;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT @Sugar = SUM(Sugar) / ' + CONVERT(VARCHAR, @TotalDays) + ' FROM #Sugar;' + CHAR(13);
			SET @SQL = @SQL + 'DECLARE @Temperature		NUMERIC(9,2);' + CHAR(13);
			SET @SQL = @SQL + 'SELECT TOP ' + CONVERT(VARCHAR, @TotalDays) + ' Temperature INTO #Temperature FROM Temperature WHERE UserID = ' + CONVERT(VARCHAR, @UserID) + ' ORDER BY create_dt DESC;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT @Temperature = SUM(Temperature) / ' + CONVERT(VARCHAR, @TotalDays) + ' FROM #Temperature;' + CHAR(13);
			SET @SQL = @SQL + 'DECLARE @BloodPressureTop		NUMERIC(9,2);' + CHAR(13);
			SET @SQL = @SQL + 'SELECT TOP ' + CONVERT(VARCHAR, @TotalDays) + ' BloodPressureTop INTO #BloodPressureTop FROM BloodPressure WHERE UserID = ' + CONVERT(VARCHAR, @UserID) + ' ORDER BY create_dt DESC;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT @BloodPressureTop = SUM(BloodPressureTop) / ' + CONVERT(VARCHAR, @TotalDays) + ' FROM #BloodPressureTop;' + CHAR(13);
			SET @SQL = @SQL + 'DECLARE @BloodPressureBottom		NUMERIC(9,2);' + CHAR(13);
			SET @SQL = @SQL + 'SELECT TOP ' + CONVERT(VARCHAR, @TotalDays) + ' BloodPressureBottom INTO #BloodPressureBottom FROM BloodPressure WHERE UserID = ' + CONVERT(VARCHAR, @UserID) + ' ORDER BY create_dt DESC;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT @BloodPressureBottom = SUM(BloodPressureBottom) / ' + CONVERT(VARCHAR, @TotalDays) + ' FROM #BloodPressureBottom;' + CHAR(13);
			SET @SQL = @SQL + 'SELECT ' + CHAR(13);
			SET @SQL = @SQL + 'HeartRate = @HeartRate, ' + CHAR(13);
			SET @SQL = @SQL + 'Sugar = @Sugar, ' + CHAR(13);
			SET @SQL = @SQL + 'Temperature = @Temperature, ' + CHAR(13);
			SET @SQL = @SQL + 'BloodPressureTop = @BloodPressureTop, ' + CHAR(13);
			SET @SQL = @SQL + 'BloodPressureBottom = @BloodPressureBottom, ' + CHAR(13);
			SET @SQL = @SQL + 'BloodPressure = CONVERT(VARCHAR, @BloodPressureTop) + ''/'' + CONVERT(VARCHAR, @BloodPressureBottom)' + CHAR(13);
		
			--PRINT @SQL;
			EXEC(@SQL);
		END

	ELSE IF @ReportType = 2

		BEGIN
			SELECT 
				MedicineID,
				Medicine = Replace(MedicineName + ' (' + GenericName + ')', ' ()', ''), 
				Total = (SELECT COUNT(*) FROM MedicineDose WHERE MedicineID = Medicine.MedicineID)
			FROM 
				Medicine 
			WHERE 
				UserID = @UserID
			ORDER BY
				Medicine;
		END

	ELSE IF @ReportType = 3

		BEGIN
			SELECT 
				MedicineID,
				Medicine = Replace(MedicineName + ' (' + GenericName + ')', ' ()', ''), 
				Total = (SELECT COUNT(*) FROM MedicineDose WHERE MedicineID = Medicine.MedicineID)
			FROM 
				Medicine 
			WHERE 
				UserID = @UserID
			ORDER BY
				Medicine;
		END



CREATE PROCEDURE [dbo].[sp_Health_reports_export]
	@UserID			INT,
	@StartDate		DATETIME,
	@EndDate		DATETIME
AS
	SET NOCOUNT ON;

	DECLARE @MaxRows	INT;
	SET @MaxRows = 0;
	DECLARE @MaxRows_tmp	INT;
	SET @MaxRows = 0;
	DECLARE @RowID	INT;
	SET @RowID = 1;

	SET @EndDate = DATEADD(day, 1, @EndDate);


	CREATE TABLE #HealthReports
	(
		HealthReportID			INT NOT NULL,
		SugarDateTime			DATETIME NULL,
		Sugar				INT NULL,
		SugarComments			VARCHAR(1000) NULL,
		MedicineDoseDateTime		DATETIME NULL,
		Medicine			VARCHAR(1000) NULL,
		MedicineDoseAmount		VARCHAR(100) NULL,
		MedicineDoseDescription		VARCHAR(1000) NULL,
		BloodPressureDateTime		DATETIME NULL,
		BloodPressure			VARCHAR(1000),
		HeartRateDateTime		DATETIME NULL,
		HeartRate			INT NULL,
		TemperatureDateTime		DATETIME NULL,
		Temperature			NUMERIC(9,2) NULL
	)

	SELECT 
		b.MedicineDoseDateTime,
		Medicine = 
			CASE a.GenericName
				WHEN NULL THEN
					a.MedicineName
				WHEN '' THEN
					a.MedicineName
				ELSE
					a.MedicineName + ' (' + a.GenericName + ')' 
			END,
		MedicineDoseAmount = CONVERT(VARCHAR, b.Amount) + ' ' + c.UnitName,
		b.MedicineDoseDescription
	INTO
		#MedicineDose_tmp
	FROM 
		Medicine a,
		MedicineDose b,
		Unit c
	WHERE 
		a.MedicineID = b.MedicineID AND
		a.UnitID = c.UnitID AND
		a.UserID = @UserID AND
		b.MedicineDoseDateTime >= @StartDate AND
		b.MedicineDoseDateTime <= @EndDate	
	ORDER BY
		b.MedicineDoseDateTime DESC;

	CREATE TABLE #MedicineDose
	(
		MedicineDoseID			INT IDENTITY(1,1) NOT NULL,
		MedicineDoseDateTime		DATETIME NULL,
		Medicine			VARCHAR(1000) NULL,
		MedicineDoseAmount		VARCHAR(1000) NULL,
		MedicineDoseDescription		VARCHAR(1000) NULL
	);
	
	INSERT INTO #MedicineDose
		(MedicineDoseDateTime, Medicine, MedicineDoseAmount, MedicineDoseDescription)
		(
			SELECT
				MedicineDoseDateTime, 
				Medicine,
				MedicineDoseAmount,
				MedicineDoseDescription
			FROM
				#MedicineDose_tmp
		);

	SET @MaxRows_tmp = @@ROWCOUNT;
	--PRINT 'MedicineDose: ' + CONVERT(VARCHAR, @MaxRows_tmp);
	IF @MaxRows_tmp > @MaxRows
		SET @MaxRows = @MaxRows_tmp;

	CREATE TABLE #HeartRate
	(
		HeartRateID		INT IDENTITY(1,1) NOT NULL,
		HeartRateDateTime	DATETIME NULL,
		HeartRate		INT NULL
	);

	SELECT
		HeartRateDateTime, 
		HeartRate
	INTO
		#HeartRate_tmp
	FROM 
		HeartRate
	WHERE
		UserID = @UserID AND
		HeartRateDateTime >= @StartDate AND
		HeartRateDateTime <= @EndDate
	ORDER BY
		HeartRateDateTime DESC;

	INSERT INTO #HeartRate
		(HeartRateDateTime, HeartRate)
		(
			SELECT
				HeartRateDateTime, 
				HeartRate
			FROM 
				#HeartRate_tmp
		);

	SET @MaxRows_tmp = @@ROWCOUNT;
	--PRINT 'HeartRate: ' + CONVERT(VARCHAR, @MaxRows_tmp);
	IF @MaxRows_tmp > @MaxRows
		SET @MaxRows = @MaxRows_tmp;
			
	CREATE TABLE #Sugar
	(
		SugarID		INT IDENTITY(1,1) NOT NULL,
		SugarDateTime	DATETIME NULL,
		Sugar		INT NULL,
		SugarComments	VARCHAR(1000)

	);

	SELECT
		SugarDateTime, 
		Sugar,
		SugarComments
	INTO 
		#Sugar_tmp
	FROM 
		Sugar
	WHERE
		UserID = @UserID AND
		SugarDateTime >= @StartDate AND
		SugarDateTime <= @EndDate
	ORDER BY
		SugarDateTime DESC;

	INSERT INTO #Sugar
		(SugarDateTime, Sugar, SugarComments)
		(
			SELECT
				SugarDateTime, 
				Sugar,
				SugarComments
			FROM 
				#Sugar_tmp
		);

	SET @MaxRows_tmp = @@ROWCOUNT;
	--PRINT 'Sugar: ' + CONVERT(VARCHAR, @MaxRows_tmp);
	IF @MaxRows_tmp > @MaxRows
		SET @MaxRows = @MaxRows_tmp;

	CREATE TABLE #Temperature
	(
		TemperatureID		INT IDENTITY(1,1) NOT NULL,
		TemperatureDateTime	DATETIME NULL,
		Temperature		NUMERIC(9,2) NULL

	);

	SELECT
		TemperatureDateTime, 
		Temperature
	INTO 
		#Temperature_tmp
	FROM 
		Temperature
	WHERE
		UserID = @UserID AND
		TemperatureDateTime >= @StartDate AND
		TemperatureDateTime <= @EndDate
	ORDER BY
		TemperatureDateTime;

	INSERT INTO #Temperature
		(TemperatureDateTim
e, Temperature)
		(
			SELECT
				TemperatureDateTime, 
				Temperature
			FROM 
				#Temperature_tmp
		);

	SET @MaxRows_tmp = @@ROWCOUNT;
	IF @MaxRows_tmp > @MaxRows
		SET @MaxRows = @MaxRows_tmp;

	SELECT
		BloodPressureDateTime, 
		BloodPressure = CONVERT(VARCHAR, BloodPressureTop) + '/' + CONVERT(VARCHAR, BloodPressureBottom)
	INTO
		#BloodPressure_tmp
	FROM 
		BloodPressure
	WHERE
		UserID = @UserID AND
		BloodPressureDateTime >= @StartDate AND
		BloodPressureDateTime <= @EndDate
	ORDER BY
		BloodPressureDateTime DESC;

	CREATE TABLE #BloodPressure
	(
		BloodPressureID		INT IDENTITY(1,1) NOT NULL,
		BloodPressureDateTime	DATETIME NULL,
		BloodPressure		VARCHAR(1000) NULL

	);

	INSERT INTO #BloodPressure
		(BloodPressureDateTime, BloodPressure)
		(
			SELECT
				BloodPressureDateTime, 
				BloodPressure
			FROM 
				#BloodPressure_tmp
		);

	SET @MaxRows_tmp = @@ROWCOUNT;
	--PRINT 'BloodPressure: ' + CONVERT(VARCHAR, @MaxRows_tmp);
	IF @MaxRows_tmp > @MaxRows
		SET @MaxRows = @MaxRows_tmp;
		
	WHILE (@MaxRows >= @RowID)
		BEGIN
			INSERT INTO #HealthReports (HealthReportID) VALUES (@RowID);
			SET @RowID = @RowID + 1;
		END

	UPDATE #HealthReports SET
		SugarDateTime = (SELECT SugarDateTime FROM #Sugar WHERE SugarID = #HealthReports.HealthReportID)
		, Sugar = (SELECT Sugar FROM #Sugar WHERE SugarID = #HealthReports.HealthReportID)
		, SugarComments = (SELECT SugarComments FROM #Sugar WHERE SugarID = #HealthReports.HealthReportID)
		, MedicineDoseDateTime = (SELECT MedicineDoseDateTime FROM #MedicineDose WHERE MedicineDoseID = #HealthReports.HealthReportID)
		, Medicine = (SELECT Medicine FROM #MedicineDose WHERE MedicineDoseID = #HealthReports.HealthReportID)
		, MedicineDoseAmount = (SELECT MedicineDoseAmount FROM #MedicineDose WHERE MedicineDoseID = #HealthReports.HealthReportID)
		, MedicineDoseDescription = (SELECT MedicineDoseDescription FROM #MedicineDose WHERE MedicineDoseID = #HealthReports.HealthReportID)
		, HeartRateDateTime = (SELECT HeartRateDateTime FROM #HeartRate WHERE HeartRateID = #HealthReports.HealthReportID)
		, HeartRate = (SELECT HeartRate FROM #HeartRate WHERE HeartRateID = #HealthReports.HealthReportID)
		, BloodPressureDateTime = (SELECT BloodPressureDateTime FROM #BloodPressure WHERE BloodPressureID = #HealthReports.HealthReportID)
		, BloodPressure = (SELECT BloodPressure FROM #BloodPressure WHERE BloodPressureID = #HealthReports.HealthReportID)
		, TemperatureDateTime = (SELECT TemperatureDateTime FROM #Temperature WHERE TemperatureID = #HealthReports.HealthReportID)
		, Temperature = (SELECT Temperature FROM #Temperature WHERE TemperatureID = #HealthReports.HealthReportID)
					

	/*
	SELECT * FROM #Medicine;
	SELECT * FROM #HeartRate;
	SELECT * FROM #Sugar;
	SELECT * FROM #Temperature;
	SELECT * FROM #BloodPressure;
	*/

	SELECT * FROM #HealthReports;



CREATE PROCEDURE [dbo].[sp_HeartRate_insert]
	@UserID			INT = NULL,
	@HeartRateDateTime	DATETIME,
	@HeartRate		SMALLINT, 
	@HeartRateComments	VARCHAR(2000)
AS
	
	INSERT INTO HeartRate
		(UserID, HeartRateDateTime, HeartRate, HeartRateComments)
	VALUES
		(@UserID, @HeartRateDateTime, @HeartRate, @HeartRateComments)

	SELECT @@IDENTITY;



CREATE PROCEDURE [dbo].[sp_HeartRate_update]
	@HeartRateID			INT,
	@HeartRateDateTime	DATETIME,
	@HeartRate		SMALLINT, 
	@HeartRateComments	VARCHAR(2000)
AS
	
	UPDATE HeartRate SET
		HeartRateDateTime = @HeartRateDateTime, 
		HeartRate = @HeartRate,
		HeartRateComments = @HeartRateComments
	WHERE
		HeartRateID = @HeartRateID;



CREATE PROCEDURE [dbo].[sp_Hospital_update]
	@HospitalID				INT,
	@HospitalName 			VARCHAR(100)
AS
	
	UPDATE Hospital SET
		HospitalName = @HospitalName
	WHERE
		(HospitalID = @HospitalID);

	SELECT @@IDENTITY;





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HospitalStaff_Search_UserID_get]
	@UserID			INT,
	@StaffName		VARCHAR(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @StaffName = '%' + @StaffName + '%';

	SELECT
		c.HospitalStaffID,
		Hospital = a.HospitalName,
		Position = b.HospitalPositionName,
		FullName =
			CASE 
				WHEN c.FirstName <> '' AND c.LastName <> '' THEN
					c.LastName + ', ' + c.FirstName
				WHEN c.FirstName <> '' AND c.LastName = '' THEN
					c.FirstName
				WHEN c.LastName <> '' THEN
					c.LastName
				ELSE
					c.LastName
			END
	FROM
		Hospital a,
		HospitalPosition b,
		HospitalStaff c
	WHERE
		c.UserID = @UserID AND
		a.HospitalID = c.HospitalID AND
		b.HospitalPositionID = c.HospitalPositionID AND
		(
			a.HospitalName LIKE @StaffName OR
			c.FirstName LIKE @StaffName OR
			c.LastName LIKE @StaffName
		)
	ORDER BY
		FullName;
	
		
END





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HospitalStaff_UserID_get]
	@UserID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		c.HospitalStaffID,
		Hospital = a.HospitalName,
		Position = b.HospitalPositionName,
		FullName =
			CASE 
				WHEN c.FirstName <> '' AND c.LastName <> '' THEN
					c.LastName + ', ' + c.FirstName
				WHEN c.FirstName <> '' AND c.LastName = '' THEN
					c.FirstName
				WHEN c.LastName <> '' THEN
					c.LastName
				ELSE
					c.LastName
			END
	FROM
		Hospital a,
		HospitalPosition b,
		HospitalStaff c
	WHERE
		c.UserID = @UserID AND
		a.HospitalID = c.HospitalID AND
		b.HospitalPositionID = c.HospitalPositionID
	ORDER BY
		FullName;
	
		
END





CREATE PROCEDURE [dbo].[sp_JobCompany_insert]
	@UserID				INT,
	@JobCompanyName			VARCHAR(50),
	@JobCompanyWebsite		VARCHAR(100),
	@JobCompanyLinkedIn		VARCHAR(500),
	@JobCompanyTwitter		VARCHAR(500),
	@JobCompanyFacebook		VARCHAR(500),
	@JobCompanyGooglePlus		VARCHAR(500),
	@JobCompanyYouTube		VARCHAR(500)
AS
	
	
	INSERT INTO JobCompany 
		(UserID, JobCompanyName, JobCompanyWebsite, JobCompanyLinkedIn, JobCompanyTwitter, JobCompanyFacebook, JobCompanyGooglePlus, JobCompanyYouTube) 
	VALUES
		(@UserID, @JobCompanyName, @JobCompanyWebsite, @JobCompanyLinkedIn, @JobCompanyTwitter, @JobCompanyFacebook, @JobCompanyGooglePlus, @JobCompanyYouTube);

	SELECT @@IDENTITY;



CREATE PROCEDURE [dbo].[sp_JobCompany_New_get]
	@UserID				INT
AS

	SELECT TOP 20 
		JobCompanyID,
		Created = create_dt,
		JobCompanyName,
		JobCompanyWebsite,
		TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = JobCompany.JobCompanyID),
		TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = JobCompany.JobCompanyID),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = JobCompany.JobCompanyID)
	FROM
		JobCompany
	WHERE
		UserID = @UserID
	ORDER BY
		create_dt DESC;






CREATE PROCEDURE [dbo].[sp_JobCompany_UserID_get]
	@UserID				INT
AS

	SELECT
		JobCompanyID,
		JobCompanyName
	FROM
		JobCompany
	WHERE
		UserID = @UserID
	ORDER BY
		JobCompanyName;






CREATE PROCEDURE [dbo].[sp_JobCompany_UserID_Letter_get]
	@UserID				INT,
	@Letter				VARCHAR(3) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 IF @Letter IS NOT NULL
		SET @Letter = UPPER(@Letter) + '%';

	 IF @Letter IS NOT NULL
		BEGIN
			IF @Letter = 'ALL'
				SELECT *, 
					TotalCompanies = (SELECT COUNT(*) FROM JobCompany WHERE UserID = @UserID),
					TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = JobCompany.JobCompanyID),
					TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = JobCompany.JobCompanyID),
					TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = JobCompany.JobCompanyID)
				FROM 
					JobCompany 
				WHERE 
					UserID = @UserID
				ORDER BY 
					JobCompanyName;
			ELSE
				SELECT 
					*, 
					TotalCompanies = (SELECT COUNT(*) FROM JobCompany WHERE UserID = @UserID AND UPPER(JobCompanyName) LIKE @Letter),
					TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = JobCompany.JobCompanyID AND UPPER(JobCompanyName) LIKE @Letter),
					TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = JobCompany.JobCompanyID AND UPPER(JobCompanyName) LIKE @Letter),
					TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = JobCompany.JobCompanyID AND UPPER(JobCompanyName) LIKE @Letter)
				FROM 
					JobCompany 
				WHERE 
					UserID = @UserID AND
					UPPER(JobCompanyName) LIKE @Letter
				ORDER BY 
					JobCompanyName;
		END
	ELSE
		SELECT 
			*, 
			TotalCompanies = (SELECT COUNT(*) FROM JobCompany WHERE JobCompanyID = JobCompany.JobCompanyID),
			TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = JobCompany.JobCompanyID),
			TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = JobCompany.JobCompanyID),
			TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = JobCompany.JobCompanyID) 
		FROM 
			JobCompany 
		WHERE 
			UserID = @UserID 
		ORDER BY 
			JobCompanyName;

END





CREATE PROCEDURE [dbo].[sp_JobCompany_UserID_Search_get]
	@UserID				INT,
	@Letter				VARCHAR(20) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @Letter = '%' + UPPER(@Letter) + '%';

	SELECT 
		*, 
		TotalCompanies = (SELECT COUNT(*) FROM JobCompany WHERE UserID = @UserID AND UPPER(JobCompanyName) LIKE @Letter),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = JobCompany.JobCompanyID AND UPPER(JobCompanyName) LIKE @Letter),
		TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = JobCompany.JobCompanyID AND UPPER(JobCompanyName) LIKE @Letter),
		TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = JobCompany.JobCompanyID AND UPPER(JobCompanyName) LIKE @Letter)
	FROM 
		JobCompany 
	WHERE 
		UserID = @UserID AND
		UPPER(JobCompanyName) LIKE @Letter
	ORDER BY 
		JobCompanyName;
END





CREATE PROCEDURE [dbo].[sp_JobCompanyContact_insert]
	@JobCompanyID				INT, 
	@JobCompanyContactTitle			VARCHAR(100), 
	@JobCompanyContactFirstName		VARCHAR(50),
	@JobCompanyContactLastName		VARCHAR(50), 
	@JobCompanyContactWorkPhone		VARCHAR(50), 
	@JobCompanyContactCellPhone		VARCHAR(50), 
	@JobCompanyContactFax			VARCHAR(50), 
	@JobCompanyContactEmail			VARCHAR(100),
	@JobCompanyContactLinkedIn		VARCHAR(500),
	@JobCompanyContactTwitter		VARCHAR(500),
	@JobCompanyContactFacebook		VARCHAR(500),
	@JobCompanyContactGooglePlus		VARCHAR(500),
	@JobCompanyContactNotes			VARCHAR(MAX)
AS

	INSERT INTO JobCompanyContact
		(JobCompanyID, JobCompanyContactTitle, JobCompanyContactFirstName, JobCompanyContactLastName, JobCompanyContactWorkPhone, JobCompanyContactCellPhone, JobCompanyContactFax, JobCompanyContactEmail, JobCompanyContactLinkedIn, JobCompanyContactTwitter, JobCompanyContactFacebook, JobCompanyContactGooglePlus, JobCompanyContactNotes)
	VALUES
		(@JobCompanyID, @JobCompanyContactTitle, @JobCompanyContactFirstName, @JobCompanyContactLastName, dbo.fn_FormatPhoneNumber(@JobCompanyContactWorkPhone), dbo.fn_FormatPhoneNumber(@JobCompanyContactCellPhone), dbo.fn_FormatPhoneNumber(@JobCompanyContactFax), @JobCompanyContactEmail, @JobCompanyContactLinkedIn, @JobCompanyContactTwitter, @JobCompanyContactFacebook, @JobCompanyContactGooglePlus, @JobCompanyContactNotes);


	SELECT @@IDENTITY;




CREATE PROCEDURE [dbo].[sp_JobCompanyContact_JobCompanyID_get]
	@JobCompanyID				INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		JobCompanyContactID,
		JobCompanyContactName = 
			CASE 
				WHEN JobCompanyContactFirstName <> '' AND JobCompanyContactLastName = '' THEN
					JobCompanyContactFirstName
				WHEN JobCompanyContactFirstName = '' AND JobCompanyContactLastName <> '' THEN
					JobCompanyContactLastName
				ELSE
					JobCompanyContactLastName + ', ' + JobCompanyContactFirstName
			END,
		*
	FROM
		JobCompanyContact
	WHERE
		JobCompanyID = @JobCompanyID
	ORDER BY 
		JobCompanyContactID DESC;

END





CREATE PROCEDURE [dbo].[sp_JobCompanyContact_New_get]
	@UserID				INT
AS

	SELECT TOP 20 
		b.JobCompanyContactID,
		a.JobCompanyID,
		Created = b.create_dt,
		a.JobCompanyName,
		JobCompanyContactName = 
			CASE 
				WHEN b.JobCompanyContactFirstName <> '' AND b.JobCompanyContactLastName = '' THEN
					b.JobCompanyContactFirstName
				WHEN b.JobCompanyContactFirstName = '' AND b.JobCompanyContactLastName <> '' THEN
					b.JobCompanyContactLastName
				ELSE
					b.JobCompanyContactLastName + ', ' + b.JobCompanyContactFirstName
			END,
		TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = a.JobCompanyID),
		TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = a.JobCompanyID),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyContactID = b.JobCompanyID)
	FROM
		JobCompany a,
		JobCompanyContact b
	WHERE
		a.JobCompanyID = b.JobCompanyID AND
		a.UserID = @UserID
	ORDER BY
		b.create_dt DESC;






CREATE PROCEDURE [dbo].[sp_JobCompanyContact_UserID_Search_get]
	@UserID				INT,
	@JobSearchString			VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @JobSearchString = '''%' + UPPER(@JobSearchString) + '%''';
	DECLARE @JobSearchString2		VARCHAR(50);

	IF @JobSearchString <> ''
		SET @JobSearchString2 = '''%' + UPPER(dbo.fn_RemoveAlphaCharacters(@JobSearchString)) + '%''';

	DECLARE @SQLSTRING			NVARCHAR(3000);

	SET @SQLSTRING = '
	SELECT 
		a.*,
		b.*, 
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = b.JobCompanyID),
		TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = b.JobCompanyID),
		TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = b.JobCompanyID)
	FROM 
		JobCompany a,
		JobCompanyContact b

	WHERE 
		a.JobCompanyID = b.JobCompanyID AND
		a.UserID = ' + CONVERT(VARCHAR, @UserID) + ' AND
		(
			UPPER(b.JobCompanyContactFirstName) LIKE ' + @JobSearchString + ' OR
			UPPER(b.JobCompanyContactLastName) LIKE ' + @JobSearchString + ' OR
			UPPER(b.JobCompanyContactEmail) LIKE ' + @JobSearchString;

	IF @JobSearchString2 <> '''%%'''
		BEGIN
			SET @SQLSTRING = @SQLSTRING + ' OR UPPER(dbo.fn_RemoveAlphaCharacters(b.JobCompanyContactWorkPhone)) LIKE ' + @JobSearchString2 + ' OR
			UPPER(dbo.fn_RemoveAlphaCharacters(b.JobCompanyContactFax)) LIKE ' + @JobSearchString2 + ' OR
			UPPER(dbo.fn_RemoveAlphaCharacters(b.JobCompanyContactCellPhone)) LIKE ' + @JobSearchString2;
		END
	SET @SQLSTRING = @SQLSTRING + ')
	ORDER BY 
		a.JobCompanyName;';

	EXEC sp_executesql @SQLSTRING;
END






CREATE PROCEDURE [dbo].[sp_JobCompanyPhoneCall_insert]
	@JobCompanyID				INT,
	@JobCompanyContactID			INT,
	@JobCompanyPhoneCallTypeID		INT,
	@JobCompanyPhoneCallDateTime		DATETIME,
	@JobCompanyPhoneCallPhoneNumber		VARCHAR(50),
	@JobCompanyPhoneCallNotes		VARCHAR(MAX)
AS
	
	
	INSERT INTO JobCompanyPhoneCall 
		(JobCompanyID, JobCompanyContactID, JobCompanyPhoneCallTypeID, JobCompanyPhoneCallDateTime, JobCompanyPhoneCallPhoneNumber, JobCompanyPhoneCallNotes) 
	VALUES
		(@JobCompanyID, @JobCompanyContactID, @JobCompanyPhoneCallTypeID, @JobCompanyPhoneCallDateTime, dbo.fn_FormatPhoneNumber(@JobCompanyPhoneCallPhoneNumber), @JobCompanyPhoneCallNotes) 

	SELECT @@IDENTITY;




CREATE PROCEDURE [dbo].[sp_JobCompanyPhoneCall_JobCompanyID_get]
	@JobCompanyID			INT
AS
	
	
	SELECT 
		a.*,
		JobCompanyPhoneCallContactName = 
			(SELECT JobCompanyClientName =  
				CASE 
					WHEN JobCompanyContactFirstName <> '' AND JobCompanyContactLastName = '' THEN
						JobCompanyContactFirstName
					WHEN JobCompanyContactFirstName = '' AND JobCompanyContactLastName <> '' THEN
						JobCompanyContactLastName
					ELSE
						JobCompanyContactLastName + ', ' + JobCompanyContactFirstName
				END
			FROM 
				JobCompanyContact
			WHERE 
				JobCompanyContactID = a.JobCompanyContactID) 
	FROM 
		JobCompanyPhoneCall a
	WHERE 
		a.JobCompanyID = @JobCompanyID 
	ORDER BY 
		a.create_dt DESC;




CREATE PROCEDURE [dbo].[sp_JobCompanyPhoneCallType_get]
AS


	SELECT
		JobCompanyPhoneCallTypeID,
		JobCompanyPhoneCallType
	FROM
		JobCompanyPhoneCallType
	ORDER BY
		JobCompanyPhoneCallType;
	




CREATE PROCEDURE [dbo].[sp_JobCoverLetter_insert]
	@UserID				INT,
	@JobCoverLetterName		VARCHAR(100),
	@JobCoverLetterText		VARCHAR(MAX)
AS
	
	
	INSERT INTO JobCoverLetter 
		(UserID, JobCoverLetterName, JobCoverLetterText)
	VALUES
		(@UserID, @JobCoverLetterName, @JobCoverLetterText);


	SELECT @@IDENTITY;




CREATE PROCEDURE [dbo].[sp_JobInterview_ClientID_get]
	@JobCompanyID			INT
AS
	
	
	SELECT
		a.JobCompanyID,
		a.JobCompanyName
	FROM
		JobCompany a
	WHERE
		a.JobCompanyID NOT IN
			(
				SELECT
					JobCompanyID
				FROM
					JobCompany
				WHERE
					UserID = a.UserID AND
					JobCompanyID <> a.JobCompanyID
			)
	ORDER BY
		a.JobCompanyName;




CREATE PROCEDURE [dbo].[sp_JobInterview_insert]
	@JobCompanyID			INT,
	@JobInterviewTypeID		INT,
	@JobInterviewDateTime		DATETIME,
	@JobInterviewClientID		INT,
	@JobInterviewClientContactID	INT,
	@JobInterviewAddress1		VARCHAR(50),
	@JobInterviewAddress2		VARCHAR(50),
	@JobInterviewCity		VARCHAR(50),
	@StateID			INT,
	@JobInterviewZipCode		VARCHAR(20),
	@JobInterviewNotes		VARCHAR(MAX)
AS
	
	
	INSERT INTO JobInterview 
		(JobCompanyID, JobInterviewTypeID, JobInterviewDateTime, JobInterviewClientID, JobInterviewClientContactID, JobInterviewAddress1, JobInterviewAddress2, JobInterviewCity, StateID, JobInterviewZipCode, JobInterviewNotes) 
	VALUES
		(@JobCompanyID, @JobInterviewTypeID, @JobInterviewDateTime, @JobInterviewClientID, @JobInterviewClientContactID, @JobInterviewAddress1, @JobInterviewAddress2, @JobInterviewCity, @StateID, @JobInterviewZipCode, @JobInterviewNotes) 

	SELECT @@IDENTITY;




CREATE PROCEDURE [dbo].[sp_JobInterview_JobCompanyID_get]
	@JobCompanyID			INT
AS
	
	
	SELECT 
		a.*, 
		b.State, 
		JobInterviewClientName = 
			(SELECT JobCompanyName FROM JobCompany WHERE JobCompanyID = a.JobInterviewClientID), 
		JobInterviewContactName = 
			(SELECT JobCompanyClientName =  
				CASE 
					WHEN JobCompanyContactFirstName <> '' AND JobCompanyContactLastName = '' THEN
						JobCompanyContactFirstName
					WHEN JobCompanyContactFirstName = '' AND JobCompanyContactLastName <> '' THEN
						JobCompanyContactLastName
					ELSE
						JobCompanyContactLastName + ', ' + JobCompanyContactFirstName
				END
			FROM 
				JobCompanyContact
			WHERE 
				JobCompanyContactID = a.JobInterviewClientContactID), 
		TotalInterviews = 
			(SELECT COUNT(*) FROM JobInterview WHERE JobCompanyID = @JobCompanyID) 
	FROM 
		JobInterview a, 
		States b 
	WHERE 
		a.StateID = b.StateID AND 
		a.JobCompanyID = @JobCompanyID 
	ORDER BY create_dt




CREATE PROCEDURE [dbo].[sp_JobInterviewType_get]
AS


	SELECT
		JobInterviewTypeID,
		JobInterviewType
	FROM
		JobInterviewType
	ORDER BY
		JobInterviewType;
	




CREATE PROCEDURE [dbo].[sp_JobPhoneCall_insert]
	@JobCompanyID		INT,
	@JobPhoneCallDateTime		DATETIME,
	@JobPhoneCallPhoneNumber	VARCHAR(50),
	@JobPhoneCallNotes		VARCHAR(MAX)
AS
	
	
	INSERT INTO JobPhoneCall 
		(JobCompanyID, JobPhoneCallDateTime, JobPhoneCallPhoneNumber, JobPhoneCallNotes) 
	VALUES
		(@JobCompanyID, @JobPhoneCallDateTime, dbo.fn_FormatPhoneNumber(@JobPhoneCallPhoneNumber), @JobPhoneCallNotes) 

	SELECT @@IDENTITY;



CREATE PROCEDURE [dbo].[sp_JobQueue_count_get]
	@UserID				INT
AS

	SELECT 
		COUNT(*)
	FROM
		JobCompany a,
		JobCompanyContact b,
		Jobs c,
		JobQueue d
	WHERE
		a.JobCompanyID = b.JobCompanyID AND
		b.JobCompanyContactID = c.JobCompanyContactID AND
		c.JobID = d.JobID AND
		a.UserID = @UserID;





CREATE PROCEDURE [dbo].[sp_JobQueue_delete]
	@JobQueueID		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM JobQueue WHERE JobQueueID = @JobQueueID;
END





CREATE PROCEDURE [dbo].[sp_JobQueue_get]
	@UserID				INT
AS

	SELECT TOP 20 
		b.JobCompanyContactID,
		a.JobCompanyID,
		c.JobID,
		Created = b.create_dt,
		a.JobCompanyName,
		JobCompanyContactName = 
			CASE 
				WHEN b.JobCompanyContactFirstName <> '' AND b.JobCompanyContactLastName = '' THEN
					b.JobCompanyContactFirstName
				WHEN b.JobCompanyContactFirstName = '' AND b.JobCompanyContactLastName <> '' THEN
					b.JobCompanyContactLastName
				ELSE
					b.JobCompanyContactLastName + ', ' + b.JobCompanyContactFirstName
			END,
		c.JobPosition
	FROM
		JobCompany a,
		JobCompanyContact b,
		Jobs c,
		JobQueue d
	WHERE
		a.JobCompanyID = b.JobCompanyID AND
		b.JobCompanyContactID = c.JobCompanyContactID AND
		c.JobID = d.JobID AND
		a.UserID = @UserID
	ORDER BY
		b.create_dt DESC;






CREATE PROCEDURE [dbo].[sp_JobQueue_New_get]
	@UserID				INT
AS

	SELECT TOP 20 
		d.JobQueueID,
		b.JobCompanyContactID,
		a.JobCompanyID,
		c.JobID,
		Created = b.create_dt,
		a.JobCompanyName,
		JobCompanyContactName = 
			CASE 
				WHEN b.JobCompanyContactFirstName <> '' AND b.JobCompanyContactLastName = '' THEN
					b.JobCompanyContactFirstName
				WHEN b.JobCompanyContactFirstName = '' AND b.JobCompanyContactLastName <> '' THEN
					b.JobCompanyContactLastName
				ELSE
					b.JobCompanyContactLastName + ', ' + b.JobCompanyContactFirstName
			END,
		c.JobPosition,
		TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = a.JobCompanyID),
		TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = a.JobCompanyID),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyContactID = b.JobCompanyID)
	FROM
		JobCompany a,
		JobCompanyContact b,
		Jobs c,
		JobQueue d
	WHERE
		a.JobCompanyID = b.JobCompanyID AND
		b.JobCompanyContactID = c.JobCompanyContactID AND
		c.JobID = d.JobID AND
		a.UserID = @UserID
	ORDER BY
		b.create_dt DESC;






CREATE PROCEDURE [dbo].[sp_JobQueue_SubmitResume_JobID_get]
	@JobID				INT
AS

	SELECT
		b.JobPosition,
		JobCompanyContactName = 
			CASE 
				WHEN c.JobCompanyContactFirstName <> '' AND c.JobCompanyContactLastName = '' THEN
					c.JobCompanyContactFirstName
				WHEN c.JobCompanyContactFirstName = '' AND c.JobCompanyContactLastName <> '' THEN
					c.JobCompanyContactLastName
				ELSE
					c.JobCompanyContactLastName + ', ' + c.JobCompanyContactFirstName
			END,
		c.JobCompanyContactEmail
	FROM
		JobQueue a,
		Jobs b,
		JobCompanyContact c
	WHERE
		a.JobID = b.JobID
		AND a.JobID = @JobID
		AND b.JobCompanyContactID = c.JobCompanyContactID;
			



CREATE PROCEDURE [dbo].[sp_Jobs_get]
	@JobCompanyID				INT
AS

	SELECT 
		a.*, 
		JobCompanyContactName = 
			CASE 
				WHEN b.JobCompanyContactFirstName <> '' AND b.JobCompanyContactLastName = '' THEN
					b.JobCompanyContactFirstName
				WHEN b.JobCompanyContactFirstName = '' AND b.JobCompanyContactLastName <> '' THEN
					b.JobCompanyContactLastName
				ELSE
					b.JobCompanyContactLastName + ', ' + b.JobCompanyContactFirstName
			END,
		JobStateName = (SELECT State FROM States WHERE StateID = a.JobStateID),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = @JobCompanyID) 
	FROM 
		Jobs a, 
		JobCompanyContact b 
	WHERE 
		a.JobCompanyContactID = b. JobCompanyContactID AND 
		a.JobCompanyID = @JobCompanyID
	ORDER BY 
		a.create_dt DESC;





CREATE PROCEDURE [dbo].[sp_Jobs_insert]
	@JobCompanyID			INT, 
	@JobCompanyContactID		INT, 
	@JobSalaryTypeID		INT,
	@JobDate			DATETIME, 
	@JobPosition			VARCHAR(500), 
	@JobSalary			NUMERIC(9,2),
	@JobClient			VARCHAR(100),
	@JobCity			VARCHAR(30),
	@JobStateID			INT,
	@JobRequirements		VARCHAR(MAX), 	
	@JobNotes			VARCHAR(MAX)
AS
	
	BEGIN TRANSACTION transJobsInsert

		INSERT INTO Jobs
			(JobCompanyID, JobCompanyContactID, JobSalaryTypeID, JobDate, JobPosition, JobSalary, JobClient, JobCity, JobStateID, JobRequirements, JobNotes)
		VALUES
			(@JobCompanyID, @JobCompanyContactID, @JobSalaryTypeID, @JobDate, @JobPosition, @JobSalary, @JobClient, @JobCity, @JobStateID, @JobRequirements, @JobNotes);

		DECLARE @JobID 		INT;
		SET @JobID = @@IDENTITY;

		INSERT INTO JobQueue
			(JobID)
		VALUES
			(@JobID);

		SELECT @JobID;

	IF @@ERROR <> 0 
		ROLLBACK TRANSACTION transJobsInsert;
	ELSE
		COMMIT TRANSACTION transJobsInsert;




CREATE PROCEDURE [dbo].[sp_Jobs_JobCompanyID_get]
	@JobCompanyID				INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		*,
		JobStateName = (SELECT State FROM States WHERE StateID = Jobs.JobStateID)
	FROM
		Jobs
	WHERE
		JobCompanyID = @JobCompanyID
	ORDER BY 
		JobDate DESC;

END





CREATE PROCEDURE [dbo].[sp_Jobs_New_get]
	@UserID				INT
AS

	SELECT TOP 20 
		b.JobCompanyContactID,
		a.JobCompanyID,
		c.JobID,
		Created = b.create_dt,
		a.JobCompanyName,
		JobCompanyContactName = 
			CASE 
				WHEN b.JobCompanyContactFirstName <> '' AND b.JobCompanyContactLastName = '' THEN
					b.JobCompanyContactFirstName
				WHEN b.JobCompanyContactFirstName = '' AND b.JobCompanyContactLastName <> '' THEN
					b.JobCompanyContactLastName
				ELSE
					b.JobCompanyContactLastName + ', ' + b.JobCompanyContactFirstName
			END,
		c.JobPosition,
		TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = a.JobCompanyID),
		TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = a.JobCompanyID),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyContactID = b.JobCompanyID)
	FROM
		JobCompany a,
		JobCompanyContact b,
		Jobs c
	WHERE
		a.JobCompanyID = b.JobCompanyID AND
		b.JobCompanyContactID = c.JobCompanyContactID AND
		a.UserID = @UserID
	ORDER BY
		b.create_dt DESC;







CREATE PROCEDURE [dbo].[sp_JobSalaryType_get]
AS


	SELECT
		JobSalaryTypeID,
		JobSalaryType
	FROM
		JobSalaryType
	ORDER BY
		JobSalaryType;
	


CREATE PROCEDURE [dbo].[sp_Logins_insert]
	@UserID		INT,
	@Browser	VARCHAR(100),
	@IPAddress	VARCHAR(15)
AS
	INSERT INTO Logins (UserID, Browser, IPAddress) VALUES (@UserID, @Browser, @IPAddress);


CREATE PROCEDURE [dbo].[sp_Logins_LoginDate]
	@LoginDate		SMALLDATETIME
AS

	SELECT
		a.LoginDate, b.UserName, a.Browser, a.IPAddress 
	FROM 
		Logins a, Users b 
	WHERE 
		a.UserID = b.UserID AND 
		DATEPART(day, LoginDate) = DAY(@LoginDate) AND
		DATEPART(month, LoginDate) = MONTH(@LoginDate) AND
		DATEPART(year, LoginDate) = YEAR(@LoginDate)
	ORDER BY 
		a.LoginDate DESC




CREATE PROCEDURE [dbo].[sp_Logs_insert]
	@ApplicationName	VARCHAR(1000),
	@LogDesc		VARCHAR(MAX)
AS
	INSERT INTO Logs
		(ApplicationName, LogDesc) 
	VALUES 
		(@ApplicationName, @LogDesc);



CREATE PROCEDURE [dbo].[sp_Logs_LogDate]
	@LogDate		SMALLDATETIME
AS
	SELECT
		LogDate = create_dt, LogDesc
	FROM
		Logs
	WHERE 
		DATEPART(day, create_dt) = DAY(@LogDate) AND
		DATEPART(month, create_dt) = MONTH(@LogDate) AND
		DATEPART(year, create_dt) = YEAR(@LogDate)
	ORDER BY 
		create_dt DESC



CREATE PROCEDURE [dbo].[sp_Medicine_insert] 
	@UserID				INT,
	@MedicineName 			VARCHAR(50),
	@GenericName 			VARCHAR(50),
	@PrescriptionNumber		VARCHAR(30), 
	@UnitID				INT,
	@MedicineDescription		VARCHAR(MAX)
AS
	
	INSERT INTO Medicine 
		(UserID, MedicineName, GenericName, PrescriptionNumber, UnitID, MedicineDescription)
	VALUES
		(@UserID, @MedicineName, @GenericName, @PrescriptionNumber, @UnitID, @MedicineDescription)

	SELECT @@IDENTITY;




CREATE PROCEDURE [dbo].[sp_Medicine_Last_100_get]
	@UserID			INT = NULL
AS
	
	SELECT TOP 100 
		MedicineDateTime = a.MedicineDoseDateTime,
		b.MedicineName, 
		b.GenericName, 
		MedicineAmount = CONVERT(VARCHAR, a.Amount) + ' ' + c.UnitName , a.*, MedicineDoseAmount = CONVERT(VARCHAR, a.Amount) + ' ' + c.UnitName  
	INTO
		#Medicine
	FROM 
		MedicineDose a, 
		Medicine b, 
		Unit c 
	WHERE 
		a.MedicineID = b.MedicineID 
		AND b.UnitID = c.UnitID 
		AND b.UserID = @UserID;
	
	SELECT TOP 100
		MedicineDateTime = SugarDateTime,
		MedicineName = '', 
		GenericName = 'SUGAR', 
		MedicineAmount = CONVERT(VARCHAR, Sugar)
	INTO
		#Medicine2
	FROM Sugar  

	SELECT * INTO #Medicine3 FROM #Medicine2;

	TRUNCATE TABLE #Medicine3;

	INSERT INTO #Medicine3
	(
		MedicineDateTime,
		MedicineName, 
		GenericName, 
		MedicineAmount)

		SELECT
			MedicineDateTime,
			MedicineName, 
			GenericName, 
			MedicineAmount
		FROM
			#Medicine
		UNION

		SELECT
			MedicineDateTime,
			MedicineName, 
			GenericName, 
			MedicineAmount
		FROM
			#Medicine2;
		

	SELECT 
		* 
	FROM 
		#Medicine3
	ORDER BY
		MedicineDateTime DESC;



CREATE PROCEDURE [dbo].[sp_Medicine_update] 
	@MedicineID			INT,
	@MedicineName 			VARCHAR(50),
	@GenericName 			VARCHAR(50),
	@PrescriptionNumber		VARCHAR(30), 
	@UnitID				INT,
	@MedicineDescription		VARCHAR(MAX)
AS
	
	UPDATE Medicine SET
		MedicineName = @MedicineName, 
		GenericName = @GenericName, 
		PrescriptionNumber = @PrescriptionNumber, 
		UnitID = @UnitID, 
		MedicineDescription = @MedicineDescription
	WHERE
		MedicineID = @MedicineID;





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Medicine_UserID_get]
	@UserID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		MedicineID,
		Medicine =
			CASE 
				WHEN GenericName <> '' THEN
					MedicineName + ' (' + GenericName + ')'
				ELSE
					MedicineName
			END,
		MedicineName,
		GenericName,
		TotalMedicine = (SELECT COUNT(*) FROM Medicine WHERE UserID = @UserID)
	FROM
		Medicine
	WHERE
		UserID = @UserID
	ORDER BY
		MedicineName
	
		
END




CREATE PROCEDURE [dbo].[sp_MedicineDose_insert]
	@MedicineDoseDateTime		DATETIME, 
	@MedicineID			INT, 
	@Amount				NUMERIC(9,2), 
	@MedicineDoseDescription		varchar(2000) 
AS
	
	INSERT INTO MedicineDose
		(MedicineDoseDateTime, MedicineID, Amount, MedicineDoseDescription)
	VALUES
		(@MedicineDoseDateTime, @MedicineID, @Amount, @MedicineDoseDescription)

	SELECT @@IDENTITY;





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MedicineDose_MedicineDosePackage_insert]
	@MedicineDosePackageID		INT,
	@MedicineDoseDateTime		DATETIME
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO MedicineDose
		(MedicineID, MedicineDoseDateTime, Amount, MedicineDoseDescription)

	SELECT 
		b.MedicineID, 
		MedicineDoseDateTime = @MedicineDoseDateTime, 
		b.Amount, 
		b.Description AS MedicineDoseDescription
	FROM 
		MedicineDosePackage a, 
		MedicineDosePackageItem b 
	WHERE 
		a.MedicineDosePackageID = b.MedicineDosePackageID AND 
		a.MedicineDosePackageID = @MedicineDosePackageID;
	

		
END



CREATE PROCEDURE sp_MedicineDose_update 
	@MedicineDoseID					INT,
	@MedicineDoseDateTime				DATETIME,
	@MedicineID					INT,
	@Amount						NUMERIC(9,2),
	@MedicineDoseDescription			VARCHAR(2000)
AS
	
	UPDATE MedicineDose SET
		MedicineDoseDateTime = @MedicineDoseDateTime,
		MedicineID = @MedicineID,		
		Amount = @Amount,
		MedicineDoseDescription = @MedicineDoseDescription
	WHERE
		MedicineDoseID =  @MedicineDoseID;					





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MedicineDosePackage_insert]
	@UserID				INT,
	@MedicineDosePackageName	VARCHAR(100)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO MedicineDosePackage
		(UserID, MedicineDosePackageName)
	VALUES
		(@UserID, @MedicineDosePackageName);

	SELECT @@IDENTITY;
		
END





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MedicineDosePackage_MedicineDosePackageID_get]
	@MedicineDosePackageID		INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		a.MedicineDosePackageItemID,
		a.MedicineID, 
		Medicine =
			CASE 
				WHEN b.GenericName <> '' THEN
					b.MedicineName + ' (' + b.GenericName + ')'
				ELSE
					b.MedicineName
			END,
		a.Amount, 
		a.Description 
	FROM 
		MedicineDosePackageItem a, 
		Medicine b
	WHERE 
		a.MedicineID = b.MedicineID AND 
		a.MedicineDosePackageID = @MedicineDosePackageID
	ORDER BY
		Medicine;
	

		
END




CREATE PROCEDURE [dbo].[sp_MedicineDosePackage_update] 
	@MedicineDosePackageID			INT,
	@MedicineDosePackageName		VARCHAR(100)
AS
	
	UPDATE MedicineDosePackage SET
		MedicineDosePackageName = @MedicineDosePackageName
	WHERE 
		MedicineDosePackageID = @MedicineDosePackageID;




CREATE PROCEDURE [dbo].[sp_MedicineDosePackageItem_delete] 
	@MedicineDosePackageItemID			INT
AS
	
	DELETE FROM MedicineDosePackageItem WHERE MedicineDosePackageItemID = @MedicineDosePackageItemID;




CREATE PROCEDURE [dbo].[sp_MedicineDosePackageItem_insert] 
	@MedicineDosePackageID				INT,
	@MedicineID					INT,
	@Amount						NUMERIC(9,2),
	@Description					varchar(200)
AS
	
	INSERT INTO MedicineDosePackageItem
		(MedicineDosePackageID, MedicineID, Amount, Description)
	VALUES
		(@MedicineDosePackageID, @MedicineID, @Amount, @Description)

	SELECT @@IDENTITY;




CREATE PROCEDURE [dbo].[sp_MedicineDosePackageItem_update] 
	@MedicineDosePackageItemID				INT,
	@Amount							NUMERIC(9,2),
	@Description						VARCHAR(200)
AS
	
	UPDATE MedicineDosePackageItem SET
		Amount = @Amount,
		Description = @Description
	WHERE
		MedicineDosePackageItemID = @MedicineDosePackageItemID;





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MedicinePackageItems_NotUsed_get]
	@MedicineDosePackageID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		MedicineID,
		MedicineName =
			CASE 
				WHEN GenericName <> '' THEN
					MedicineName + ' (' + GenericName + ')'
				ELSE
					MedicineName
			END
	FROM
		Medicine
	WHERE
		MedicineID NOT IN (
			SELECT 
				MedicineID 
			FROM 
				MedicineDosePackageItem 
			WHERE 
				MedicineDosePackageID = @MedicineDosePackageID
		)
	ORDER BY
		MedicineName
	
		
END




CREATE PROCEDURE [dbo].[sp_MedicineRefill_insert] 
	@MedicineID				INT, 
	@DoctorID				INT, 
	@PharmacyID				INT, 
	@RefillOrderDate			DATETIME, 
	@RefillOrderPickupDate			DATETIME, 
	@RefillDateFilled			DATETIME, 
	@RefillAmount				NUMERIC(9,2), 
	@DailyAmount				NUMERIC(9,2), 
	@RefillTimes				INT, 
	@RefillUntilDate			DATETIME, 
	@RefillDiscardDate			DATETIME, 
	@RefillDescription			VARCHAR(5000)
AS
	
	INSERT INTO MedicineRefill
		(MedicineID, DoctorID, PharmacyID, RefillOrderDate, RefillOrderPickupDate, RefillDateFilled, RefillAmount, DailyAmount, RefillTimes, RefillUntilDate, RefillDiscardDate, RefillDescription)
	VALUES
		(@MedicineID, @DoctorID, @PharmacyID, @RefillOrderDate, @RefillOrderPickupDate, @RefillDateFilled, @RefillAmount, @DailyAmount, @RefillTimes, @RefillUntilDate, @RefillDiscardDate, @RefillDescription)

	SELECT @@IDENTITY;




 CREATE PROCEDURE [dbo].[sp_MedicineRefill_update] 
	@MedicineRefillID				INT,
	@MedicineID				INT, 
	@DoctorID				INT, 
	@PharmacyID				INT, 
	@RefillOrderDate			DATETIME, 
	@RefillOrderPickupDate			DATETIME, 
	@RefillDateFilled			DATETIME, 
	@RefillAmount				NUMERIC(9,2), 
	@DailyAmount				NUMERIC(9,2), 
	@RefillTimes				INT, 
	@RefillUntilDate			DATETIME, 
	@RefillDiscardDate			DATETIME, 
	@RefillDescription			VARCHAR(5000)
AS
	
	UPDATE MedicineRefill SET
		MedicineID = @MedicineID, 
		DoctorID = @DoctorID, 
		PharmacyID = @PharmacyID, 
		RefillOrderDate = @RefillOrderDate, 
		RefillOrderPickupDate = @RefillOrderPickupDate, 
		RefillDateFilled = @RefillDateFilled, 
		RefillAmount = @RefillAmount,
		DailyAmount = @DailyAmount, 
		RefillTimes = @RefillTimes, 
		RefillUntilDate = @RefillUntilDate, 
		RefillDiscardDate = @RefillDiscardDate, 
		RefillDescription = @RefillDescription
	WHERE
		MedicineRefillID = @MedicineRefillID;





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MedicineRefill_UserID_get]
	@UserID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		MedicineRefillID,
		a.MedicineID,
		Medicine =
			CASE 
				WHEN b.GenericName <> '' THEN
					b.MedicineName + ' (' + b.GenericName + ')'
				ELSE
					b.MedicineName
			END,
		NextRefillDate = DATEADD(DAY, RefillAmount / DailyAmount, RefillDateFilled),
		DoctorName = (
				SELECT
					CASE 
						WHEN FirstName <> '' THEN
							LastName + ', ' + FirstName
						ELSE
							LastName
					END
				FROM
					Doctor
				WHERE 
					DoctorID = a..DoctorID
			    ),
		PharmacyName = (SELECT PharmacyName FROM Pharmacy WHERE PharmacyID = a.PharmacyID),
		b.PrescriptionNumber,
		a.RefillOrderDate,
		a.RefillOrderPickupDate,
		a.RefillDateFilled,
		RefillAmount = CONVERT(VARCHAR, a.RefillAmount) + ' ' + c.UnitName,
		a.DailyAmount,
		a.RefillTimes,
		a.RefillUntilDate,
		a.RefillDiscardDate,
		a.RefillDescription
	FROM
		MedicineRefill a,
		Medicine b,
		Unit c
	WHERE
		a.MedicineID = b.MedicineID AND
		b.UnitID = c.UnitID AND
		b.UserID = @UserID
	ORDER BY
		a.RefillOrderPickupDate
	DESC;
	
		
END



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MonthlyBills_delete]
	@MonthlyBillID			INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM MonthlyBills WHERE
		MonthlyBillID = @MonthlyBillID;
END


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MonthlyBills_get]
	@BankingAccountID		INT,
	@MonthlyBillID			INT = NULL
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF @MonthlyBillID IS NULL
		BEGIN
			SELECT * FROM MonthlyBills WHERE BankingAccountID = @BankingAccountID ORDER BY MonthlyBillDate
		END
	ELSE
		SELECT * FROM MonthlyBills WHERE MonthlyBillID = @MonthlyBillID
		-- Insert statements for procedure here
END


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MonthlyBills_insert]
	@BankingAccountID		INT,
	@MonthlyBillStartDate		SMALLDATETIME,
	@MonthlyBillDate		SMALLDATETIME,
	@MonthlyBillDesc		VARCHAR(100),
	@MonthlyBillAmount		NUMERIC(9,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO MonthlyBills
		(BankingAccountID, MonthlyBillStartDate, MonthlyBillDate, MonthlyBillDesc, MonthlyBillAmount)
	VALUES
		(@BankingAccountID, @MonthlyBillStartDate, @MonthlyBillDate, @MonthlyBillDesc, @MonthlyBillAmount)
		
END


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MonthlyBills_update]
	@MonthlyBillID			INT,
	@MonthlyBillStartDate	SMALLDATETIME,
	@MonthlyBillDate		SMALLDATETIME,
	@MonthlyBillDesc		VARCHAR(100),
	@MonthlyBillAmount		NUMERIC(9,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE MonthlyBills SET
		MonthlyBillStartDate = @MonthlyBillStartDate,
		MonthlyBillDate = @MonthlyBillDate,
		MonthlyBillDesc = @MonthlyBillDesc,
		MonthlyBillAmount = @MonthlyBillAmount
	WHERE
		MonthlyBillID = @MonthlyBillID;
END




CREATE PROCEDURE [dbo].[sp_Notes_insert]
	@UserID				INT,
	@NoteName		VARCHAR(100),
	@NoteText		VARCHAR(MAX)
AS
	
	
	INSERT INTO Notes
		(UserID, NoteName, NoteText)
	VALUES
		(@UserID, @NoteName, @NoteText);


	SELECT @@IDENTITY;


CREATE PROCEDURE [dbo].[sp_PageLogs_create_dt_get]
	@create_dt	DATETIME = GETDATE,
	@UserID	INT = NULL
AS

	DECLARE @SQL	NVARCHAR(1000);

	SET @SQL = '';
	SET @SQL = @SQL + 'SELECT ';
	SET @SQL = @SQL + 'TOP 100 ';
	SET @SQL = @SQL + 'a.PageLogID, ';
	SET @SQL = @SQL + 'a.Template, ';
	SET @SQL = @SQL + 'a.Action, ';
	SET @SQL = @SQL + 'a.QUERY_STRING, ';
	SET @SQL = @SQL + 'a.FORM, ';
	SET @SQL = @SQL + 'FullName = b.FirstName + '' '' + b.LastName, ';
	SET @SQL = @SQL + 'a.SCRIPT_NAME, ';
	SET @SQL = @SQL + 'a.create_dt ';
	SET @SQL = @SQL + 'FROM ';
	SET @SQL = @SQL + 'PageLogs a, ';
	SET @SQL = @SQL + 'Users b ';
	SET @SQL = @SQL + 'WHERE ';
	SET @SQL = @SQL + 'a.UserID = b.UserID AND ';
	SET @SQL = @SQL + 'DATEPART(month, a.create_dt) = DATEPART(month, ''' + CONVERT(VARCHAR, @create_dt) + ''') AND ';
	SET @SQL = @SQL + 'DATEPART(day, a.create_dt) = DATEPART(day, ''' + CONVERT(VARCHAR, @create_dt) + ''') AND '; 
	SET @SQL = @SQL + 'DATEPART(year, a.create_dt) = DATEPART(year, ''' + CONVERT(VARCHAR, @create_dt) + ''') ';
	SET @SQL = @SQL + 'ORDER BY ';
	SET @SQL = @SQL + 'a.create_dt DESC';
	
	--print @SQL;

	--EXEC(@SQL);

	SELECT TOP 100 
		a.PageLogID, 
		a.Template, 
		a.Action, 
		a.QUERY_STRING, 
		a.FORM, 
		FullName = b.FirstName + ' ' + b.LastName, 
		CONVERT(VARCHAR, a.SCRIPT_NAME) AS PageName, 
		a.create_dt 
	FROM 
		PageLogs a, 
		Users b 
	WHERE 
		a.UserID = b.UserID AND 
		--a.create_dt = @create_dt
		DATEPART(month, a.create_dt) = DATEPART(month, @create_dt) AND 
		DATEPART(day, a.create_dt) = DATEPART(day, @create_dt) AND 
		DATEPART(year, a.create_dt) = DATEPART(year, @create_dt) 
	ORDER BY 
		a.create_dt DESC;



CREATE PROCEDURE [dbo].[sp_PageLogs_insert]
	@UserID			INT,
	@SCRIPT_NAME		VARCHAR(255),
	@REQUEST_METHOD		VARCHAR(10),
	@Template		VARCHAR(100),
	@Action			VARCHAR(100),
	@QUERY_STRING		TEXT,
	@FORM			TEXT,
	@PreviousPage		VARCHAR(2000)

AS
	UPDATE Settings SET

		PreviousPage = @PreviousPage
	WHERE
		UserID = @UserID;
	
	INSERT INTO PageLogs
		(UserID, SCRIPT_NAME, REQUEST_METHOD, Template, Action, QUERY_STRING, FORM)
	VALUES
		(@UserID, @SCRIPT_NAME, @REQUEST_METHOD, @Template, @Action, @QUERY_STRING, @FORM)

	SELECT @@IDENTITY;


CREATE PROCEDURE [dbo].[sp_PageLogs_search]
	@Keyword		VARCHAR(100)

AS

	SET @Keyword = '%' + @Keyword + '%';

	SELECT 
		
		FullName = b.FirstName + ' ' + b.LastName,
		a.* 
	FROM 
		PageLogs a,
		Users b
	WHERE
		a.UserID = b.UserID AND
		(UPPER(QUERY_STRING) LIKE UPPER(@Keyword) OR 
		UPPER(FORM) LIKE UPPER(@Keyword))
	ORDER BY 
		a.create_dt DESC;




CREATE PROCEDURE [dbo].[sp_PageLogs_UserID_get]
AS

	DECLARE @create_dt 	DATETIME
	SET @create_dt = GETDATE();

	SELECT 
		UserID = '',
		FullName = 'ALL USERS'
	UNION 
	SELECT
		DISTINCT (a.UserID),
		FullName = b.FirstName + ' ' + b.LastName
	FROM
		PageLogs a,
		Users b
	WHERE
		a.UserID = b.UserID AND
		DATEPART(month, a.create_dt) = DATEPART(month, @create_dt) AND
		DATEPART(day, a.create_dt) = DATEPART(day, @create_dt) AND 
		DATEPART(year, a.create_dt) = DATEPART(year, @create_dt)



CREATE PROCEDURE [dbo].[sp_Paychecks_CompanyID]
	@TimesheetCompanyID		INT,
	@PaymentYear		INT
AS
	SELECT 
		Gross = SUM(Gross), 
		Federal = SUM(Federal), 
		SocialSecurity = SUM(SocialSecurity), 
		Medicare = SUM(Medicare), 
		NY_Withholding = SUM(NY_Withholding), 
		NY_Disability = SUM(NY_Disability), 
		NY_City = SUM(NY_City) 
	FROM 
		Paychecks 
	WHERE 
		TimesheetCompanyID = @TimesheetCompanyID AND
		DATEPART(YEAR, PaymentDate) = @PaymentYear


CREATE PROCEDURE [dbo].[sp_Paychecks_PaycheckID]
	@PaycheckID		INT 
AS
	SELECT 
		TimesheetCompanyID, 
		PaymentDate, 
		HourlyRate, 
		Gross, 
		Federal, 
		SocialSecurity, 
		Medicare, 
		NY_Withholding, 
		NY_Disability, 
		NY_City 
	FROM 
		Paychecks 
	WHERE 
		PaycheckID = @PaycheckID


CREATE PROCEDURE [dbo].[sp_Paychecks_UserID]
	@UserID			INT,
	@PaymentYear		INT 
AS
	SELECT 
		b.PaycheckID, 
		b.PaymentDate, 
		b.TimesheetCompanyID, 
		a.CompanyName, 
		Gross, 
		Net = (b.Gross - (b.Federal + b.SocialSecurity + b.Medicare + b.NY_Withholding + b.NY_Disability + b.NY_City)), 
                HourlyRate, 
                Hours = (Gross / HourlyRate),
                TotalRecords = (SELECT COUNT(*) FROM Companies a, Paychecks b WHERE a.CompanyID = b.TimesheetCompanyID AND a.UserID = @UserID AND DATEPART(year, b.PaymentDate) = @PaymentYear) 
	FROM 
		Companies a, 
		Paychecks b 
	WHERE 
		a.CompanyID = b.TimesheetCompanyID AND 
		a.UserID = @UserID AND 
		DATEPART(year, b.PaymentDate) = @PaymentYear 
	ORDER BY  
		b.PaymentDate DESC, 
		b.TimesheetCompanyID


CREATE PROCEDURE [dbo].[sp_Paychecks_UserID_PaycheckDate]
	@UserID			INT,
	@PaycheckDate		SMALLDATETIME
AS
	SELECT 
		a.PaycheckID,
		a.PaymentDate AS PaycheckDate, 
		a.Gross
	FROM 
		Paychecks a,
		Companies b
	WHERE 
		a.TimesheetCompanyID = b.CompanyID AND
		b.UserID = @UserID AND
		DATEPART(month, a.PaymentDate) = MONTH(@PaycheckDate) AND
		DATEPART(year, a.PaymentDate) = YEAR(@PaycheckDate) 
	ORDER BY 
		a.PaymentDate


CREATE PROCEDURE [dbo].[sp_Paychecks_UserID_PaycheckDate_total]
	@UserID			INT,
	@PaymentYear		INT
AS
	SELECT 
		Gross = SUM(a.Gross), 
		Federal = SUM(a.Federal), 
		SocialSecurity = SUM(a.SocialSecurity), 
		Medicare = SUM(a.Medicare), 
		NY_Withholding = SUM(a.NY_Withholding), 
		NY_Disability = SUM(a.NY_Disability), 
		NY_City = SUM(a.NY_City) 
	FROM 
		Paychecks a,
		Companies b
	WHERE 
		a.TimesheetCompanyID = b.CompanyID AND
		b.UserID = @UserID AND
		DATEPART(YEAR, PaymentDate) = @PaymentYear


CREATE PROCEDURE [dbo].[sp_PersonalDays_CompanyID_PersonalDate]
	@CompanyID	INT,
	@PersonalDate	SMALLDATETIME
AS
	SELECT 
		PersonalDayID 
	FROM 
		PersonalDays 
	WHERE 
		CompanyID = @CompanyID AND 
		PersonalDate = @PersonalDate


CREATE PROCEDURE [dbo].[sp_PersonalDays_insert]
	@CompanyID	INT,
	@PersonalDate	SMALLDATETIME
AS
	INSERT INTO Personaldays 
		(CompanyID, PersonalDate) 
	VALUES 
		(@CompanyID, @PersonalDate);


CREATE PROCEDURE [dbo].[sp_PersonalDays_PersonalDayID_get]
	@PersonalDayID		INT
AS
	SELECT 
		a.PersonalDayID,
		a.CompanyID, 
		b.CompanyName,
		a.PersonalDate 
	FROM 
		Personaldays a,
		Companies b
	WHERE 
		a.CompanyID = b.CompanyID AND
		a.PersonalDayID = @PersonalDayID


CREATE PROCEDURE [dbo].[sp_PersonalDays_update]
	@PersonalDayID	INT,
	@CompanyID	INT,
	@PersonalDate	SMALLDATETIME
AS
	UPDATE Personaldays SET
		CompanyID = @CompanyID,
		PersonalDate = @PersonalDate
	WHERE
		PersonalDayID = @PersonalDayID;	


CREATE PROCEDURE [dbo].[sp_PersonalDays_UserID_get]
	@UserID		INT
AS
	SELECT 
		a.PersonalDayID,
		b.CompanyID, 
		b.CompanyName, 
		a.PersonalDate 
	FROM 
		Personaldays a, 
		Companies b 
	WHERE 
		a.CompanyID = b.CompanyID AND 
		b.UserID = @UserID
	ORDER BY 
		a.PersonalDate DESC, 
		b.CompanyName




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_PersonalInformation_get]
	@UserID				INT,
	@Letter				VARCHAR(3) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 IF @Letter IS NOT NULL
		SET @Letter = @Letter + '%';

	 IF @Letter IS NOT NULL
		BEGIN
		 IF @Letter = 'ALL'
			SELECT * FROM PersonalInformation WHERE UserID = @UserID AND Active = 1 ORDER BY AccountName;
		 ELSE
			SELECT * FROM PersonalInformation WHERE UserID = @UserID AND LEFT(AccountName, 1) LIKE @Letter AND Active = 1 ORDER BY AccountName;
		END
	ELSE
		SELECT * FROM PersonalInformation WHERE UserID = @UserID  AND Active = 1 ORDER BY AccountName;

END





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_PersonalInformation_PersonalInformationID_get]
	@PersonalInformationID				INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT * FROM PersonalInformation WHERE PersonalInformationID = @PersonalInformationID;

END






CREATE PROCEDURE [dbo].[sp_Pharmacy_insert]
	@UserID				INT,
	@PharmacyName 			VARCHAR(100),
	@PharmacyAddress        	VARCHAR(100),
	@PharmacyCity			VARCHAR(50), 
	@PharmacyStateID		INT,
	@PharmacyZipCode		VARCHAR(20), 
	@PharmacyTelephoneNumber 	VARCHAR(20)
AS
	
	INSERT INTO Pharmacy 
		(UserID, PharmacyName, PharmacyAddress, PharmacyCity, PharmacyStateID, PharmacyZipCode, PharmacyTelephoneNumber)
	VALUES
		(@UserID, @PharmacyName, @PharmacyAddress, @PharmacyCity, @PharmacyStateID, @PharmacyZipCode, dbo.fn_FormatPhoneNumber(@PharmacyTelephoneNumber));

	SELECT @@IDENTITY;




CREATE PROCEDURE [dbo].[sp_Pharmacy_update]
	@PharmacyID			INT,
	@PharmacyName 			VARCHAR(100),
	@PharmacyAddress        	VARCHAR(100),
	@PharmacyCity			VARCHAR(50), 
	@PharmacyStateID		INT,
	@PharmacyZipCode		VARCHAR(20), 
	@PharmacyTelephoneNumber 	VARCHAR(20)
AS
	
	UPDATE Pharmacy SET
		PharmacyName = @PharmacyName,
		PharmacyAddress = @PharmacyAddress,
		PharmacyCity = @PharmacyCity,
		PharmacyStateID = @PharmacyStateID,
		@PharmacyZipCode = @PharmacyZipCode,
		PharmacyTelephoneNumber = dbo.fn_FormatPhoneNumber(@PharmacyTelephoneNumber)
	WHERE
		PharmacyID = @PharmacyID;




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Pharmacy_UserID_get]
	@UserID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		PharmacyID,
		PharmacyName,
		PharmacyAddress,
		PharmacyCity,
		PharmacyStateID,
		PharmacyState = (SELECT State FROM States WHERE StateID = Pharmacy.PharmacyStateID),
		PharmacyTelephoneNumber,
		TotalPharmacys = (SELECT COUNT(*) FROM Pharmacy WHERE UserID = @UserID)
	FROM
		Pharmacy
	WHERE
		UserID = @UserID
	ORDER BY
		PharmacyName
	
		
END




CREATE PROCEDURE [dbo].[sp_POP3Email_get]
	@POP3EmailID		INT = NULL

AS

	IF @POP3EmailID IS NOT NULL
		BEGIN
		
			SELECT
				*
			FROM
				POP3Email
			WHERE
				POP3EmailID = @POP3EmailID
		END
	ELSE
		BEGIN
		
			SELECT
				*
			FROM
				POP3Email
			ORDER BY 
				create_dt DESC;
		END



CREATE PROCEDURE [dbo].[sp_POP3Email_insert]
	@POP3EmailFolderID		INT,
	@POP3EmailMessageID		VARCHAR(100),
	@POP3EmailMessageDateTime	DATETIME,
	@POP3EmailFromName		VARCHAR(500),
	@POP3EmailFromEmail		VARCHAR(500),
	@POP3EmailSubject		VARCHAR(500),
	@POP3EmailBodyText		VARCHAR(MAX)
AS

	IF NOT EXISTS (SELECT 1 FROM POP3Email WHERE POP3EmailMessageID = @POP3EmailMessageID) AND
		@POP3EmailMessageID IS NOT NULL
		BEGIN
			INSERT INTO POP3Email
				(POP3EmailFolderID, POP3EmailMessageID, POP3EmailMessageDateTime, POP3EmailFromName, POP3EmailFromEmail, POP3EmailSubject, POP3EmailBodyText)
			VALUES
				(@POP3EmailFolderID, @POP3EmailMessageID, @POP3EmailMessageDateTime, @POP3EmailFromName, @POP3EmailFromEmail, @POP3EmailSubject, @POP3EmailBodyText);
		END




CREATE PROCEDURE [dbo].[sp_Profiler_create_dt_get]
	@create_dt	SMALLDATETIME
AS

	SELECT
		TOP 100 *
	FROM 
		ExecutedSQLScripts 
	WHERE
		DATEPART(day, create_dt) = DATEPART(day, @create_dt) AND
		DATEPART(month, create_dt) = DATEPART(month, @create_dt) AND
		DATEPART(year, create_dt) = DATEPART(year, @create_dt)
	ORDER BY 
		create_dt DESC





CREATE PROCEDURE [dbo].[sp_Profiler_get]
	@ProfilerType		INT = 3
AS

	IF (@ProfilerType = 1)
		BEGIN	

			SELECT TOP 50
				create_dt AS Time,
				ApplicationName AS Application,
				ExecutedSQLScript AS SQL
			FROM
				ExecutedSQLScripts
			ORDER BY
				create_dt 
			DESC;
		
		END

	ELSE IF (@ProfilerType = 2)
		BEGIN	

			SELECT TOP 50
				create_dt AS Time,
				ApplicationName AS Application,
				LogDesc AS [Log]
			FROM
				Logs
			ORDER BY
				create_dt 
			DESC;
		
		END

	ELSE IF (@ProfilerType = 3)
		BEGIN	
			CREATE TABLE #Profiler
			(
				Time		DATETIME NOT NULL,
				[Application]	VARCHAR(1000),
				[SQL/Log]	VARCHAR(1000)
			);

			INSERT INTO #Profiler
				([Time], [Application], [SQL/Log])
				SELECT TOP 50
					create_dt AS Time,
					ApplicationName AS Application,
					LogDesc AS [Log]
				FROM
					Logs
				ORDER BY
					create_dt 
				DESC;
		
			INSERT INTO #Profiler
				([Time], [Application], [SQL/Log])
			SELECT TOP 50
				create_dt AS Time,
				ApplicationName AS Application,
				ExecutedSQLScript AS SQL
			FROM
				ExecutedSQLScripts
			ORDER BY
				create_dt 
			DESC;

			SELECT 
				*
			FROM
				#Profiler
			ORDER BY
				[TIME]
			DESC;
			
		END





CREATE PROCEDURE [dbo].[sp_ReferencedBy_UserID_get]
	@UserID			INT
AS
	
	
	SELECT 
		ReferencedByID, 
		ReferencedByName
	FROM 
		ReferencedBy
	WHERE 
		UserID = @UserID 
	ORDER BY 
		 OrderNum;


CREATE PROCEDURE [dbo].[sp_Reminders_get_ReminderID]
	@UserID		INT,
	@ReminderDate	SMALLDATETIME
AS

	SELECT
		ReminderID
	FROM
		Reminders
	WHERE 
		UserID = @UserID AND
		ReminderDate = @ReminderDate
	ORDER BY
		ReminderDate


CREATE PROCEDURE [dbo].[sp_Reminders_insert]
	@UserID		INT,
	@ReminderDate	SMALLDATETIME,
	@ReminderDesc	VARCHAR(255)
AS

	INSERT INTO Reminders 
		(UserID, ReminderDate, ReminderDesc)
	VALUES
		(@UserID, @ReminderDate, @ReminderDesc);


CREATE PROCEDURE [dbo].[sp_Reminders_update]
	@UserID		INT,
	@ReminderDate	SMALLDATETIME,
	@ReminderDesc	VARCHAR(255)
AS

	UPDATE Reminders
		SET ReminderDesc = @ReminderDesc
	WHERE 
		UserID = @UserID AND
		ReminderDate = @ReminderDate


CREATE PROCEDURE [dbo].[sp_Reminders_UserID_ReminderDate]
	@UserID		INT,
	@ReminderDate	SMALLDATETIME
AS

	SELECT 
		ReminderDate, ReminderDesc
	FROM 
		Reminders 
	WHERE 
		DATEPART(month, ReminderDate) = MONTH(@ReminderDate) AND
		DATEPART(year, ReminderDate) = YEAR(@ReminderDate) AND
		UserID = @UserID
	ORDER BY
		ReminderDate





CREATE PROCEDURE [dbo].[sp_Reports_Jobs_Locations_get]
	@UserID				INT
AS

	SELECT DISTINCT 
		City = JobCity,
		StateID = JobStateID,
		State = 'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS',
		TotalJobs = COUNT(*)
	INTO
		#Jobs
	FROM
		Jobs
	GROUP BY
		JobCity,
		JobStateID
	ORDER BY
		COUNT(*) DESC,
		JobStateID,
		JobCity;
	
	UPDATE #Jobs SET
		State = '';

	UPDATE #Jobs SET
		State = (SELECT State FROM States WHERE StateID = #Jobs.StateID)
	WHERE
		StateID IS NOT NULL;

	SELECT * FROM #Jobs ORDER BY TotalJobs DESC, State, City;
	
	




CREATE PROCEDURE [dbo].[sp_Reports_Sugar_get]
	@UserID				INT,
	@StartDate			DATETIME,
	@EndDate			DATETIME
AS


	SELECT
		SugarDateTime = CONVERT(VARCHAR, CONVERT(DATE, SugarDateTime)),
		Sugar
	FROM
		Sugar
	WHERE
		UserID = @UserID
		AND SugarDateTime BETWEEN @StartDate AND @EndDate
	ORDER BY
		SugarDateTime;
	




CREATE PROCEDURE [dbo].[sp_Reports_Weight_get]
	@UserID				INT
AS


	SELECT TOP 20
		WeightDateTime = CONVERT(VARCHAR, CONVERT(DATE, WeightDateTime)),
		Weight
	FROM
		Weight
	WHERE
		UserID = @UserID
	ORDER BY
		WeightDateTime;
	



CREATE PROCEDURE [dbo].[sp_ResumeDownloads_delete]
	@ResumeDownloadID		INT
AS

	DELETE FROM ResumeDownloads WHERE ResumeDownloadID = @ResumeDownloadID;




CREATE PROCEDURE [dbo].[sp_ResumeDownloads_get]
	@ResumeDownloadID		INT = NULL
AS


	IF @ResumeDownloadID IS NULL
		BEGIN
			SELECT
				a.*,
				ReferencedBy = (SELECT ReferencedByName FROM ReferencedBy WHERE ReferencedByID = a.ReferencedByID),
				ResumeDownloadType = (SELECT ResumeDownloadTypeName FROM ResumeDownloadType WHERE ResumeDownloadTypeID = a.ResumeDownloadTypeID)
			FROM
				ResumeDownloads a
			ORDER BY
				a.create_dt DESC;
		END
	ELSE
		BEGIN
			SELECT
				*
			FROM
				ResumeDownloads	
			WHERE
				ResumeDownloadID = @ResumeDownloadID;
		END



CREATE PROCEDURE [dbo].[sp_ResumeDownloads_insert]
	@FullName			VARCHAR(50),
    	@Company			VARCHAR(50),
	@Phone				VARCHAR(50),
    	@Email				VARCHAR(50),
    	@Comments			VARCHAR(1000),
    	@Website			VARCHAR(100),
	@ReferencedByID			INT,
    	@ResumeDownloadTypeID		INT,
    	@Referer			VARCHAR(1000),
	@SessionID			VARCHAR(100)
AS
	
	DECLARE @ResumeDownloadID		INT;
	
	SELECT @ResumeDownloadID = MAX(ResumeDownloadID) FROM ResumeDownloads;

	INSERT INTO ResumeDownloads
		(FullName, Company, Phone, Email, Comments, Website, ReferencedByID, ResumeDownloadTypeID, Referer, SessionID)
	VALUES
		(@FullName, @Company, @Phone, @Email, @Comments, @Website, @ReferencedByID, @ResumeDownloadTypeID, @Referer, @SessionID);

	SELECT ResumeDownloadTypeFileName FROM ResumeDownloadType WHERE ResumeDownloadTypeID = @ResumeDownloadTypeID;





CREATE PROCEDURE [dbo].[sp_ResumeDownloadType_UserID_get]
	@UserID			INT
AS
	
	
	SELECT 
		ResumeDownloadTypeID, 
		ResumeDownloadTypeName,
		ResumeDownloadTypeFileName
	FROM 
		ResumeDownloadType
	WHERE 
		UserID = @UserID 
	ORDER BY 
		 create_dt;



CREATE PROCEDURE [dbo].[sp_Sessions_delete]
	@JobCompanyID				INT
AS

	SELECT 
		a.*, 
		JobCompanyContactName = 
			CASE 
				WHEN b.JobCompanyContactFirstName <> '' AND b.JobCompanyContactLastName = '' THEN
					b.JobCompanyContactFirstName
				WHEN b.JobCompanyContactFirstName = '' AND b.JobCompanyContactLastName <> '' THEN
					b.JobCompanyContactLastName
				ELSE
					b.JobCompanyContactLastName + ', ' + b.JobCompanyContactFirstName
			END,
		JobStateName = (SELECT State FROM States WHERE StateID = a.JobStateID),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = @JobCompanyID) 
	FROM 
		Jobs a, 
		JobCompanyContact b 
	WHERE 
		a.JobCompanyContactID = b. JobCompanyContactID AND 
		a.JobCompanyID = @JobCompanyID
	ORDER BY 
		a.create_dt DESC;





CREATE PROCEDURE [dbo].[sp_Sessions_insert]
	@SessionID	VARCHAR(50),
	@SCRIPT_NAME	VARCHAR(500),
	@Application	VARCHAR(100),
	@IPAddress	VARCHAR(50),
	@Browser	VARCHAR(500),
	@Referer	VARCHAR(1000)
AS

	IF 
		NOT EXISTS (SELECT * FROM FilteredIPAddresses WHERE IPAddress = @IPAddress) AND
		NOT EXISTS (SELECT * FROM FilteredBrowsers WHERE Browser = @Browser) AND
		NOT EXISTS (SELECT * FROM Sessions WHERE Session_ID = @SessionID AND SCRIPT_NAME = @SCRIPT_NAME)
			BEGIN
				INSERT INTO Sessions
					(Session_ID, SCRIPT_NAME, Application, IPAddress, Browser, Referer)
				VALUES
					(@SessionID, @SCRIPT_NAME, @Application, @IPAddress, @Browser, @Referer);
			END

	IF @@IDENTITY IS NULL
		SELECT 0;
	ELSE
		SELECT 1;




CREATE PROCEDURE [dbo].[sp_Settings_get]
	@UserID			INT
AS

	SELECT 
		*
	FROM
		Settings
	WHERE
		UserID = @UserID;






CREATE PROCEDURE [dbo].[sp_Settings_update]
	 @UserID			INT,
	 @DebuggingSetting		BIT,
         @AdministratorEmail            VARCHAR(50),
	 @ContactsPhotosDirectory	VARCHAR(200),
         @DocumentsDirectory            VARCHAR(200),
         @PhotosDirectory            	VARCHAR(200),
         @MusicDirectory              	VARCHAR(200),
         @MoviesDirectory              	VARCHAR(200),
         @SMTPServer              	VARCHAR(100),
	 @SMTPServerPort		VARCHAR(10),
         @SMTPServerUserName           	VARCHAR(100),
         @SMTPServerPassword           	VARCHAR(100),
	 @POP3Server			VARCHAR(100),
	 @POP3ServerPort		VARCHAR(10),
	 @POP3ServerUserName		VARCHAR(100),
	 @POP3ServerPassword		VARCHAR(10)
AS


	UPDATE Settings SET
		DebuggingSetting = @DebuggingSetting,
		AdministratorEmail = @AdministratorEmail,
		ContactsPhotosDirectory = @ContactsPhotosDirectory, 
		DocumentsDirectory = @DocumentsDirectory, 
		PhotosDirectory = @PhotosDirectory, 
		MusicDirectory = @MusicDirectory,
		MoviesDirectory = @MoviesDirectory,
		SMTPServer = @SMTPServer,
		SMTPServerPort = @SMTPServerPort,
		SMTPServerUserName = @SMTPServerUserName,
		SMTPServerPassword = @SMTPServerPassword,
		POP3Server = @POP3Server,
		POP3ServerPort = @POP3ServerPort,
		POP3ServerUserName = @POP3ServerUserName,
		POP3ServerPassword = @POP3ServerPassword
	WHERE
		UserID = @UserID;




CREATE PROCEDURE [dbo].[sp_SickDays_CompanyID_SickDate]
	@CompanyID	INT,
	@SickDate	SMALLDATETIME
AS
	SELECT 
		SickDayID 
	FROM 
		SickDays 
	WHERE 
		CompanyID = @CompanyID AND 
		SickDate = @SickDate


CREATE PROCEDURE [dbo].[sp_SickDays_get]
	@UserID		INT
AS
	SELECT 
		b.CompanyID, 
		b.CompanyName, 
		a.SickDate 
	FROM 
		SickDays a, 
		Companies b 
	WHERE 
		a.CompanyID = b.CompanyID AND 
		b.UserID = @UserID
	ORDER BY 
		a.SickDate DESC, 
		b.CompanyName


CREATE PROCEDURE [dbo].[sp_SickDays_insert]
	@CompanyID	INT,
	@SickDate	SMALLDATETIME
AS
	INSERT INTO SickDays 
		(CompanyID, SickDate) 
	VALUES 
		(@CompanyID, @SickDate);



CREATE PROCEDURE [dbo].[sp_Sites_delete]
	@SiteID	INT
AS

	DELETE FROM 
		Sites 
	WHERE 
		SiteID = @SiteID;



CREATE PROCEDURE [dbo].[sp_SnippetGroups_get]
	@UserID		INT
AS
	SELECT
		a.SnippetGroupID, 
		a.UserID,
		a.SnippetGroupName,
		TotalSnippets = (SELECT COUNT(*) FROM Snippets b WHERE b.SnippetGroupID = a.SnippetGroupID)
	FROM 
		SnippetGroups a
	WHERE 
		a.UserID = @UserID
	ORDER BY 
		a.SnippetGroupName;




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SnippetGroups_insert]
	@UserID			INT,
	@SnippetGroupName	VARCHAR(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO SnippetGroups
		(UserID, SnippetGroupName)
	VALUES
		(@UserID, @SnippetGroupName);

	SELECT @@IDENTITY;
		
END



CREATE PROCEDURE [dbo].[sp_SnippetGroups_UserID_get]
	@UserID		INT
AS
	SELECT
		a.SnippetGroupID, 
		a.SnippetGroupName,
		b.SnippetName,
		TotalSnippets = (SELECT COUNT(*) FROM Snippets b WHERE b.SnippetGroupID = a.SnippetGroupID)
	FROM 
		SnippetGroups a,
		Snippets b
	WHERE 
		a.SnippetGroupID = b.SnippetGroupID AND
		a.UserID = @UserID
	ORDER BY 
		a.SnippetGroupName;


CREATE PROCEDURE [dbo].[sp_Snippets_delete]
	@SnippetID	INT
AS
	DELETE FROM Snippets WHERE SnippetID = @SnippetID;


CREATE PROCEDURE [dbo].[sp_Snippets_get]
	@SnippetGroupID		INT
AS

			SELECT 
				SnippetID,
				SnippetName,
				Snippet
			FROM 
				Snippets
			WHERE
				SnippetGroupID = @SnippetGroupID
			ORDER BY
				SnippetName;


CREATE PROCEDURE [dbo].[sp_Snippets_insert]
	@SnippetGroupID		INT,
	@SnippetName		VARCHAR(100),
	@Snippet		VARCHAR(8000)
AS
	INSERT INTO Snippets 
		(SnippetGroupID, SnippetName, Snippet) 
	VALUES 
		(@SnippetGroupID, @SnippetName, @Snippet);

	SELECT @@IDENTITY


CREATE PROCEDURE [dbo].[sp_Snippets_SnippetID]
	@SnippetID	INT
AS
	SELECT 
		SnippetID,
		SnippetGroupID,
		SnippetName,
		Snippet
	FROM 
		Snippets
	WHERE
		SnippetID = @SnippetID;




CREATE PROCEDURE [dbo].[sp_SQLScripts_get]
	@UserID		INT
AS
	
	SELECT 
		SQLScriptID, 
		SQLScriptShow = CASE 
				WHEN LEN(SQLScript) > 30 THEN 
			            Left(SQLScript, 30) + '...............'
                                ELSE 
				    SQLScript
			   END,
		SQLScript
	FROM 
		SQLScripts 
	WHERE 
		UserID = @UserID 
	ORDER BY 
		create_dt DESC;



CREATE PROCEDURE [dbo].[sp_SQLScripts_insert]
	@UserID		INT,
	@SQL		VARCHAR(2000)
AS
	IF NOT EXISTS(SELECT UserID FROM SQLScripts WHERE UserID = @UserID AND SQLScript = @SQL)
		INSERT INTO SQLScripts (UserID, SQLScript) VALUES (@UserID, @SQL);





CREATE PROCEDURE [dbo].[sp_States_get]
AS
	SELECT
 		StateID, 
		State 
	FROM 
		States 
	ORDER BY 
		State;




CREATE PROCEDURE [dbo].[sp_Sugar_insert]
	@UserID			INT = NULL,
	@SugarDateTime	DATETIME,
	@Sugar		SMALLINT, 
	@SugarComments	VARCHAR(2000)
AS
	
	INSERT INTO Sugar
		(UserID, SugarDateTime, Sugar, SugarComments)
	VALUES
		(@UserID, @SugarDateTime, @Sugar, @SugarComments)

	SELECT @@IDENTITY;



CREATE PROCEDURE [dbo].[sp_Sugar_update]
	@SugarID			INT,
	@SugarDateTime	DATETIME,
	@Sugar		INT, 
	@SugarComments	VARCHAR(2000)
AS
	
	UPDATE Sugar SET
		SugarDateTime = @SugarDateTime, 
		Sugar = @Sugar,
		SugarComments = @SugarComments
	WHERE
		SugarID = @SugarID;




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Sugar_UserID_get]
	@UserID			INT,
	@StartDate		DATETIME,
	@EndDate		DATETIME
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		SugarID,
		Sugar
	FROM
		Sugar
	WHERE
		UserID = @UserID AND
		SugarDateTime BETWEEN @StartDate AND @EndDate
	ORDER BY
		SugarDateTime
	
		
END




CREATE PROCEDURE [dbo].[sp_Temperature_insert]
	@UserID			INT = NULL,
	@TemperatureDateTime	DATETIME,
	@Temperature		NUMERIC(5,1), 
	@TemperatureComments	VARCHAR(2000)
AS
	
	INSERT INTO Temperature
		(UserID, TemperatureDateTime, Temperature, TemperatureComments)
	VALUES
		(@UserID, @TemperatureDateTime, @Temperature, @TemperatureComments)

	SELECT @@IDENTITY;



CREATE PROCEDURE [dbo].[sp_Temperature_update]
	@TemperatureID			INT,
	@TemperatureDateTime	DATETIME,
	@Temperature		NUMERIC(5,1), 
	@TemperatureComments	VARCHAR(2000)
AS
	
	UPDATE Temperature SET
		TemperatureDateTime = @TemperatureDateTime, 
		Temperature = @Temperature,
		TemperatureComments = @TemperatureComments
	WHERE
		TemperatureID = @TemperatureID;



CREATE PROCEDURE [dbo].[sp_Test_insert]
	@UserID				INT,
	@TestTypeID 			INT,
	@TestResultID			INT,
	@TestDate        		SMALLDATETIME,
	@TestLocation			VARCHAR(50), 
	 @TestComments			VARCHAR(200) 
AS
	
	INSERT INTO Test 
		(UserID, TestTypeID, TestDate, TestLocation, TestResultID, TestComments)
	VALUES
		(@UserID, @TestTypeID, @TestDate, @TestLocation, @TestResultID, @TestComments);

	SELECT @@IDENTITY;




CREATE PROCEDURE [dbo].[sp_Test_update]
	@TestID				INT,
	@TestTypeID 			INT,
	@TestResultID			INT,
	@TestDate        		SMALLDATETIME,
	@TestLocation			VARCHAR(50), 
	@TestComments			VARCHAR(200) 
AS
	
	UPDATE Test SET
		TestTypeID = @TestTypeID,
		TestResultID = @TestResultID, 
		TestDate = @TestDate, 
		TestLocation = @TestLocation,
		TestComments = @TestComments
	WHERE
		TestID = @TestID;




CREATE PROCEDURE [dbo].[sp_TestType_insert] 
	@UserID				INT,
	@TestTypeName 			VARCHAR(20)
AS
	
	INSERT INTO TestType 
		(UserID, TestTypeName)
	VALUES
		(@UserID, @TestTypeName);

	SELECT @@IDENTITY;




CREATE PROCEDURE [dbo].[sp_TestType_update] 
	@TestTypeID				INT,
	@TestTypeName 			VARCHAR(20)
AS
	
	UPDATE TestType SET
		TestTypeName = @TestTypeName
	WHERE
		TestTypeID = @TestTypeID;




CREATE PROCEDURE [dbo].[sp_TextMessage_insert]
	@UserID				INT,
	@TextMessageFromEmail		VARCHAR(50),
	@TextMessage			VARCHAR(MAX)
AS

	INSERT INTO TextMessage
		(UserID, TextMessageFromEmail, TextMessage)
	VALUES
		(@UserID, @TextMessageFromEmail, @TextMessage);




CREATE PROCEDURE [dbo].[sp_Timehseet_Paychecks_CompanyID_get]
	@TimeSheetCompanyID			INT
AS
	
	SELECT 
		PaycheckID,
		PaymentDate,
		Net = (Gross - 
			Federal - 
			SocialSecurity -
			Medicare - 
			NY_Withholding -
			NY_Disability - 
			NY_City)
			
	FROM 		
			
		Paychecks
	WHERE 
		TimeSheetCompanyID = @TimeSheetCompanyID
	ORDER BY 
		PaymentDate;




CREATE PROCEDURE [dbo].[sp_Timehseet_Paychecks_info_get]
	@TimeSheetCompanyID			INT = NULL
AS
	
	SELECT 
		TimesheetCompanyName = (SELECT TimesheetCompanyName FROM TimesheetCompany WHERE TimesheetCompanyID = @TimesheetCompanyID),
		TotalPaychecks = (SELECT COUNT(*) FROM Paychecks WHERE TimesheetCompanyID = @TimesheetCompanyID),
		MinPaycheckYear = (SELECT MIN(DATEPART(YEAR, PaymentDate)) FROM Paychecks),
		MaxPaycheckYear = (SELECT MAX(DATEPART(YEAR, PaymentDate)) FROM Paychecks)




CREATE PROCEDURE [dbo].[sp_Timehseet_Paychecks_Year_get]
	@UserID				INT,
	@CurrentYear			INT
AS
	
	SELECT 
		b.TimesheetCompanyName,
		a.* 
	FROM
		Paychecks a,
		TimesheetCompany b
	WHERE
		a.TimesheetCompanyID = b.TimesheetCompanyID
		AND b.UserID = @UserID
		AND DATEPART(year, a.PaymentDate) = @CurrentYear
	ORDER BY
		a.PaymentDate;




CREATE PROCEDURE [dbo].[sp_Timehseet_UserID_Company_get]
	@UserID			INT
AS
	
	SELECT 
		a.TimeSheetCompanyID,
		a.TimeSheetCompanyName,
		TotalTimesheets = (SELECT COUNT(*) FROM Timesheet WHERE TimeSheetCompanyID = a.TimeSheetCompanyID),
		TotalPaychecks = (SELECT COUNT(*) FROM Paychecks WHERE TimesheetCompanyID = a.TimeSheetCompanyID)
	FROM 
		TimeSheetCompany a
	WHERE 
		a.UserID = @UserID
	ORDER BY 
		a.TimeSheetCompanyName;





CREATE PROCEDURE [dbo].[sp_Timesheet_insert]
	@TimesheetCompanyID		INT,
	@TimesheetInvoiceDate		DATETIME,
	@TimesheetInvoiceNumber		VARCHAR(100),
	@TimesheetHourlyRate		NUMERIC(9, 2),
	@TimesheetStartDate		DATETIME,
	@TimesheetEndDate		DATETIME
AS
	
	INSERT INTO Timesheet 
		(TimesheetCompanyID, TimesheetInvoiceDate, TimesheetInvoiceNumber, TimesheetHourlyRate, TimesheetStartDate, TimesheetEndDate)
	VALUES
		(@TimesheetCompanyID, @TimesheetInvoiceDate, @TimesheetInvoiceNumber, @TimesheetHourlyRate, @TimesheetStartDate, @TimesheetEndDate);

	SELECT @@IDENTITY;






-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Timesheet_Invoice_generate]
	@TimesheetID		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	SELECT
		FullName = d.FirstName + ' ' + d.LastName,
		HomeAddress1 = d.Address1,
		HomeAddress2 = d.Address2,
		HomeCity = d.City,
		HomeState = (SELECT StateAbbr FROM States WHERE StateID = d.StateID),
		HomeZipCode = d.ZipCode,
		HomePhone = d.Phone,

		InvoiceDate = a.TimesheetInvoiceDate,
		InvoiceNumber = a.TimesheetInvoiceNumber,
		HourlyRate = a.TimesheetHourlyRate,
		CompanyName = b.TimesheetCompanyName,
		CompanyAddress1 = b.TimesheetCompanyAddress1,
		CompanyAddress2 = b.TimesheetCompanyAddress2,
		CompanyCity = b.TimesheetCompanyCity,
		CompanyState = (SELECT StateAbbr FROM States WHERE StateID = b.TimesheetCompanyStateID),
		CompanyZipCode = b.TimesheetCompanyZipCode,
		CompanyPhone = b.TimesheetCompanyPhone,

		TimesheetDate = c.TimesheetDetailDate,
		TimesheetHours = c.TimesheetHours,
		TimesheetDescription = c.TimesheetDescription
	FROM
		Timesheet a,
		TimesheetCompany b,
		TimesheetDetail c,
		Users d
	WHERE
		a.TimesheetID = @TimesheetID AND
		a.TimesheetCompanyID = b.TimesheetCompanyID AND
		a.TimesheetID = c.TimesheetID AND
		b.UserID = d.UserID
END





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Timesheet_Invoices_get]
	@TimesheetCompanyID		INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	SELECT 
		TimesheetCompanyName = (SELECT TimesheetCompanyName FROM TimesheetCompany WHERE TimesheetCompanyID = @TimesheetCompanyID), 
		TotalPay = (SELECT SUM(TimesheetHours) * Timesheet.TimeSheetHourlyRate FROM TimesheetDetail WHERE TimesheetID = TimeSheet.TimeSheetID),
		* 
	FROM 
		TimeSheet 
	WHERE 
		TimesheetCompanyID = @TimesheetCompanyID 
	ORDER BY 
		TimesheetStartDate		
END




CREATE PROCEDURE [dbo].[sp_Timesheet_Paychecks_PaycheckID_get]
	@PaycheckID			INT
AS
	
	SELECT 
		*			
	FROM 		
			
		Paychecks
	WHERE 
		PaycheckID = @PaycheckID;




CREATE PROCEDURE sp_Timesheet_TimesheetID_TimesheetHTML_update 
	@TimesheetID				INT,
	@TimesheetHTML 				VARCHAR(MAX)
AS
	
	UPDATE Timesheet SET
		TimesheetHTML = @TimesheetHTML
	WHERE
		TimesheetID = @TimesheetID;




CREATE PROCEDURE [dbo].[sp_Timesheet_TimesheetInvoiceNumber_get]
	@TimesheetCompanyID	INT
AS

	SELECT 
		TimeSheetInvoiceNumber = ISNULL(MAX(TimeSheetInvoiceNumber) + 1, 1001) 
	FROM 
		TimeSheet 
	WHERE 
		TimeSheetCompanyID = @TimesheetCompanyID;





CREATE PROCEDURE [dbo].[sp_TimesheetCompany_insert]
	@UserID				INT,
	@TimesheetCompanyName		VARCHAR(100),
	@TimesheetCompanyAddress1	VARCHAR(100),
	@TimesheetCompanyAddress2	VARCHAR(100),
	@TimesheetCompanyCity		VARCHAR(100),
	@TimesheetCompanyStateID	INT,
	@TimesheetCompanyZipCode	VARCHAR(20),
	@TimesheetCompanyPhone		VARCHAR(100)
AS
	
	
	INSERT INTO TimesheetCompany 
		(UserID, TimesheetCompanyName, TimesheetCompanyAddress1, TimesheetCompanyAddress2, TimesheetCompanyCity, TimesheetCompanyStateID, TimesheetCompanyZipCode, TimesheetCompanyPhone) 
	VALUES
		(@UserID, @TimesheetCompanyName, @TimesheetCompanyAddress1, @TimesheetCompanyAddress2, @TimesheetCompanyCity, @TimesheetCompanyStateID, @TimesheetCompanyZipCode, dbo.fn_FormatPhoneNumber(@TimesheetCompanyPhone)); 

	SELECT @@IDENTITY;



CREATE PROCEDURE [dbo].[sp_TimesheetDetail_TimesheetID_get]
	@TimesheetID		INT
AS


	SELECT 
		TotalTimesheetEntries = 
			(
				SELECT 
					COUNT(*)
				FROM
					TimesheetDetail
				WHERE
					TimesheetID = a.TimesheetID AND
					TimesheetDetailDate = a.TimesheetDetailDate
			),
		a.* 
	FROM 
		TimesheetDetail a
	WHERE 
		a.TimesheetID = @TimesheetID
	ORDER BY 
		a.TimesheetDetailDate DESC,
		a.create_dt DESC;



CREATE PROCEDURE [dbo].[sp_Transactions_exists]
	@Description 	VARCHAR(50)
AS
	SELECT Description FROM Transactions where UPPER(Description) = UPPER(@Description);




CREATE PROCEDURE [dbo].[sp_Transactions_get]
	@UserID		INT
AS
	SELECT 
		TransactionID, 
		Description,
		TotalTransactions = (SELECT COUNT(*) FROM Banking WHERE TransactionID = Transactions.TransactionID)
	FROM 
		Transactions 
	WHERE 
		Description IS NOT NULL OR 
		Description <> '' 
	ORDER BY 
		Description;





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Transactions_import]
	
AS
BEGIN
	DECLARE @UserID		INT;


	-- =============================================
	-- CREATE NEW TRANSACTIONS TABLE
	-- =============================================
	IF NOT EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Transactions_new' AND TYPE = 'U')
		BEGIN
			CREATE TABLE Transactions_new
			(
				TransactionID			INT IDENTITY(1001, 1) NOT NULL,
				OldTransactionID		INT NOT NULL,
				UserID				INT NOT NULL,
				Description			VARCHAR(1000)
			);
		END
	ELSE
		TRUNCATE TABLE Transactions_new;

	-- =============================================
	-- DECLARE DISTINCT Banking ACCOUNT USER ID CURSOR
	-- =============================================
	SELECT DISTINCT UserID INTO #BankingAccountUsers FROM BankingAccount;

	DECLARE BankingAccount_cursor CURSOR FOR 
		SELECT UserID FROM #BankingAccountUsers;

	OPEN BankingAccount_cursor
	FETCH NEXT FROM BankingAccount_cursor INTO @UserID;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT INTO Transactions_new
				(OldTransactionID, UserID, Description)

			SELECT DISTINCT 
				a.TransactionID AS OldTransactionID, 
				@UserID AS UserID,
				a.Description AS Description
			FROM 
				Transactions a, 
				Banking b, 
				BankingAccount c
			WHERE 
				a.TransactionID = b.TransactionID AND
				b.BankingAccountID = c.BankingAccountID and
				c.UserID = @UserID;
			
			FETCH NEXT FROM BankingAccount_cursor INTO @UserID;
		END

	CLOSE BankingAccount_cursor;
	DEALLOCATE BankingAccount_cursor;

	UPDATE Banking SET TransactionID =
		(
			SELECT
				TransactionID 
			FROM 
				Transactions_new
			WHERE 
				OldTransactionID = Banking.TransactionID AND
				UserID = Banking.UserID
		)
END





CREATE PROCEDURE [dbo].[sp_Transactions_insert]
	@TransactionID		INT OUTPUT,
	@UserID			INT,
	@Description		VARCHAR(100)
AS
	IF NOT EXISTS (SELECT TransactionID FROM Transactions WHERE UserID = @UserID AND Description = @Description)
		BEGIN
			INSERT INTO Transactions
				(UserID, Description) 
			VALUES 
				(@UserID, @Description);
			
			SET @TransactionID = @@IDENTITY;
			SELECT @TransactionID;
		END
	ELSE
		BEGIN
			SELECT @TransactionID = TransactionID FROM Transactions WHERE Description = @Description
		END






CREATE PROCEDURE [dbo].[sp_Transactions_TransactionID_get]
	@TransactionID		INT	
AS
	SELECT 
		TransactionID, 
		Description,
		TotalTransactions = (SELECT COUNT(*) FROM Banking WHERE TransactionID = Transactions.TransactionID)
	FROM 
		Transactions
	WHERE
		TransactionID = @TransactionID; 





CREATE PROCEDURE [dbo].[sp_Transactions_UserID_get]
	@UserID		INT
AS
	SELECT 
		TransactionID, 
		Description,
		TotalTransactions = (SELECT COUNT(*) FROM Transactions 	WHERE UserID = @UserID AND (Description IS NOT NULL OR Description <> ''))

	FROM 
		Transactions 
	WHERE 
		UserID = @UserID AND
		(Description IS NOT NULL OR 
		Description <> '')
	ORDER BY 
		Description;




CREATE PROCEDURE [dbo].[sp_Unit_insert] 
	@UserID				INT,
	@UnitName 			VARCHAR(20)
AS
	
	INSERT INTO Unit 
		(UserID, UnitName)
	VALUES
		(@UserID, @UnitName);

	SELECT @@IDENTITY;




CREATE PROCEDURE [dbo].[sp_Unit_update] 
	@UnitID				INT,
	@UnitName 			VARCHAR(20)
AS
	
	UPDATE Unit SET
		UnitName = @UnitName
	WHERE
		UnitID = @UnitID;



CREATE PROCEDURE [dbo].[sp_Users_delete]
	@UserID				INT
AS

	BEGIN TRANSACTION

		BEGIN

			DELETE FROM Accounts WHERE UserID = @UserID;

			DELETE FROM Artists WHERE UserID = @UserID;

			DELETE FROM Backups WHERE UserID = @UserID;

			DELETE FROM Banking WHERE BankingAccountID IN (SELECT BankingAccountID FROM BankingAccount WHERE UserID = @UserID);
			DELETE FROM BankingAccount WHERE UserID = @UserID;

			DELETE FROM CompanyAddress WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID);
			DELETE FROM CompanyContact WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID);
			DELETE FROM PhoneCall WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID);
			DELETE FROM Interview WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID);
			DELETE FROM ResumeQueue WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID);
			DELETE FROM Company WHERE UserID = @UserID;
			DELETE FROM ResumeFile WHERE UserID = @UserID;
			DELETE FROM ResumeText WHERE UserID = @UserID;

			DELETE FROM Contacts WHERE UserID = @UserID;

			DELETE FROM CreditCard WHERE UserID = @UserID;

			DELETE FROM HeartRate WHERE UserID = @UserID;
			DELETE FROM MedicineDose WHERE MedicineID IN (SELECT MedicineID FROM Medicine WHERE UserID = @UserID);
			DELETE FROM Medicine WHERE UserID = @UserID;
			DELETE FROM Logins WHERE UserID = @UserID;
			DELETE FROM TestType WHERE UserID = @UserID;
			DELETE FROM Test WHERE UserID = @UserID;
			DELETE FROM Unit WHERE UserID = @UserID;

			DELETE FROM RecoveryGroupSessions WHERE RecoveryGroupID IN (SELECT RecoveryGroupID FROM RecoveryGroups WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = @UserID));
			DELETE FROM RecoveryCounselors WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = @UserID);
			DELETE FROM RecoveryGroups WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = @UserID);
			DELETE FROM RecoveryPrograms WHERE UserID = @UserID;

			DELETE FROM Settings WHERE UserID = @UserID;

			DELETE FROM Snippets WHERE SnippetGroupID IN (SELECT SnippetGroupID FROM SnippetGroups WHERE UserID = @UserID);
			DELETE FROM SnippetGroups WHERE UserID = @UserID;

			DELETE FROM TimeSheetDetail WHERE TimeSheetID IN (SELECT TimeSheetID FROM TimeSheet WHERE TimesheetCompanyID IN (SELECT TimesheetCompanyID FROM TimesheetCompany WHERE UserID = @UserID));
			DELETE FROM TimeSheetPayment WHERE TimeSheetCompanyID IN (SELECT TimeSheetCompanyID FROM TimeSheetCompany WHERE UserID = @UserID);
			DELETE FROM TimeSheet WHERE TimeSheetCompanyID IN (SELECT TimeSheetCompanyID FROM TimeSheetCompany WHERE UserID = @UserID);
			DELETE FROM TimeSheetCompany WHERE UserID = @UserID;

			DELETE FROM Users WHERE UserID = @UserID;
			
		END

	IF @@ERROR > 0
		ROLLBACK TRANSACTION;
	ELSE
		COMMIT TRANSACTION;






CREATE PROCEDURE [dbo].[sp_Users_get]
AS
	SELECT 
		UserID, 
		UserName, 
		Password,
		Email
	FROM 
		Users 
	ORDER BY 
		UserName;



CREATE PROCEDURE [dbo].[sp_Users_insert]
	@UserName			VARCHAR(100),
	@Password			VARCHAR(100),
	@FirstName			VARCHAR(50),
	@LastName			VARCHAR(50),
	@Email				VARCHAR(100),
	@MobileEmail			VARCHAR(100),
	@Administrator			BIT,
	@Contacts			BIT,
	@PersonalInformation		BIT,
	@Documents			BIT,
	@Banking			BIT,
	@CreditCards			BIT,
	@Photos				BIT,
	@Music				BIT,
	@MovieCollection		BIT,
	@Movies				BIT,
	@Snippets			BIT,
	@Health				BIT,
	@Jobs				BIT,
	@Recovery			BIT,
	@Timesheet			BIT,
	@Notes				BIT,
	@tiradoonline			BIT
AS
		
	DECLARE @UserID		INT;

	BEGIN TRANSACTION

		BEGIN

			INSERT INTO Users
				(UserName, Password, FirstName, LastName, Email, MobileEmail, Administrator, Contacts, PersonalInformation,
				Documents, Banking, CreditCards, Photos, Music, MovieCollection, Movies, Snippets, Health, Jobs, [Recovery], Timesheet, Notes, tiradoonline, Active)
			VALUES
				(@UserName, @Password, @FirstName, @LastName, @Email, @MobileEmail, @Administrator, @Contacts, @PersonalInformation,
				@Documents, @Banking, @CreditCards, @Photos, @Music, @MovieCollection, @Movies, @Snippets, @Health, @Jobs, @Recovery, @Timesheet, @Notes, @tiradoonline, 1);

			SET @UserID = @@IDENTITY;

			INSERT INTO Settings
				(UserID, AdministratorEmail)
			VALUES
				(@UserID, @Email);
			

			INSERT INTO Transactions
				(UserID, Description)
			VALUES
				(@UserID, 'Deposit');

			INSERT INTO Transactions
				(UserID, Description)
			VALUES
				(@UserID, 'Opening Banking');

			INSERT INTO Unit
				(UserID, UnitName)
			VALUES
				(@UserID, 'UNITS');

			INSERT INTO Unit
				(UserID, UnitName)
			VALUES
				(@UserID, 'MG');
			
			EXEC sp_BankingAccount_insert @UserID, 'Checking';

		END

	IF @@ERROR > 0
		ROLLBACK TRANSACTION;
	ELSE
		COMMIT TRANSACTION;





CREATE PROCEDURE [dbo].[sp_Users_reports]
	@UserID			INT,
	@Administrator		BIT = 0

AS

	IF @Administrator = 0
		BEGIN
		
			SELECT
				Active = 1,
				Artists = (SELECT COUNT(*) FROM Artists WHERE UserID = @UserID),
		
				Backups = (SELECT COUNT(*) FROM Backups WHERE UserID = @UserID),
		
				Banking = (SELECT COUNT(*) FROM Banking WHERE BankingAccountID IN (SELECT BankingAccountID FROM BankingAccount WHERE UserID = @UserID)),
		
				BalancAccounts = (SELECT COUNT(*) FROM BankingAccount WHERE UserID = @UserID),
		
				BloodPressure = (SELECT COUNT(*) FROM BloodPressure WHERE UserID = @UserID),
		
				Companies = (SELECT COUNT(*) FROM Companies WHERE UserID = @UserID),
		
				Company = (SELECT COUNT(*) FROM Company WHERE UserID = @UserID),
		
				CompanyAddress = (SELECT COUNT(*) FROM CompanyAddress WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID)),
		
				CompanyContact = (SELECT COUNT(*) FROM CompanyContact WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID)),
		
				Contacts = (SELECT COUNT(*) FROM Contacts WHERE UserID = @UserID),
		
				CreditCard = (SELECT COUNT(*) FROM CreditCard WHERE UserID = @UserID),
		
				Emails = (SELECT COUNT(*) FROM Emails WHERE UserID = @UserID),
		
				EmailTemplates = (SELECT COUNT(*) FROM EmailTemplates WHERE UserID = @UserID),
		
				HeartRate = (SELECT COUNT(*) FROM HeartRate WHERE UserID = @UserID),
		
				Hours = (SELECT COUNT(*) FROM Hours WHERE CompanyID IN (SELECT CompanyID FROM Companies WHERE UserID = @UserID)),
		
				Insulin = (SELECT COUNT(*) FROM Insulin WHERE UserID = @UserID),
		
				Interview = (SELECT COUNT(*) FROM Interview WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID)),
		
				Logins = (SELECT COUNT(*) FROM Logins WHERE UserID = @UserID),
		
				Medicine = (SELECT COUNT(*) FROM Medicine WHERE UserID = @UserID),
		
				MedicineDose = (SELECT COUNT(*) FROM MedicineDose WHERE MedicineID IN (SELECT MedicineID FROM Medicine WHERE UserID = @UserID)),
		
				MonthlyBills = (SELECT COUNT(*) FROM MonthlyBills WHERE BankingAccountID IN (SELECT BankingAccountID FROM BankingAccount WHERE UserID = @UserID)),
		
				Movies = (SELECT COUNT(*) FROM Movies WHERE UserID = @UserID),
		
				Notes = (SELECT COUNT(*) FROM Notes WHERE UserID = @UserID),
		
				PageLogs = (SELECT COUNT(*) FROM PageLogs WHERE UserID = @UserID),
		
				Paychecks = (SELECT COUNT(*) FROM Paychecks WHERE CompanyID IN (SELECT CompanyID FROM Companies WHERE UserID = @UserID)),
		
				PersonalDays = (SELECT COUNT(*) FROM PersonalDays WHERE CompanyID IN (SELECT CompanyID FROM Companies WHERE UserID = @UserID)),
		
				PersonalInformation = (SELECT COUNT(*) FROM PersonalInformation WHERE UserID = @UserID),
		
				PhoneCall = (SELECT COUNT(*) FROM PhoneCall WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID)),
		
				RecoveryCounselors = (SELECT COUNT(*) FROM RecoveryCounselors WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = @UserID)),
		
				RecoveryGroups = (SELECT COUNT(*) FROM RecoveryGroups WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = @UserID)),
		
				RecoveryGroupSessions = (SELECT COUNT(*) FROM RecoveryGroupSessions WHERE RecoveryGroupID IN (SELECT RecoveryGroupID FROM RecoveryGroups WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = @UserID))),
		
				RecoveryPrograms = (SELECT COUNT(*) FROM RecoveryPrograms WHERE UserID = @UserID),
		
				Reminders = (SELECT COUNT(*) FROM Reminders WHERE UserID = @UserID),
		
				ResumeFile = (SELECT COUNT(*) FROM ResumeFile WHERE UserID = @UserID),
		
				ResumeQueue = (SELECT COUNT(*) FROM ResumeQueue WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = @UserID)),
		
				ResumeText = (SELECT COUNT(*) FROM ResumeText WHERE UserID = @UserID),
		
				Settings = (SELEC
T COUNT(*) FROM Settings WHERE UserID = @UserID),
		
				SickDays = (SELECT COUNT(*) FROM SickDays WHERE CompanyID IN (SELECT CompanyID FROM Companies WHERE UserID = @UserID)),
		
				Snippets = (SELECT COUNT(*) FROM Snippets WHERE SnippetGroupID IN (SELECT SnippetGroupID FROM SnippetGroups WHERE UserID = @UserID)),
		
				SnippetGroups = (SELECT COUNT(*) FROM SnippetGroups WHERE UserID = @UserID),
		
				SQLScripts = (SELECT COUNT(*) FROM SQLScripts WHERE UserID = @UserID),
		
				Sugar = (SELECT COUNT(*) FROM Sugar WHERE UserID = @UserID),
		
				Temperature = (SELECT COUNT(*) FROM Temperature WHERE UserID = @UserID),
		
				Test = (SELECT COUNT(*) FROM Test WHERE UserID = @UserID),
		
				TestType = (SELECT COUNT(*) FROM TestType WHERE UserID = @UserID),
		
				TimeSheet = (SELECT COUNT(*) FROM TimeSheet WHERE TimeSheetCompanyID IN (SELECT TimeSheetCompanyID FROM TimeSheetCompany WHERE UserID = @UserID)),
		
				TimeSheetCompany = (SELECT COUNT(*) FROM TimeSheetCompany WHERE UserID = @UserID),
		
				TimeSheetDetail = (SELECT COUNT(*) FROM TimeSheetDetail WHERE TimeSheetID IN (SELECT TimeSheetID FROM TimeSheet WHERE TimesheetCompanyID IN (SELECT TimesheetCompanyID FROM TimesheetCompany WHERE UserID = @UserID))),
		
				TimeSheetPayment = (SELECT COUNT(*) FROM TimeSheetPayment WHERE TimeSheetCompanyID IN (SELECT TimeSheetCompanyID FROM TimeSheetCompany WHERE UserID = @UserID)),
		
				Unit = (SELECT COUNT(*) FROM Unit WHERE UserID = @UserID);
		END
	ELSE

		BEGIN
		
			SELECT
				Active,
				a.UserID, 

				a.UserName,

				FullName = a.FirstName + ' ' + a.LastName, 

				Artists = (SELECT COUNT(*) FROM Artists WHERE UserID = a.UserID),
		
				Backups = (SELECT COUNT(*) FROM Backups WHERE UserID = a.UserID),
		
				Banking = (SELECT COUNT(*) FROM Banking WHERE BankingAccountID IN (SELECT BankingAccountID FROM BankingAccount WHERE UserID = a.UserID)),
		
				BalancAccounts = (SELECT COUNT(*) FROM BankingAccount WHERE UserID = a.UserID),
		
				BloodPressure = (SELECT COUNT(*) FROM BloodPressure WHERE UserID = a.UserID),
		
				Companies = (SELECT COUNT(*) FROM Companies WHERE UserID = a.UserID),
		
				Company = (SELECT COUNT(*) FROM Company WHERE UserID = a.UserID),
		
				CompanyAddress = (SELECT COUNT(*) FROM CompanyAddress WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = a.UserID)),
		
				CompanyContact = (SELECT COUNT(*) FROM CompanyContact WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = a.UserID)),
		
				Contacts = (SELECT COUNT(*) FROM Contacts WHERE UserID = a.UserID),
		
				CreditCard = (SELECT COUNT(*) FROM CreditCard WHERE UserID = a.UserID),
		
				Emails = (SELECT COUNT(*) FROM Emails WHERE UserID = a.UserID),
		
				EmailTemplates = (SELECT COUNT(*) FROM EmailTemplates WHERE UserID = a.UserID),
		
				HeartRate = (SELECT COUNT(*) FROM HeartRate WHERE UserID = a.UserID),
		
				Hours = (SELECT COUNT(*) FROM Hours WHERE CompanyID IN (SELECT CompanyID FROM Companies WHERE UserID = a.UserID)),
		
				Insulin = (SELECT COUNT(*) FROM Insulin WHERE UserID = a.UserID),
		
				Interview = (SELECT COUNT(*) FROM Interview WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = a.UserID)),
		
				Logins = (SELECT COUNT(*) FROM Logins WHERE UserID = a.UserID),
		
				Medicine = (SELECT COUNT(*) FROM Medicine WHERE UserID = a.UserID),
		
				MedicineDose = (SELECT COUNT(*) FROM MedicineDose WHERE MedicineID IN (SELECT MedicineID FROM Medicine WHERE UserID = a.UserID)),
		
				MonthlyBills = (SELECT COUNT(*) FROM MonthlyBills WHERE BankingAccountID IN (SELECT BankingAccountID FROM BankingAccount WHERE UserID = a.UserID)),
		
				Movies = (SELECT COUNT(*) FROM Movies WHERE UserID = a.UserID),
		
				Notes = (SELECT COUNT(*) FROM Notes WHERE UserID = a.UserID),
		
				PageLogs = (SELECT COUNT(*) FROM PageLogs WHERE UserID = a.UserID),
		
				Paychecks = (SELECT COUNT(*) FROM Paychecks WHERE Company
ID IN (SELECT CompanyID FROM Companies WHERE UserID = a.UserID)),
		
				PersonalDays = (SELECT COUNT(*) FROM PersonalDays WHERE CompanyID IN (SELECT CompanyID FROM Companies WHERE UserID = a.UserID)),
		
				PersonalInformation = (SELECT COUNT(*) FROM PersonalInformation WHERE UserID = a.UserID),
		
				PhoneCall = (SELECT COUNT(*) FROM PhoneCall WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = a.UserID)),
		
				RecoveryCounselors = (SELECT COUNT(*) FROM RecoveryCounselors WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = a.UserID)),
		
				RecoveryGroups = (SELECT COUNT(*) FROM RecoveryGroups WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = a.UserID)),
		
				RecoveryGroupSessions = (SELECT COUNT(*) FROM RecoveryGroupSessions WHERE RecoveryGroupID IN (SELECT RecoveryGroupID FROM RecoveryGroups WHERE RecoveryProgramID IN (SELECT RecoveryProgramID FROM RecoveryPrograms WHERE UserID = a.UserID))),
		
				RecoveryPrograms = (SELECT COUNT(*) FROM RecoveryPrograms WHERE UserID = a.UserID),
		
				Reminders = (SELECT COUNT(*) FROM Reminders WHERE UserID = a.UserID),
		
				ResumeFile = (SELECT COUNT(*) FROM ResumeFile WHERE UserID = a.UserID),
		
				ResumeQueue = (SELECT COUNT(*) FROM ResumeQueue WHERE CompanyID IN (SELECT CompanyID FROM Company WHERE UserID = a.UserID)),
		
				ResumeText = (SELECT COUNT(*) FROM ResumeText WHERE UserID = a.UserID),
		
				Settings = (SELECT COUNT(*) FROM Settings WHERE UserID = a.UserID),
		
				SickDays = (SELECT COUNT(*) FROM SickDays WHERE CompanyID IN (SELECT CompanyID FROM Companies WHERE UserID = a.UserID)),
		
				Snippets = (SELECT COUNT(*) FROM Snippets WHERE SnippetGroupID IN (SELECT SnippetGroupID FROM SnippetGroups WHERE UserID = a.UserID)),
		
				SnippetGroups = (SELECT COUNT(*) FROM SnippetGroups WHERE UserID = a.UserID),
		
				SQLScripts = (SELECT COUNT(*) FROM SQLScripts WHERE UserID = a.UserID),
		
				Sugar = (SELECT COUNT(*) FROM Sugar WHERE UserID = a.UserID),
		
				Temperature = (SELECT COUNT(*) FROM Temperature WHERE UserID = a.UserID),
		
				Test = (SELECT COUNT(*) FROM Test WHERE UserID = a.UserID),
		
				TestType = (SELECT COUNT(*) FROM TestType WHERE UserID = a.UserID),
		
				TimeSheet = (SELECT COUNT(*) FROM TimeSheet WHERE TimeSheetCompanyID IN (SELECT TimeSheetCompanyID FROM TimeSheetCompany WHERE UserID = a.UserID)),
		
				TimeSheetCompany = (SELECT COUNT(*) FROM TimeSheetCompany WHERE UserID = a.UserID),
		
				TimeSheetDetail = (SELECT COUNT(*) FROM TimeSheetDetail WHERE TimeSheetID IN (SELECT TimeSheetID FROM TimeSheet WHERE TimesheetCompanyID IN (SELECT TimesheetCompanyID FROM TimesheetCompany WHERE UserID = a.UserID))),
		
				TimeSheetPayment = (SELECT COUNT(*) FROM TimeSheetPayment WHERE TimeSheetCompanyID IN (SELECT TimeSheetCompanyID FROM TimeSheetCompany WHERE UserID = a.UserID)),
		
				Unit = (SELECT COUNT(*) FROM Unit WHERE UserID = a.UserID),

				a.create_dt
			FROM
				Users a;

		END



CREATE PROCEDURE sp_Users_update
	@UserID				INT,
	@UserName			VARCHAR(100),
	@Password			VARCHAR(100),
	@FirstName			VARCHAR(50),
	@LastName			VARCHAR(50),
	@Email				VARCHAR(100),
	@MobileEmail		VARCHAR(100),
	@Address1			VARCHAR(100),
	@Address2			VARCHAR(100),
	@City				VARCHAR(100),
	@StateID			INT,
	@Phone				VARCHAR(50),
	@AIM				VARCHAR(50),
	@Yahoo				VARCHAR(50),
	@Hotmail			VARCHAR(50),
	@Skype				VARCHAR(50),
	@Gmail				VARCHAR(50),
	@Administrator			BIT,
	@Contacts			BIT,
	@PersonalInformation		BIT,
	@Documents			BIT,
	@Banking			BIT,
	@CreditCards			BIT,
	@Photos				BIT,
	@Music				BIT,
	@MovieCollection		BIT,
	@Movies				BIT,
	@Snippets			BIT,
	@Health				BIT,
	@Jobs				BIT,
	@Recovery			BIT,
	@Timesheet			BIT,
	@Notes				BIT,
	@tiradoonline			BIT,
	@Active				BIT,
	@update_by			INT,
	@update_dt			DATETIME
AS

	UPDATE Users SET
		UserName = @UserName,
		Password = @Password,
		FirstName = @FirstName,
		LastName = @LastName,
		Email = @Email,
		Address1 = @Address1,
		Address2 = @Address2,
		City = @City,
		StateID = @StateID,
		Phone = @Phone,
		AIM = @AIM,
		Yahoo = @Yahoo,
		Hotmail = @Hotmail,
		Skype = @Skype,
		Gmail = @Gmail,
		Administrator = @Administrator,
		Contacts = @Contacts,
		PersonalInformation = @PersonalInformation,
		Documents = @Documents,
		Banking = @Banking,
		CreditCards = @CreditCards,
		Photos = @Photos,
		Music = @Music,
		MovieCollection = @MovieCollection,
		Movies = @Movies,
		Snippets = @Snippets,
		Health = @Health,
		Jobs = @Jobs,
		Recovery = @Recovery,
		Timesheet = @Timesheet,
		Notes = @Notes,
		tiradoonline = @tiradoonline,
		Active = @Active,
		update_by = @update_by,
		update_dt = @update_dt
	WHERE	
		UserID = @UserID



CREATE PROCEDURE [dbo].[sp_Users_UserID_get]
	@UserID		INT
AS

	SELECT
		* 
	FROM 
		Users
	WHERE
		UserID = @UserID





CREATE PROCEDURE [dbo].[sp_Users_UserName_Password]
	@UserName		VARCHAR(10),
	@Password		VARCHAR(10)
AS
		SELECT 
			FullName = FirstName + ' ' + LastName,
			*
		FROM 
			Users 
		WHERE 
			UserName = @UserName AND 
			Password = @Password AND
			Active = 1;




CREATE PROCEDURE [dbo].[sp_WebsiteEmail_insert]
	@UserID				INT,
	@WebsiteFromEmail		VARCHAR(50),
	@WebsiteEmailBodyText			VARCHAR(MAX)
AS

	INSERT INTO WebsiteEmail
		(UserID, WebsiteFromEmail, WebsiteEmailBodyText)
	VALUES
		(@UserID, @WebsiteFromEmail, @WebsiteEmailBodyText);




CREATE PROCEDURE [dbo].[sp_Weight_insert]
	@UserID			INT = NULL,
	@WeightDateTime		DATETIME,
	@Weight			INT, 
	@WeightLocation		VARCHAR(100), 
	@WeightComments		VARCHAR(2000)
AS
	
	INSERT INTO Weight
		(UserID, WeightDateTime, Weight, WeightLocation, WeightComments)
	VALUES
		(@UserID, @WeightDateTime, @Weight, @WeightLocation, @WeightComments)

	SELECT @@IDENTITY;



CREATE PROCEDURE [dbo].[sp_Weight_update]
	@WeightID			INT,
	@WeightDateTime	DATETIME,
	@Weight		INT, 
	@WeightLocation VARCHAR(200),
	@WeightComments	VARCHAR(2000)
AS
	
	UPDATE Weight SET
		WeightDateTime = @WeightDateTime, 
		Weight = @Weight,
		WeightLocation = @WeightLocation,
		WeightComments = @WeightComments
	WHERE
		WeightID = @WeightID;



