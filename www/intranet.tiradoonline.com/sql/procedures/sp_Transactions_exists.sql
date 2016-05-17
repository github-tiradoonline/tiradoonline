IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Transactions_exists' AND TYPE = 'P')
DROP PROCEDURE sp_Transactions_exists;
GO


CREATE PROCEDURE [dbo].[sp_Transactions_exists]
	@Description 	VARCHAR(50)
AS
	SELECT Description FROM Transactions where UPPER(Description) = UPPER(@Description);


GO

