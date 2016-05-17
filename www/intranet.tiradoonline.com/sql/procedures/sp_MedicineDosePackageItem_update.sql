IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineDosePackageItem_update' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineDosePackageItem_update;
GO



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



GO

