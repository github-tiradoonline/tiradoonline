IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineDosePackage_MedicineDosePackageID_get' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineDosePackage_MedicineDosePackageID_get;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MedicineDosePackage_MedicineDosePackageID_get]
	@MedicineDosePackageID		INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		a.MedicineDosePackageItemID,
		a.MedicineID, 
		Medicine =
			CASE 
				WHEN b.GenericName <> '' THEN
					b.MedicineName + ' (' + b.GenericName + ')'
				ELSE
					b.MedicineName
			END,
		a.Amount, 
		a.Description,
		Unit = (SELECT UnitName FROM Unit WHERE UnitID = b.UnitID)
	FROM 
		MedicineDosePackageItem a, 
		Medicine b
	WHERE 
		a.MedicineID = b.MedicineID AND 
		a.MedicineDosePackageID = @MedicineDosePackageID
	ORDER BY
		Medicine;
	

		
END



GO

exec sp_MedicineDosePackage_MedicineDosePackageID_get 1030