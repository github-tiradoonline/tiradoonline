IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_SickDays_insert' AND TYPE = 'P')
DROP PROCEDURE sp_SickDays_insert;
GO


CREATE PROCEDURE [dbo].[sp_SickDays_insert]
	@CompanyID	INT,
	@SickDate	SMALLDATETIME
AS
	INSERT INTO SickDays 
		(CompanyID, SickDate) 
	VALUES 
		(@CompanyID, @SickDate);


GO

