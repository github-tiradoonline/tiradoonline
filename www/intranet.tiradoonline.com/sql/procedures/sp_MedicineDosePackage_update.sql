IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineDosePackage_update' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineDosePackage_update;
GO



CREATE PROCEDURE [dbo].[sp_MedicineDosePackage_update] 
	@MedicineDosePackageID			INT,
	@MedicineDosePackageName		VARCHAR(100)
AS
	
	UPDATE MedicineDosePackage SET
		MedicineDosePackageName = @MedicineDosePackageName
	WHERE 
		MedicineDosePackageID = @MedicineDosePackageID;



GO

