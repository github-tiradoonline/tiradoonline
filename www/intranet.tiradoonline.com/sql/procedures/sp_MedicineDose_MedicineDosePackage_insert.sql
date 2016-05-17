IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineDose_MedicineDosePackage_insert' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineDose_MedicineDosePackage_insert;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MedicineDose_MedicineDosePackage_insert]
	@MedicineDosePackageID		INT,
	@MedicineDoseDateTime		DATETIME
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO MedicineDose
		(MedicineID, MedicineDoseDateTime, Amount, MedicineDoseDescription)

	SELECT 
		b.MedicineID, 
		MedicineDoseDateTime = @MedicineDoseDateTime, 
		b.Amount, 
		b.Description AS MedicineDoseDescription
	FROM 
		MedicineDosePackage a, 
		MedicineDosePackageItem b 
	WHERE 
		a.MedicineDosePackageID = b.MedicineDosePackageID AND 
		a.MedicineDosePackageID = @MedicineDosePackageID;
	

		
END



GO

