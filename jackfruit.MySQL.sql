# Database created on 06/02/18 10:54 from db.uml
CREATE DATABASE IF NOT EXISTS jackfruit CHARACTER SET = utf8 COLLATE = utf8_unicode_ci;
USE jackfruit;

DROP TABLE IF EXISTS `Banks`;
CREATE TABLE `Banks` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  name                   VARCHAR(32) NOT NULL COMMENT "name of bank",
  code                   VARCHAR(32) NOT NULL,
  nation                 VARCHAR(32) NOT NULL,
  description            VARCHAR(128) COMMENT "desc of bank",
  accountLength          INT COMMENT "account number length",
  validateExpression     VARCHAR(64),

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `LoanProducts`;
CREATE TABLE `LoanProducts` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  name                   VARCHAR(64) COMMENT "name of loan product",
  amount                 DECIMAL(16,2) NOT NULL COMMENT "amount of money",
  days                   INT UNSIGNED COMMENT "loan days",
  preloanFee             DECIMAL(16,2) NOT NULL,
  installments           INT UNSIGNED NOT NULL COMMENT "by stages times",
  interestRate           DECIMAL(10,8) NOT NULL COMMENT "interest rate",
  overdueInterestRate    DECIMAL(10,8) NOT NULL COMMENT "overdue interest rate",
  minCredit              INT UNSIGNED NOT NULL COMMENT "min credit",

  PRIMARY KEY (id),
  UNIQUE (name)

);

DROP TABLE IF EXISTS `Accounts`;
CREATE TABLE `Accounts` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  id_Person              BIGINT UNSIGNED,
  id_Certificate         BIGINT UNSIGNED,
  openId                 VARCHAR(128) COMMENT "oauth openid",
  accountName            VARCHAR(128),
  mobile                 VARCHAR(128) NOT NULL,
  credit                 INT UNSIGNED NOT NULL DEFAULT 0,
  isDeleted              BOOLEAN NOT NULL DEFAULT FALSE,
  deletedAt              DATETIME COMMENT "account locked time",
  isLocked               BOOLEAN NOT NULL DEFAULT FALSE,
  lockedAt               DATETIME COMMENT "account locked time",

  PRIMARY KEY (id),
  UNIQUE (accountName),
  UNIQUE (mobile)

);

