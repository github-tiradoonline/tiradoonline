IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'fn_GetFileNameFromPath' AND TYPE = 'FN')
	DROP FUNCTION fn_GetFileNameFromPath;
GO


CREATE FUNCTION fn_GetFileNameFromPath(@v_FullFileName VARCHAR(1000))
	RETURNS VARCHAR(1000)
AS

	BEGIN


		DECLARE @ReturnCode VARCHAR(1000);

		SET @ReturnCode = REVERSE(@v_FullFileName);
		SET @ReturnCode = REVERSE(SUBSTRING(@ReturnCode, 0, CHARINDEX('\', @ReturnCode)));
	
		RETURN @ReturnCode;
	END

GO


declare @filename   varchar(1000)
set @filename = 'c:\storage\music\Bodyguard, The - Soundtrack\Bodyguard, The - Soundtrack - Peace, Love And Understanding (What''s So Funny ''Bout) - Curtis Stigers.mp3';

select 
	dbo.fn_GetDirectoryNameFromPath(@filename),
	dbo.fn_GetFileNameFromPath(@filename)

