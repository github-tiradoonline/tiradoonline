IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineDosePackage_insert' AND TYPE = 'P')
DROP PROCEDURE sp_MedicineDosePackage_insert;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MedicineDosePackage_insert]
	@UserID				INT,
	@MedicineDosePackageName	VARCHAR(100)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO MedicineDosePackage
		(UserID, MedicineDosePackageName)
	VALUES
		(@UserID, @MedicineDosePackageName);

	SELECT @@IDENTITY;
		
END



GO

