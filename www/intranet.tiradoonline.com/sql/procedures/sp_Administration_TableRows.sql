IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Administration_TableRows' AND TYPE = 'P')
	DROP PROCEDURE sp_Administration_TableRows;
GO


CREATE PROCEDURE sp_Administration_TableRows
AS
	
	SELECT 
		OBJECT_NAME(object_id) TableName, 
		st.row_count as TotalRows
	FROM 
		sys.dm_db_partition_stats st
	WHERE 
		index_id < 2 
		and left(OBJECT_NAME(object_id), 3) <> 'sys'
	ORDER BY 
		st.row_count DESC
GO

EXEC sp_Administration_TableRows 