DROP TABLE IF EXISTS `Wallets`;
CREATE TABLE `Wallets` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  id_Account             BIGINT UNSIGNED NOT NULL,
  balance                DECIMAL(20,6) DEFAULT 0,
  status                 VARCHAR(32),

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `WalletHistories`;
CREATE TABLE `WalletHistories` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  id_Account             BIGINT UNSIGNED NOT NULL,
  id_Wallet              BIGINT UNSIGNED NOT NULL,
  type                   VARCHAR(32) NOT NULL,
  orderNo                VARCHAR(64) NOT NULL,
  amount                 DECIMAL(20,6) NOT NULL,
  description            VARCHAR(50),

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `Persons`;
CREATE TABLE `Persons` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  firstName              VARCHAR(32),
  middleName             VARCHAR(32),
  lastName               VARCHAR(32),
  nationality            VARCHAR(32),
  gender                 VARCHAR(10),
  birthday               DATE,
  placeOfBirth           VARCHAR(128),
  maritalStatus          VARCHAR(32),
  mobile                 VARCHAR(16),
  email                  VARCHAR(64),
  education              VARCHAR(64),
  residentialDistrictAddress     VARCHAR(128),
  residentialStreetAddress     VARCHAR(128),
  permanentDistrictAddress       VARCHAR(128),
  permanentStreetAddress       VARCHAR(128),
  property               VARCHAR(32),
  yearlyFamilyIncome     VARCHAR(32),
  hasUnrepaidLoan        BOOLEAN,
  unrepaidLoanAmount     DECIMAL(16,2),
  hasOverdueHistory      BOOLEAN,
  hasFaceRecognition     BOOLEAN,
  hasFillCompleted       BOOLEAN,
	holdCertificateImgUrl  VARCHAR(256),
	socialStatus           VARCHAR(32),
	houseHoldBillAddressImgUrl VARCHAR(256),

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `Cards`;
CREATE TABLE `Cards` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  id_Account             BIGINT UNSIGNED,
  isPrimary              BOOLEAN,
  isValid                BOOLEAN,
  isExpired              BOOLEAN,
  bankAccountName        VARCHAR(32),
  bankAccount            VARCHAR(32),
  bankName               VARCHAR(32),
  bankCode               VARCHAR(32),
  bankNation             VARCHAR(32),

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `Relatives`;
CREATE TABLE `Relatives` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  id_Account             BIGINT UNSIGNED,
  firstName              VARCHAR(32),
  middleName             VARCHAR(32),
  lastName               VARCHAR(32),
  gender                 VARCHAR(10),
  mobile                 VARCHAR(16),
  birthday               DATE,
  email                  VARCHAR(64),
  districtAddress        VARCHAR(128),
  streetAddress          VARCHAR(128),
  company                VARCHAR(64),
  type                   VARCHAR(32),
  relationship           VARCHAR(32),

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `Works`;
CREATE TABLE `Works` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  id_Account             BIGINT UNSIGNED,
  employeeId             VARCHAR(64),
  workIdImgUrl           VARCHAR(256),
  company                VARCHAR(32) NOT NULL,
  occupation             VARCHAR(64) NOT NULL,
  districtAddress        VARCHAR(128) NOT NULL,
  streetAddress          VARCHAR(128) NOT NULL,
  email                  VARCHAR(64),
  phone                  VARCHAR(64),
  entryDate              DATE NOT NULL,
  firstPayDay            INT UNSIGNED NOT NULL,
  secondPayDay           INT UNSIGNED,
  salary                 DECIMAL(16,2) NOT NULL,
  lastestPayCheckDate    DATE,
  secondLastestPayCheckDate DATE,
  lastestPayslipImgUrl   VARCHAR(256),

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `Certificates`;
CREATE TABLE `Certificates` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  hasSocialSecurity      BOOLEAN,
  ssId                   VARCHAR(64),
  ssName                 VARCHAR(64),
  ssIssueDate            DATE,
  ssExpireDate           DATE,
  ssImgUrl               VARCHAR(256),
  hasDriverLicense       BOOLEAN,
  dlId                   VARCHAR(64),
  dlName                 VARCHAR(64),
  dlIssueDate            DATE,
  dlExpireDate           DATE,
  dlImgUrl               VARCHAR(256),
  hasPassport            BOOLEAN,
  ppId                   VARCHAR(64),
  ppName                 VARCHAR(64),
  ppIssueDate            DATE,
  ppExpireDate           DATE,
  ppImgUrl               VARCHAR(256),
  hasTaxIdentification   BOOLEAN,
  tiId                   VARCHAR(64),
  tiName                 VARCHAR(64),
  tiIssueDate            DATE,
  tiExpireDate           DATE,
  tiImgUrl               VARCHAR(256),
  hasUnified             BOOLEAN,
  uniId                  VARCHAR(64),
  uniName                VARCHAR(64),
  uniIssueDate           DATE,
  uniExpireDate          DATE,
  uniImgUrl              VARCHAR(256),

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `Loans`;
CREATE TABLE `Loans` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  id_Account             BIGINT UNSIGNED NOT NULL,
  orderNo                VARCHAR(64) NOT NULL,
  instanceId             BIGINT UNSIGNED,
  status                 VARCHAR(32),
  principal              DECIMAL(20,6) DEFAULT 0,
  preloanFee             DECIMAL(16,2) NOT NULL,
  name                   VARCHAR(64) COMMENT "name of loan product",
  purpose                VARCHAR(128),
  days                   INT UNSIGNED COMMENT "loan days",
  interestRate           DECIMAL(10,8) NOT NULL COMMENT "interest rate",
  overdueInterestRate    DECIMAL(10,8) NOT NULL COMMENT "overdue interest rate",
  installments           INT UNSIGNED NOT NULL COMMENT "by stages times",
  dueAt                  DATE,
  unpaidInstallments     INT UNSIGNED NOT NULL,
  debt                   DECIMAL(20,6) DEFAULT 0,
  fee                    DECIMAL(20,6) DEFAULT 0,
  interest               DECIMAL(20,6) DEFAULT 0,
  overdueInterest        DECIMAL(20,6) DEFAULT 0,
  sum                    DECIMAL(16,2) DEFAULT 0,
  unpaidDebt             DECIMAL(20,6) DEFAULT 0,
  unpaidFee              DECIMAL(20,6) DEFAULT 0,
  unpaidInterest         DECIMAL(20,6) DEFAULT 0,
  unpaidOverdueInterest  DECIMAL(20,6) DEFAULT 0,
  unpaidSum              DECIMAL(16,2) DEFAULT 0,
  repaidDebt             DECIMAL(20,6) DEFAULT 0,
  repaidFee              DECIMAL(20,6) DEFAULT 0,
  repaidInterest         DECIMAL(20,6) DEFAULT 0,
  repaidOverdueInterest  DECIMAL(20,6) DEFAULT 0,
  repaidSum              DECIMAL(16,2) DEFAULT 0,

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `BorrowOrders`;
CREATE TABLE `BorrowOrders` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  id_Account             BIGINT UNSIGNED NOT NULL,
  orderNo                VARCHAR(64) NOT NULL,
  id_Loan                BIGINT UNSIGNED,
  status                 VARCHAR(32) NOT NULL,
  type                   VARCHAR(32) NOT NULL,
  transactionId          VARCHAR(64),
  amount                 DECIMAL(16,2) NOT NULL,
  bankName               VARCHAR(32),
  bankAccount            VARCHAR(32),
  debt                   DECIMAL(16,2) COMMENT "debt=principal+preloanFee",
  principal              DECIMAL(16,2),
  preloanFee             DECIMAL(16,2),
  name                   VARCHAR(64) COMMENT "name of loan product",
  purpose                VARCHAR(128),
  days                   INT UNSIGNED COMMENT "loan days",
  dueAt                  DATE,
  interestRate           DECIMAL(10,8) COMMENT "interest rate",
  overdueInterestRate    DECIMAL(10,8) COMMENT "overdue interest rate",
  installments           INT UNSIGNED DEFAULT 1 COMMENT "by stages times",
  channel                VARCHAR(32),
  description            VARCHAR(256),

  PRIMARY KEY (id),
  UNIQUE (transactionId)

);

