USE tiradoonline;
GO

/**************************************************
***************** PhoneBillProvider ***********************
**************************************************/
IF OBJECT_ID('PhoneBillProvider') IS NOT NULL
	DROP TABLE PhoneBillProvider;
GO

CREATE TABLE PhoneBillProvider
(
	PhoneBillProviderID						INT IDENTITY(1001, 1) NOT NULL,
	UserID									INT NOT NULL,
	PhoneBillProviderName					VARCHAR(100) NOT NULL,
	create_dt								DATETIME DEFAULT GETDATE() NOT NULL
);
GO

ALTER TABLE PhoneBillProvider ADD CONSTRAINT PK_PhoneBillProvider PRIMARY KEY (PhoneBillProviderID);
GO

INSERT INTO PhoneBillProvider (UserID, PhoneBillProviderName) VALUES (1001, 'AT & T');
GO







/**************************************************
***************** PHONEBILL ***********************
**************************************************/
IF OBJECT_ID('PhoneBill') IS NOT NULL

	DROP TABLE PhoneBill;
GO

CREATE TABLE PhoneBill
(
	PhoneBillID						INT IDENTITY(1001, 1) NOT NULL,
	PhoneBillPhoneBillAccountID		INT NOT NULL,
	PhoneBillName					VARCHAR(100) NOT NULL,
	PhoneBillStartDate				DATETIME NOT NULL,
	PhoneBillEndDate				DATETIME NOT NULL,
	create_dt						DATETIME DEFAULT GETDATE() NOT NULL
);
GO

ALTER TABLE PhoneBill ADD CONSTRAINT PK_PhoneBill PRIMARY KEY (PhoneBillID);
GO

INSERT INTO PhoneBill (PhoneBillPhoneBillAccountID, PhoneBillName, PhoneBillStartDate, PhoneBillEndDate) VALUES (1001, 'December 2015', '11/12/15', '12/11/15');
GO







/***********************************************************
***************** PhoneBillSurchargesOtherFees *************
***********************************************************/
IF OBJECT_ID('PhoneBillSurchargesOtherFees') IS NOT NULL
	DROP TABLE PhoneBillSurchargesOtherFees;
GO

CREATE TABLE PhoneBillSurchargesOtherFees
(
	PhoneBillSurchargesOtherFeesID			INT IDENTITY(1001, 1) NOT NULL,
	PhoneBillPhoneBillAccountID			INT NOT NULL,
	AdministrativeFee						NUMERIC(9,2) DEFAULT 0.00 NULL,
	CountyGrossReceipts						NUMERIC(9,2) DEFAULT 0.00 NULL,
	FederalUniversalServiceCharge			NUMERIC(9,2) DEFAULT 0.00 NULL,
	MTATelecom								NUMERIC(9,2) DEFAULT 0.00 NULL,
	RegulartoryCostRecoveryCharge			NUMERIC(9,2) DEFAULT 0.00 NULL,
	StateTelecommunicationsExcise			NUMERIC(9,2) DEFAULT 0.00 NULL,
	create_dt					DATETIME DEFAULT GETDATE() NOT NULL
);
GO

ALTER TABLE PhoneBillSurchargesOtherFees ADD CONSTRAINT PK_PhoneBillSurchargesOtherFees PRIMARY KEY (PhoneBillSurchargesOtherFeesID);
GO

INSERT INTO PhoneBillSurchargesOtherFees 
	(PhoneBillPhoneBillAccountID, AdministrativeFee, CountyGrossReceipts, FederalUniversalServiceCharge, MTATelecom, RegulartoryCostRecoveryCharge, StateTelecommunicationsExcise) 
VALUES 
	(1001, .61, .36, .89, .13, .98, .53);
GO




/***********************************************************
***************** PhoneBillGovernmentFeesTaxes *************
***********************************************************/
IF OBJECT_ID('PhoneBillGovernmentFeesTaxes') IS NOT NULL
	DROP TABLE PhoneBillGovernmentFeesTaxes;
GO

