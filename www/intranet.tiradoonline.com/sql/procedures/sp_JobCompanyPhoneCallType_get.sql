IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompanyPhoneCallType_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompanyPhoneCallType_get;
GO




CREATE PROCEDURE [dbo].[sp_JobCompanyPhoneCallType_get]
AS


	SELECT
		JobCompanyPhoneCallTypeID,
		JobCompanyPhoneCallType
	FROM
		JobCompanyPhoneCallType
	ORDER BY
		JobCompanyPhoneCallType;
	


GO

