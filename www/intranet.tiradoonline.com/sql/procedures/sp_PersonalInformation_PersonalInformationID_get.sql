IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_PersonalInformation_PersonalInformationID_get' AND TYPE = 'P')
DROP PROCEDURE sp_PersonalInformation_PersonalInformationID_get;
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_PersonalInformation_PersonalInformationID_get]
	@PersonalInformationID				INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT * FROM PersonalInformation WHERE PersonalInformationID = @PersonalInformationID;

END





GO