CREATE TABLE PhoneBillGovernmentFeesTaxes
(
	PhoneBillGovernmentFeesTaxesID			INT IDENTITY(1001, 1) NOT NULL,
	PhoneBillPhoneBillAccountID			INT NOT NULL,
	ServiceFee911							NUMERIC(9,2) DEFAULT 0.00 NULL,
	CityDistrictSalesTax					NUMERIC(9,2) DEFAULT 0.00 NULL,
	CitySalesTax							NUMERIC(9,2) DEFAULT 0.00 NULL,
	LocalWireless911Surcharge				NUMERIC(9,2) DEFAULT 0.00 NULL,
	NYSalesTax								NUMERIC(9,2) DEFAULT 0.00 NULL,
	create_dt								DATETIME DEFAULT GETDATE() NOT NULL
);
GO

ALTER TABLE PhoneBillGovernmentFeesTaxes ADD CONSTRAINT PK_PhoneBillGovernmentFeesTaxes PRIMARY KEY (PhoneBillGovernmentFeesTaxesID);
GO

INSERT INTO PhoneBillGovernmentFeesTaxes 
	(PhoneBillPhoneBillAccountID, ServiceFee911, CityDistrictSalesTax, CitySalesTax, LocalWireless911Surcharge, NYSalesTax)
VALUES
	(1001, 1.20, .06, .83, .30, .74);
GO




/***********************************************************
***************** PhoneBillMonthlyCharges ******************
***********************************************************/
IF OBJECT_ID('PhoneBillMonthlyCharges') IS NOT NULL
	DROP TABLE PhoneBillMonthlyCharges;
GO

CREATE TABLE PhoneBillMonthlyCharges
(
	PhoneBillMonthlyChargesID				INT IDENTITY(1001, 1) NOT NULL,
	PhoneBillPhoneBillAccountID			INT NOT NULL,
	MonthlyChargeName						VARCHAR(100) NOT NULL,
	MonthlyChargeValue						NUMERIC(9, 2) NOT NULL,
	create_dt								DATETIME DEFAULT GETDATE() NOT NULL
);
GO

ALTER TABLE PhoneBillMonthlyCharges ADD CONSTRAINT PK_PhoneBillMonthlyCharges PRIMARY KEY (PhoneBillMonthlyChargesID);
GO

INSERT INTO PhoneBillMonthlyCharges (PhoneBillPhoneBillAccountID, MonthlyChargeName, MonthlyChargeValue) VALUES (1001, 'Mobile Share Value Smartphone 4G LTE w/ VVM', '40.00');
INSERT INTO PhoneBillMonthlyCharges (PhoneBillPhoneBillAccountID, MonthlyChargeName, MonthlyChargeValue) VALUES (1001, 'Discount for Mobile Share Value Savings', '-25.00');
INSERT INTO PhoneBillMonthlyCharges (PhoneBillPhoneBillAccountID, MonthlyChargeName, MonthlyChargeValue) VALUES (1001, 'International Long Distance - Standard', '0.00');
INSERT INTO PhoneBillMonthlyCharges (PhoneBillPhoneBillAccountID, MonthlyChargeName, MonthlyChargeValue) VALUES (1001, 'Mobile Insurance Premium', '6.99');
INSERT INTO PhoneBillMonthlyCharges (PhoneBillPhoneBillAccountID, MonthlyChargeName, MonthlyChargeValue) VALUES (1001, 'Mobile Protection Pack - Support', '3.00');
INSERT INTO PhoneBillMonthlyCharges (PhoneBillPhoneBillAccountID, MonthlyChargeName, MonthlyChargeValue) VALUES (1001, 'Installment 14 of 24', '27.09');
GO




/***********************************************************
***************** PhoneBillMonthlyDataCharges ******************
***********************************************************/
IF OBJECT_ID('PhoneBillMonthlyDataCharges') IS NOT NULL
	DROP TABLE PhoneBillMonthlyDataCharges;
GO

CREATE TABLE PhoneBillMonthlyDataCharges
(
	PhoneBillMonthlyDataChargesID				INT IDENTITY(1001, 1) NOT NULL,
	PhoneBillPhoneBillAccountID				INT NOT NULL,
	MonthlyDataChargeAmount						NUMERIC(9, 2) NOT NULL,
	MonthlyDataChargeMaxMB						INT NOT NULL,
	MonthlyDataChargeUsedMB						INT NOT NULL,
	create_dt									DATETIME DEFAULT GETDATE() NOT NULL
);
GO