DROP TABLE IF EXISTS `OverdueHistories`;
CREATE TABLE `OverdueHistories` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  orderNo                VARCHAR(64) NOT NULL,
  id_Loan                BIGINT UNSIGNED NOT NULL,
  id_Account             BIGINT UNSIGNED NOT NULL,
  unpaidDebt             DECIMAL(20,6) DEFAULT 0,
  unpaidFee              DECIMAL(20,6) DEFAULT 0,
  unpaidOverdueInterest  DECIMAL(20,6) DEFAULT 0,
  unpaidInterest         DECIMAL(20,6) DEFAULT 0,
  dueAt                  DATE,
  overduedAt             DATE,

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `Repayments`;
CREATE TABLE `Repayments` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  orderNo                VARCHAR(64) NOT NULL,
  id_Loan                BIGINT UNSIGNED NOT NULL,
  id_Account             BIGINT UNSIGNED NOT NULL,
  amount                 DECIMAL(16,2) DEFAULT 0,
  dueAt                  DATE NOT NULL,
  repaidDebt             DECIMAL(20,6) DEFAULT 0,
  repaidFee              DECIMAL(20,6) DEFAULT 0,
  repaidInterest         DECIMAL(20,6) DEFAULT 0,
  repaidOverdueInterest  DECIMAL(20,6) DEFAULT 0,
  repaidSum              DECIMAL(16,2) DEFAULT 0,
  unpaidDebt             DECIMAL(20,6) DEFAULT 0,
  unpaidFee              DECIMAL(20,6) DEFAULT 0,
  unpaidInterest         DECIMAL(20,6) DEFAULT 0,
  unpaidOverdueInterest  DECIMAL(20,6) DEFAULT 0,
  unpaidSum              DECIMAL(16,2) DEFAULT 0,
  channel                VARCHAR(32),

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `Investments`;
CREATE TABLE `Investments` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  orderNo                VARCHAR(64) NOT NULL,
  id_Loan                BIGINT UNSIGNED NOT NULL,
  id_Account             BIGINT UNSIGNED NOT NULL,
  status                 VARCHAR(32),
  amount                 DECIMAL(16,2) COMMENT "amount=fee+principal",
  fee                    DECIMAL(16,2),
  principal              DECIMAL(16,2),
  interest               DECIMAL(16,2) DEFAULT 0,
  dueAt                  DATE NOT NULL,

  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `InvestOrders`;
CREATE TABLE `InvestOrders` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  id_Account             BIGINT UNSIGNED NOT NULL,
  orderNo                VARCHAR(64) NOT NULL,
  id_Loan                BIGINT UNSIGNED NOT NULL,
  status                 VARCHAR(32) NOT NULL,
  amount                 DECIMAL(16,2) NOT NULL,
  bank                   VARCHAR(32),
  account                VARCHAR(32),
  interest               DECIMAL(16,2) DEFAULT 0,
  dueAt                  DATE NOT NULL,

  PRIMARY KEY (id),
  UNIQUE (transactionId)

);

DROP TABLE IF EXISTS `WithdrawOrders`;
CREATE TABLE `WithdrawOrders` (
  createdAt DATETIME DEFAULT now(),
  updatedAt DATETIME DEFAULT now() ON UPDATE now(),

  id                     SERIAL,
  id_Account             BIGINT UNSIGNED NOT NULL,
  status                 VARCHAR(32),
  amount                 DECIMAL(20,6) DEFAULT 0,

  PRIMARY KEY (id)
);

