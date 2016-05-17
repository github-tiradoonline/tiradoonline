IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'FilteredIPAddresses' AND TYPE = 'U')
DROP TABLE FilteredIPAddresses;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'FilteredIPAddresses' AND TYPE = 'U')
	DROP TABLE FilteredIPAddresses;
GO

CREATE TABLE FilteredIPAddresses
(
	FilteredIPAddressID		IDENTITY (1001,1) INT  NOT NULL,
	Alias		 VARCHAR(50)  NOT NULL,
	IPAddress		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