ALTER TABLE PhoneBillMonthlyDataCharges ADD CONSTRAINT PK_PhoneBillMonthlyDataCharges PRIMARY KEY (PhoneBillMonthlyDataChargesID);
GO

INSERT INTO PhoneBillMonthlyDataCharges (PhoneBillPhoneBillAccountID, MonthlyDataChargeAmount, MonthlyDataChargeMaxMB, MonthlyDataChargeUsedMB) VALUES (1001, 130, 30720, 3179);
GO








/**************************************************
***************** DEVICE **************************
**************************************************/
IF OBJECT_ID('PhoneDevice') IS NOT NULL
	DROP TABLE PhoneDevice;
GO

CREATE TABLE PhoneDevice
(
	PhoneDeviceID							INT IDENTITY(1001, 1) NOT NULL,
	PhoneBillPhoneBillAccountID				INT NOT NULL,
	PhoneDeviceName							VARCHAR(100) NOT NULL,
	create_dt								DATETIME DEFAULT GETDATE() NOT NULL
);
GO

ALTER TABLE PhoneDevice ADD CONSTRAINT PK_PhoneDevice PRIMARY KEY (PhoneDeviceID);
GO

INSERT INTO PhoneDevice (PhoneBillPhoneBillAccountID, PhoneDeviceName) VALUES (1001, 'Cell Phone');
INSERT INTO PhoneDevice (PhoneBillPhoneBillAccountID, PhoneDeviceName) VALUES (1001, 'Tablet');
GO










/**************************************************
***************** PhoneBillAccount ****************
**************************************************/
IF OBJECT_ID('PhoneBillAccount') IS NOT NULL
	DROP TABLE PhoneBillAccount;
GO

CREATE TABLE PhoneBillAccount
(
	PhoneBillAccountID				INT IDENTITY(1001, 1) NOT NULL,
	PhoneBProviderID				INT NOT NULL,
	PhoneDeviceID					INT NOT NULL,
	PhoneBillAccountName			VARCHAR(100) NOT NULL,
	PhoneBillAccountPhoneNumber		VARCHAR(100) NOT NULL,
	create_dt						DATETIME DEFAULT GETDATE() NOT NULL
);
GO

ALTER TABLE PhoneBillAccount ADD CONSTRAINT PK_PhoneBillAccount PRIMARY KEY (PhoneBillAccountID);
GO

INSERT INTO PhoneBillAccount (PhoneBProviderID, PhoneDeviceID, PhoneBillAccountName, PhoneBillAccountPhoneNumber) VALUES (1001, 1001, 'Teddy Cell Phone', '(347) 414-1284');
INSERT INTO PhoneBillAccount (PhoneBProviderID, PhoneDeviceID, PhoneBillAccountName, PhoneBillAccountPhoneNumber) VALUES (1001, 1002, 'Teddy Tablet', '(609) 907-2981');
INSERT INTO PhoneBillAccount (PhoneBProviderID, PhoneDeviceID, PhoneBillAccountName, PhoneBillAccountPhoneNumber) VALUES (1001, 1001, 'Chris Cell Phone', '(347) 468-2925');
INSERT INTO PhoneBillAccount (PhoneBProviderID, PhoneDeviceID, PhoneBillAccountName, PhoneBillAccountPhoneNumber) VALUES (1001, 1001, 'Mom Cell Phone', '(917) 957-3223');
INSERT INTO PhoneBillAccount (PhoneBProviderID, PhoneDeviceID, PhoneBillAccountName, PhoneBillAccountPhoneNumber) VALUES (1001, 1002, 'Mom LG Tablet', '(646) 467-4193');
INSERT INTO PhoneBillAccount (PhoneBProviderID, PhoneDeviceID, PhoneBillAccountName, PhoneBillAccountPhoneNumber) VALUES (1001, 1002, 'Mom IPAD Tablet', '(718) 710-1163');
GO








