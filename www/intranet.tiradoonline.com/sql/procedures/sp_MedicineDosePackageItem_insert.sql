IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineDosePackageItem_insert' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineDosePackageItem_insert;
GO



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



GO

