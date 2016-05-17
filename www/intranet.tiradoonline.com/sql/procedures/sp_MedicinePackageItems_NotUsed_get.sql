IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicinePackageItems_NotUsed_get' AND TYPE = 'P')
DROP PROCEDURE sp_MedicinePackageItems_NotUsed_get;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MedicinePackageItems_NotUsed_get]
	@MedicineDosePackageID			INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		MedicineID,
		MedicineName =
			CASE 
				WHEN GenericName <> '' THEN
					MedicineName + ' (' + GenericName + ')'
				ELSE
					MedicineName
			END
	FROM
		Medicine
	WHERE
		MedicineID NOT IN (
			SELECT 
				MedicineID 
			FROM 
				MedicineDosePackageItem 
			WHERE 
				MedicineDosePackageID = @MedicineDosePackageID
		)
	ORDER BY
		MedicineName
	
		
END



GO

