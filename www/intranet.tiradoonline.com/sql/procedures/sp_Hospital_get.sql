IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Hospital_get' AND TYPE = 'P')
	DROP PROCEDURE sp_Hospital_get;
GO


CREATE PROCEDURE sp_Hospital_get
	@UserID				INT,
	@HospitalID			INT = NULL
AS
	
	IF @HospitalID IS NULL
		BEGIN
			SELECT
				*,
				HospitalStateName = (SELECT StateAbbr FROM States WHERE StateID = Hospital.HospitalStateID)
			FROM
				Hospital
			WHERE
				UserID = @UserID
			ORDER BY
				HospitalName;
		END
	ELSE
		BEGIN
			SELECT
				*,
				HospitalStateName = (SELECT StateAbbr FROM States WHERE StateID = Hospital.HospitalStateID)
			FROM
				Hospital
			WHERE
				HospitalID = @HospitalID;
		END

GO

exec sp_Hospital_get 1001