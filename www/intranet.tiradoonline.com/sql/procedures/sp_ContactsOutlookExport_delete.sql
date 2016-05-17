IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ContactsOutlookExport_delete' AND TYPE = 'P')
DROP PROCEDURE sp_ContactsOutlookExport_delete;
GO



CREATE PROCEDURE [dbo].[sp_ContactsOutlookExport_delete]

AS 

	TRUNCATE TABLE ContactsOutlookExport;



GO