/**************************************************
***************** PhoneBillPhoneBillAccount ***********
**************************************************/
IF OBJECT_ID('PhoneBillPhoneBillAccount') IS NOT NULL
	DROP TABLE PhoneBillPhoneBillAccount;
GO

CREATE TABLE PhoneBillPhoneBillAccount
(
	PhoneBillPhoneBillAccountID		INT IDENTITY(1001, 1) NOT NULL,
	PhoneBillID						INT NOT NULL,
	PhoneBillAccountID				INT NOT NULL,
	create_dt						DATETIME DEFAULT GETDATE() NOT NULL
);
GO

ALTER TABLE PhoneBillPhoneBillAccount ADD CONSTRAINT PK_PhoneBillPhoneBillAccount PRIMARY KEY (PhoneBillPhoneBillAccountID);
GO

INSERT INTO PhoneBillPhoneBillAccount (PhoneBillID, PhoneBillAccountID) VALUES (1001, 1001);
INSERT INTO PhoneBillPhoneBillAccount (PhoneBillID, PhoneBillAccountID) VALUES (1001, 1002);
INSERT INTO PhoneBillPhoneBillAccount (PhoneBillID, PhoneBillAccountID) VALUES (1001, 1003);
INSERT INTO PhoneBillPhoneBillAccount (PhoneBillID, PhoneBillAccountID) VALUES (1001, 1004);
INSERT INTO PhoneBillPhoneBillAccount (PhoneBillID, PhoneBillAccountID) VALUES (1001, 1005);
INSERT INTO PhoneBillPhoneBillAccount (PhoneBillID, PhoneBillAccountID) VALUES (1001, 1006);
GO










