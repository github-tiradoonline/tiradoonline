IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_administration_schema_objectid' AND TYPE = 'P')
DROP PROCEDURE sp_administration_schema_objectid;
GO


CREATE PROCEDURE [dbo].[sp_administration_schema_objectid]
	@ObjectID	INT
AS
	DECLARE @SQL		VARCHAR(100)

	SET @SQL = 'sp_helptext ' + OBJECT_NAME(@ObjectID)
	--PRINT @SQL
	EXEC(@SQL)


GO

