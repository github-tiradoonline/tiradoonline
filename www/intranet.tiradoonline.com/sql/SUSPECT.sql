EXEC sp_resetstatus tiradoonline;
ALTER DATABASE tiradoonline SET EMERGENCY
DBCC checkdb(tiradoonline)
ALTER DATABASE tiradoonline SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DBCC CheckDB (tiradoonline, REPAIR_ALLOW_DATA_LOSS)
ALTER DATABASE tiradoonline SET MULTI_USER