/**************************************************
***************** PhoneBillProvider ****************
**************************************************/
IF OBJECT_ID('sp_PhoneBillProvider_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillProvider_get;
GO

CREATE PROCEDURE sp_PhoneBillProvider_get
	@UserID			INT
AS

	SELECT
		a.*
	FROM
		PhoneBillProvider a
	WHERE 
		a.UserID = @UserID
	ORDER BY
		a.PhoneBillProviderName;

GO

EXEC sp_PhoneBillProvider_get 1001;









/**************************************************
***************** sp_PhoneBill_get ****************
**************************************************/
IF OBJECT_ID('sp_PhoneBill_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneBill_get;
GO

CREATE PROCEDURE sp_PhoneBill_get
	@PhoneBillPhoneBillAccountID			INT
AS

	SELECT
		a.*
	FROM
		PhoneBill a
	WHERE 
		a.PhoneBillPhoneBillAccountID = @PhoneBillPhoneBillAccountID
	ORDER BY
		a.PhoneBillStartDate;

GO

EXEC sp_PhoneBill_get 1001;










/**************************************************
***************** sp_PhoneBillSurchargesOtherFees_get ****************
**************************************************/
IF OBJECT_ID('sp_PhoneBillSurchargesOtherFees_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillSurchargesOtherFees_get;
GO

CREATE PROCEDURE sp_PhoneBillSurchargesOtherFees_get
	@PhoneBillPhoneBillAccountID		INT
AS

	SELECT
		a.*
	FROM
		PhoneBillSurchargesOtherFees a
	WHERE 
		a.PhoneBillPhoneBillAccountID = @PhoneBillPhoneBillAccountID

GO

EXEC sp_PhoneBillSurchargesOtherFees_get 1001;










/*********************************************************************
***************** sp_PhoneBillGovernmentFeesTaxes_get ****************
******************************************************************/
IF OBJECT_ID('sp_PhoneBillGovernmentFeesTaxes_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillGovernmentFeesTaxes_get;
GO

CREATE PROCEDURE sp_PhoneBillGovernmentFeesTaxes_get
	@PhoneBillPhoneBillAccountID			INT
AS

	SELECT
		a.*
	FROM
		PhoneBillGovernmentFeesTaxes a
	WHERE 
		a.PhoneBillPhoneBillAccountID = @PhoneBillPhoneBillAccountID;

GO

EXEC sp_PhoneBillGovernmentFeesTaxes_get 1001;
GO











/*********************************************************************
***************** sp_PhoneBillMonthlyCharges_get ****************
******************************************************************/
IF OBJECT_ID('sp_PhoneBillMonthlyCharges_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillMonthlyCharges_get;
GO

CREATE PROCEDURE sp_PhoneBillMonthlyCharges_get
	@PhoneBillPhoneBillAccountID			INT
AS

	SELECT
		a.*
	FROM
		PhoneBillMonthlyCharges a
	WHERE 
		a.PhoneBillPhoneBillAccountID = @PhoneBillPhoneBillAccountID;

GO

EXEC sp_PhoneBillMonthlyCharges_get 1001;
GO










/**************************************************
***************** sp_PhoneBillMonthlyDataCharges_get ****************
**************************************************/
IF OBJECT_ID('sp_PhoneBillMonthlyDataCharges_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillMonthlyDataCharges_get;
GO

CREATE PROCEDURE sp_PhoneBillMonthlyDataCharges_get
	@PhoneBillPhoneBillAccountID		INT
AS

	SELECT
		a.*
	FROM
		PhoneBillMonthlyDataCharges a
	WHERE 
		a.PhoneBillPhoneBillAccountID = @PhoneBillPhoneBillAccountID

GO

EXEC sp_PhoneBillMonthlyDataCharges_get 1001;












/**************************************************
***************** sp_PhoneDevice_get **************
**************************************************/
IF OBJECT_ID('sp_PhoneDevice_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneDevice_get;
GO

CREATE PROCEDURE sp_PhoneDevice_get
	@PhoneBillPhoneBillAccountID			INT
AS

	SELECT
		a.PhoneDeviceID,
		a.PhoneDeviceName
	FROM
		PhoneDevice a
	WHERE 
		a.PhoneBillPhoneBillAccountID = @PhoneBillPhoneBillAccountID
	ORDER BY
		a.PhoneDeviceName;

GO

EXEC sp_PhoneDevice_get 1001;
GO







/**************************************************
***************** sp_PhoneBill_PhoneBillID_get ****
**************************************************/
IF OBJECT_ID('sp_PhoneBill_PhoneBillID_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneBill_PhoneBillID_get;
GO

CREATE PROCEDURE sp_PhoneBill_PhoneBillID_get
	@PhoneBillID			INT
AS

	SELECT
		a.*
	FROM
		PhoneBill a
	WHERE 
		a.PhoneBillID = @PhoneBillID;

GO

EXEC sp_PhoneBill_PhoneBillID_get 1001








/**************************************************
***************** sp_PhoneBillAccount_update ******
**************************************************/
IF OBJECT_ID('sp_PhoneBill_insert') IS NOT NULL
	DROP PROCEDURE sp_PhoneBill_insert;
GO

CREATE PROCEDURE sp_PhoneBill_insert
	@PhoneBillPhoneBillAccountID							INT,
	@PhoneBillName					VARCHAR(100),
	@PhoneBillStartDate				DATETIME,
	@PhoneBillEndDate				DATETIME
AS

		INSERT INTO PhoneBill
			(PhoneBillPhoneBillAccountID, PhoneBillName, PhoneBillStartDate, PhoneBillEndDate)
		VALUES
			(@PhoneBillPhoneBillAccountID, @PhoneBillName, @PhoneBillStartDate, @PhoneBillEndDate);

GO










/**************************************************
***************** sp_PhoneBillAccount_update ******
**************************************************/
IF OBJECT_ID('sp_PhoneBill_update') IS NOT NULL
	DROP PROCEDURE sp_PhoneBill_update;
GO

CREATE PROCEDURE sp_PhoneBill_update
	@PhoneBillID					INT,
	@PhoneBillName					VARCHAR(100),
	@PhoneBillStartDate				DATETIME,
	@PhoneBillEndDate				DATETIME
AS

		UPDATE PhoneBill SET
			PhoneBillName = @PhoneBillName,
			PhoneBillStartDate = @PhoneBillStartDate,
			PhoneBillEndDate = @PhoneBillEndDate
		WHERE	
			PhoneBillID = @PhoneBillID;

GO










/**************************************************
***************** sp_PhoneBillAccount_get *********
**************************************************/
IF OBJECT_ID('sp_PhoneBillAccount_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillAccount_get;
GO

CREATE PROCEDURE sp_PhoneBillAccount_get
	@PhoneBProviderID			INT
AS

	SELECT
		Device = (SELECT PhoneDeviceName FROM PhoneDevice WHERE PhoneDeviceID = a.PhoneDeviceID),
		a.*
	FROM
		PhoneBillAccount a
	WHERE 
		a.PhoneBProviderID = @PhoneBProviderID
	ORDER BY
		a.PhoneBillAccountName;

GO

EXEC sp_PhoneBillAccount_get 1001
GO








/**************************************************
***************** sp_PhoneBillAccount_insert ******
**************************************************/
IF OBJECT_ID('sp_PhoneBillAccount_insert') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillAccount_insert;
GO

CREATE PROCEDURE sp_PhoneBillAccount_insert
	@PhoneBProviderID		INT,
	@PhoneDeviceID						INT,
	@PhoneBillAccountName				VARCHAR(100),
	@PhoneBillAccountPhoneNumber		VARCHAR(100)
AS

		INSERT INTO PhoneBillAccount
			(PhoneBProviderID, PhoneDeviceID, PhoneBillAccountName, PhoneBillAccountPhoneNumber)
		VALUES
			(@PhoneBProviderID, @PhoneDeviceID, @PhoneBillAccountName, dbo.fn_FormatPhoneNumber(@PhoneBillAccountPhoneNumber))

GO










/**************************************************
***************** sp_PhoneBillAccount_update ******
**************************************************/
IF OBJECT_ID('sp_PhoneBillAccount_update') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillAccount_update;
GO

CREATE PROCEDURE sp_PhoneBillAccount_update
	@PhoneBillAccountID					INT,
	@PhoneDeviceID						INT,
	@PhoneBillAccountName				VARCHAR(100),
	@PhoneBillAccountPhoneNumber		VARCHAR(100)
AS

		UPDATE PhoneBillAccount SET
			PhoneDeviceID = @PhoneDeviceID,
			PhoneBillAccountName = @PhoneBillAccountName,
			PhoneBillAccountPhoneNumber = dbo.fn_FormatPhoneNumber(@PhoneBillAccountPhoneNumber)
		WHERE	
			PhoneBillAccountID = @PhoneBillAccountID;

GO











/*******************************************************************************
***************** sp_PhoneBillAccount_PhoneBillAccountID_get *******************
*******************************************************************************/
IF OBJECT_ID('sp_PhoneBillAccount_PhoneBillAccountID_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillAccount_PhoneBillAccountID_get;
GO

CREATE PROCEDURE sp_PhoneBillAccount_PhoneBillAccountID_get
	@PhoneBillAccountID			INT
AS

	SELECT
		a.*
	FROM
		PhoneBillAccount a
	WHERE 
		a.PhoneBillAccountID = @PhoneBillAccountID

GO

EXEC sp_PhoneBillAccount_PhoneBillAccountID_get 1001









/*******************************************************************************
***************** sp_PhoneBillPhoneBillAccount_PhoneBillID_get *******************
*******************************************************************************/
IF OBJECT_ID('sp_PhoneBillPhoneBillAccount_PhoneBillID_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillPhoneBillAccount_PhoneBillID_get;
GO

CREATE PROCEDURE sp_PhoneBillPhoneBillAccount_PhoneBillID_get
	@PhoneBillID							INT
AS
	DECLARE @MonthlyChargeValue		NUMERIC(9,2);
	SELECT @MonthlyChargeValue = SUM(MonthlyChargeValue) FROM PhoneBillPhoneBillAccount a, PhoneBillMonthlyCharges b WHERE a.PhoneBillPhoneBillAccountID = b.PhoneBillPhoneBillAccountID AND a.PhoneBillID = @PhoneBillID;
	PRINT CONVERT(VARCHAR, @MonthlyChargeValue);

	SELECT
		a.*,
		b.*,
		c.PhoneDeviceName,
		PhoneBillTotal = (
						  SELECT 
								d.AdministrativeFee +
								d.CountyGrossReceipts +
								d.FederalUniversalServiceCharge +
								d.MTATelecom +			
								d.RegulartoryCostRecoveryCharge +
								d.StateTelecommunicationsExcise + 
								e.ServiceFee911 + 
								e.CityDistrictSalesTax + 
								e.CitySalesTax + 
								e.LocalWireless911Surcharge + 
								e.NYSalesTax + 
								@MonthlyChargeValue
						  FROM		
								PhoneBillSurchargesOtherFees d,
								PhoneBillGovernmentFeesTaxes e
					      WHERE	
								a.PhoneBillPhoneBillAccountID = d.PhoneBillPhoneBillAccountID
								AND a.PhoneBillPhoneBillAccountID = e.PhoneBillPhoneBillAccountID
						)											
	FROM
		PhoneBillPhoneBillAccount a,
		PhoneBillAccount b,
		PhoneDevice c
	WHERE 
		a.PhoneBillAccountID = b.PhoneBillAccountID
		AND b.PhoneDeviceID = c.PhoneDeviceID
		AND a.PhoneBillID = @PhoneBillID

GO

EXEC sp_PhoneBillPhoneBillAccount_PhoneBillID_get 1001;











/*******************************************************************************
***************** sp_PhoneBillPhoneBillAccount_PhoneBillPhoneBillAccountID_get *******************
*******************************************************************************/
IF OBJECT_ID('sp_PhoneBillPhoneBillAccount_PhoneBillPhoneBillAccountID_SUM_get') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillPhoneBillAccount_PhoneBillPhoneBillAccountID_SUM_get;
GO

CREATE PROCEDURE sp_PhoneBillPhoneBillAccount_PhoneBillPhoneBillAccountID_SUM_get
	@PhoneBillPhoneBillAccountID							INT
AS

	DECLARE @MonthlyChargeValue		NUMERIC(9,2);
	SELECT @MonthlyChargeValue = SUM(MonthlyChargeValue) FROM PhoneBillPhoneBillAccount a, PhoneBillMonthlyCharges b WHERE a.PhoneBillPhoneBillAccountID = b.PhoneBillPhoneBillAccountID AND a.PhoneBillPhoneBillAccountID = @PhoneBillPhoneBillAccountID;
	PRINT CONVERT(VARCHAR, @MonthlyChargeValue);

	SELECT
		PhoneBillTotal = ISNULL((
						  SELECT 
								d.AdministrativeFee +
								d.CountyGrossReceipts +
								d.FederalUniversalServiceCharge +
								d.MTATelecom +			
								d.RegulartoryCostRecoveryCharge +
								d.StateTelecommunicationsExcise + 
								e.ServiceFee911 + 
								e.CityDistrictSalesTax + 
								e.CitySalesTax + 
								e.LocalWireless911Surcharge + 
								e.NYSalesTax + 
								@MonthlyChargeValue
						  FROM		
								PhoneBillSurchargesOtherFees d,
								PhoneBillGovernmentFeesTaxes e
					      WHERE	
								a.PhoneBillPhoneBillAccountID = d.PhoneBillPhoneBillAccountID
								AND a.PhoneBillPhoneBillAccountID = e.PhoneBillPhoneBillAccountID
						), 0.00)											
	FROM
		PhoneBillPhoneBillAccount a,
		PhoneBillAccount b,
		PhoneDevice c
	WHERE 
		a.PhoneBillAccountID = b.PhoneBillAccountID
		AND b.PhoneDeviceID = c.PhoneDeviceID
		AND a.PhoneBillPhoneBillAccountID = @PhoneBillPhoneBillAccountID;


GO

EXEC sp_PhoneBillPhoneBillAccount_PhoneBillPhoneBillAccountID_SUM_get 1002;














/*******************************************************************************
***************** sp_PhoneBillMonthlyCharges_insert *******************
*******************************************************************************/
IF OBJECT_ID('sp_PhoneBillMonthlyCharges_insert') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillMonthlyCharges_insert;
GO

CREATE PROCEDURE sp_PhoneBillMonthlyCharges_insert
	@PhoneBillPhoneBillAccountID			INT
AS

	BEGIN TRANSACTION tranMonthlyCharges

		INSERT INTO PhoneBillSurchargesOtherFees
			(PhoneBillPhoneBillAccountID)
		VALUES
			(@PhoneBillPhoneBillAccountID);

		INSERT INTO PhoneBillGovernmentFeesTaxes
			(PhoneBillPhoneBillAccountID)
		VALUES
			(@PhoneBillPhoneBillAccountID);

	IF @@ERROR = 0
		COMMIT TRANSACTION tranMonthlyCharges;
	ELSE
		ROLLBACK TRANSACTION tranMonthlyCharges;

GO










/*******************************************************************************
***************** sp_PhoneBillMonthlyCharges_update *******************
*******************************************************************************/
IF OBJECT_ID('sp_PhoneBillMonthlyCharges_update') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillMonthlyCharges_update;
GO

CREATE PROCEDURE sp_PhoneBillMonthlyCharges_update
	@PhoneBillPhoneBillAccountID			INT,

	@AdministrativeFee						NUMERIC(9,2),
	@CountyGrossReceipts						NUMERIC(9,2),
	@FederalUniversalServiceCharge			NUMERIC(9,2),
	@MTATelecom								NUMERIC(9,2),
	@RegulartoryCostRecoveryCharge			NUMERIC(9,2),
	@StateTelecommunicationsExcise			NUMERIC(9,2),

	@ServiceFee911							NUMERIC(9,2),
	@CityDistrictSalesTax					NUMERIC(9,2),
	@CitySalesTax							NUMERIC(9,2),
	@LocalWireless911Surcharge				NUMERIC(9,2),
	@NYSalesTax								NUMERIC(9,2)
AS

	BEGIN TRANSACTION tranMonthlyCharges

	UPDATE PhoneBillSurchargesOtherFees SET
		PhoneBillPhoneBillAccountID = @PhoneBillPhoneBillAccountID,
		AdministrativeFee = @AdministrativeFee,
		CountyGrossReceipts = @CountyGrossReceipts,
		FederalUniversalServiceCharge = @FederalUniversalServiceCharge,
		MTATelecom = @MTATelecom,
		RegulartoryCostRecoveryCharge = @RegulartoryCostRecoveryCharge,
		StateTelecommunicationsExcise = @StateTelecommunicationsExcise
	WHERE 
		PhoneBillPhoneBillAccountID = @PhoneBillPhoneBillAccountID;

	UPDATE PhoneBillGovernmentFeesTaxes SET
		ServiceFee911 = @ServiceFee911,
		CityDistrictSalesTax = @CityDistrictSalesTax,
		CitySalesTax = @CitySalesTax,
		LocalWireless911Surcharge = @LocalWireless911Surcharge,
		NYSalesTax = @NYSalesTax
	WHERE 
		PhoneBillPhoneBillAccountID = @PhoneBillPhoneBillAccountID;

	IF @@ERROR = 0
		COMMIT TRANSACTION tranMonthlyCharges;
	ELSE
		ROLLBACK TRANSACTION tranMonthlyCharges;

GO












/*******************************************************************************
***************** sp_PhoneBillMonthlyCharges_MonthlyCharge_insert *******************
*******************************************************************************/
IF OBJECT_ID('sp_PhoneBillMonthlyCharges_MonthlyCharge_insert') IS NOT NULL
	DROP PROCEDURE sp_PhoneBillMonthlyCharges_MonthlyCharge_insert;
GO

CREATE PROCEDURE sp_PhoneBillMonthlyCharges_MonthlyCharge_insert
	@PhoneBillPhoneBillAccountID			INT,

	@MonthlyChargeName							VARCHAR(100),
	@MonthlyChargeValue						NUMERIC(9,2)
AS
	
	INSERT INTO PhoneBillMonthlyCharges
		(PhoneBillPhoneBillAccountID, MonthlyChargeName, MonthlyChargeValue)
	VALUES	
		(@PhoneBillPhoneBillAccountID, @MonthlyChargeName, @MonthlyChargeValue)	;


GO