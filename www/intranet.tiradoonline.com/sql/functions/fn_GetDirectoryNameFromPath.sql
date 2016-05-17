IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'fn_GetDirectoryNameFromPath' AND TYPE = 'FN')
	DROP FUNCTION fn_GetDirectoryNameFromPath;
GO


CREATE FUNCTION fn_GetDirectoryNameFromPath(@v_FullDirectoryName VARCHAR(1000))
	RETURNS VARCHAR(1000)
AS

	BEGIN


		DECLARE @ReturnCode VARCHAR(1000);
		DECLARE @ReturnIndex  	INT;
		
		SET @ReturnCode = REVERSE(@v_FullDirectoryName);
		SET @ReturnIndex = LEN(SUBSTRING(@ReturnCode, 0, CHARINDEX('\', @ReturnCode)));
		SET @ReturnCode = REVERSE(RIGHT(@ReturnCode, (LEN(@ReturnCode) - 1) - @ReturnIndex));
		RETURN @ReturnCode;
	END

GO


declare @filename   varchar(1000)
set @filename = 'c:\storage\music\Bodyguard, The - Soundtrack\Bodyguard, The - Soundtrack - Peace, Love And Understanding (What''s So Funny ''Bout) - Curtis Stigers.mp3';

select 
	dbo.fn_GetDirectoryNameFromPath(@filename),
	dbo.fn_GetFileNameFromPath(@filename)

