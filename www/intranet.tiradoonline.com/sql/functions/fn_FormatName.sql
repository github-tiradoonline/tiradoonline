IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'fn_FormatName' AND TYPE = 'FN')
	DROP FUNCTION fn_FormatName;
GO


CREATE FUNCTION fn_FormatName(@v_FirstName VARCHAR(100), @v_LastName VARCHAR(100), @v_CompanyName VARCHAR(100))
	RETURNS VARCHAR(100)
AS

	BEGIN

		DECLARE @ReturnCode VARCHAR(100);

		IF (@v_FirstName <> '' AND @v_LastName <> '')
			SET @ReturnCode = @v_LastName + ', ' + @v_FirstName
		ELSE IF(@v_FirstName <> '')
			SET @ReturnCode = @v_FirstName
		ELSE IF(@v_LastName <> '')
			SET @ReturnCode = @v_LastName
		ELSE
			SET @ReturnCode = @v_CompanyName
	
		RETURN @ReturnCode;
	END

GO


SELECT dbo.fn_FormatName('', '', 'tiradoonline.com');
