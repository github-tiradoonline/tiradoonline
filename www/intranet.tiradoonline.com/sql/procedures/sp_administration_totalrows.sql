IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_administration_totalrows' AND TYPE = 'P')
DROP PROCEDURE sp_administration_totalrows;
GO


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



GO

