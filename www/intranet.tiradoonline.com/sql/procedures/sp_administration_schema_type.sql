IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_administration_schema_type' AND TYPE = 'P')
DROP PROCEDURE sp_administration_schema_type;
GO


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



GO

