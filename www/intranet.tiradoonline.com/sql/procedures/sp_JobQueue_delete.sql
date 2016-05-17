IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobQueue_delete' AND TYPE = 'P')
DROP PROCEDURE sp_JobQueue_delete;
GO



CREATE PROCEDURE [dbo].[sp_JobQueue_delete]
	@JobQueueID		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM JobQueue WHERE JobQueueID = @JobQueueID;
END




GO

