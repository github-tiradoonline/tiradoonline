IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_delete' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_delete;
GO




CREATE PROCEDURE [dbo].[sp_Banking_delete]
	@BankingID			INT
AS
	
	DELETE FROM Banking WHERE BankingID = @BankingiD;




GO

