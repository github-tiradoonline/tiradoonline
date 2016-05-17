IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_SickDays_CompanyID_SickDate' AND TYPE = 'P')
DROP PROCEDURE sp_SickDays_CompanyID_SickDate;
GO


CREATE PROCEDURE [dbo].[sp_SickDays_CompanyID_SickDate]
	@CompanyID	INT,
	@SickDate	SMALLDATETIME
AS
	SELECT 
		SickDayID 
	FROM 
		SickDays 
	WHERE 
		CompanyID = @CompanyID AND 
		SickDate = @SickDate


GO

