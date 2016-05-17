IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineDosePackageItem_delete' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineDosePackageItem_delete;
GO



CREATE PROCEDURE [dbo].[sp_MedicineDosePackageItem_delete] 
	@MedicineDosePackageItemID			INT
AS
	
	DELETE FROM MedicineDosePackageItem WHERE MedicineDosePackageItemID = @MedicineDosePackageItemID;



GO

