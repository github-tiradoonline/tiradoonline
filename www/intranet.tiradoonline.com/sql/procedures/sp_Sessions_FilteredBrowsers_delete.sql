IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Sessions_FilteredBrowsers_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_Sessions_FilteredBrowsers_delete;
GO

CREATE PROCEDURE sp_Sessions_FilteredBrowsers_delete
AS
	
	DELETE FROM 
		Sessions 
	WHERE 
		Browser IN 
			(SELECT Browser FROM FilteredBrowsers);

GO

EXEC sp_Sessions_FilteredBrowsers_delete