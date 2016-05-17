EXEC sp_attach_db 'tiradoonline', 'D:\www\tiradoonline.com\intranet.tiradoonline.com\database\tiradoonline.mdf', 'D:\www\tiradoonline.com\intranet.tiradoonline.com\database\tiradoonline.ldf';
GO

EXEC sp_addlogin 'tiradoonline_user', 'tiradoonline', 'tiradoonline', @sid=0x44178F5E6921A94BA1307F3CC72A1632;
GO