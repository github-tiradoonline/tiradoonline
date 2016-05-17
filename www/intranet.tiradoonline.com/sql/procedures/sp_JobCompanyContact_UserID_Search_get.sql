IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompanyContact_UserID_Search_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompanyContact_UserID_Search_get;
GO



CREATE PROCEDURE [dbo].[sp_JobCompanyContact_UserID_Search_get]
	@UserID				INT,
	@JobSearchString			VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @JobSearchString = REPLACE(@JobSearchString, "'", "''");
	SET @JobSearchString = '''%' + UPPER(@JobSearchString) + '%''';
	DECLARE @JobSearchString2		VARCHAR(50);

	IF @JobSearchString <> ''
		SET @JobSearchString2 = '''%' + UPPER(dbo.fn_RemoveAlphaCharacters(@JobSearchString)) + '%''';

	DECLARE @SQLSTRING			NVARCHAR(3000);

	SET @SQLSTRING = '
	SELECT 
		a.*,
		b.*, 
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = b.JobCompanyID),
		TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = b.JobCompanyID),
		TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = b.JobCompanyID)
	FROM 
		JobCompany a,
		JobCompanyContact b

	WHERE 
		a.JobCompanyID = b.JobCompanyID AND
		a.UserID = ' + CONVERT(VARCHAR, @UserID) + ' AND
		(
			UPPER(b.JobCompanyContactFirstName) LIKE ' + @JobSearchString + ' OR
			UPPER(b.JobCompanyContactLastName) LIKE ' + @JobSearchString + ' OR
			UPPER(b.JobCompanyContactEmail) LIKE ' + @JobSearchString;

	IF @JobSearchString2 <> '''%%'''
		BEGIN
			SET @SQLSTRING = @SQLSTRING + ' OR UPPER(dbo.fn_RemoveAlphaCharacters(b.JobCompanyContactWorkPhone)) LIKE ' + @JobSearchString2 + ' OR
			UPPER(dbo.fn_RemoveAlphaCharacters(b.JobCompanyContactFax)) LIKE ' + @JobSearchString2 + ' OR
			UPPER(dbo.fn_RemoveAlphaCharacters(b.JobCompanyContactCellPhone)) LIKE ' + @JobSearchString2;
		END
	SET @SQLSTRING = @SQLSTRING + ')
	ORDER BY 
		a.JobCompanyName;';

	EXEC sp_executesql @SQLSTRING;
END




GO

