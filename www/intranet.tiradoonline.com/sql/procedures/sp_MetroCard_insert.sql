IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MetroCard_insert' AND TYPE = 'P')
DROP PROCEDURE sp_MetroCard_insert;
GO



CREATE PROCEDURE sp_MetroCard_insert
	@MetroCardProgramID		INT,
	@MetroCardDate			DATETIME
AS
	
	INSERT INTO MetroCard 
		(MetroCardProgramID, MetroCardDate)
	VALUES
		(@MetroCardProgramID, @MetroCardDate);

	SELECT @@IDENTITY;



GO

