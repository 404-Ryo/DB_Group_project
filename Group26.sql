-- =====================================================
-- KLParkEasy Smart Parking Database System
-- Group 26 - ITS62904 Database Systems
-- September 2025 Semester
-- =====================================================
-- 本ファイルには以下が含まれます:
--   Part A/B: テーブル定義 + サンプルデータ
--   Part C:   指定 SQL クエリ (Q5-Q10)
--   Part D:   分析レポート 5 種
--   Part E:   洪水警報ディスカウント機能
-- =====================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- =====================================================
-- PART A/B: SCHEMA DEFINITION AND SAMPLE DATA
-- =====================================================

-- -----------------------------
-- Table structure for applieddiscount
-- -----------------------------
DROP TABLE IF EXISTS `applieddiscount`;
CREATE TABLE `applieddiscount` (
    `AppliedDiscountID` int(11) NOT NULL AUTO_INCREMENT,
    `DiscountType` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `DiscountPercent` decimal(5,2) NOT NULL,
    PRIMARY KEY (`AppliedDiscountID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `applieddiscount` VALUES (1, 'GoldTier', 5.00);
INSERT INTO `applieddiscount` VALUES (2, 'SilverTier', 3.00);


-- -----------------------------
-- Table structure for brand
-- -----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
    `BrandID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `BrandName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`BrandID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `brand` VALUES ('BOTH', 'KLParkEasy Both');
INSERT INTO `brand` VALUES ('PRO', 'KLParkEasy Pro');
INSERT INTO `brand` VALUES ('TOURIST', 'KLParkEasy Tourist');


-- -----------------------------
-- Table structure for client
-- -----------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
    `ClientID` int(11) NOT NULL AUTO_INCREMENT,
    `ClientType` enum('Individual','Corporate') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `ClientName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `PrimaryContactMethod` enum('Email','Phone') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `PrimaryEmail` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `PrimaryPhone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `BusinessRelationshipType` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `ReferralSource` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `PreferredPaymentMethod` enum('Credit Card','E-Wallet','Blockchain Token') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `ParkPointsBalance` int(11) NOT NULL DEFAULT 0,
    `LoyaltyTier` enum('Bronze','Silver','Gold') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `GreenDriverStatus` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `BrandAffiliation` enum('Pro','Tourist','Both') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`ClientID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `client` VALUES (1, 'Individual', 'Ali bin Ahmed', 'Email', 'ali@example.com', '0123456789', 'Long-term Cooperation', 'Google Ad', 'E-wallet', 500, 'Gold', 'Yes', 'Pro');
INSERT INTO `client` VALUES (2, 'Individual', 'Siti Binti Omar', 'Phone', 'siti@example.com', '0123456789', 'New Client', 'Social Media', 'Credit Card', 100, 'Bronze', 'No', 'Tourist');
INSERT INTO `client` VALUES (3, 'Individual', 'Lee Wai Ming', 'Email', 'lee@example.com', '0123456789', 'Long-term Cooperation', 'Google Ad', 'Blockchain Token', 800, 'Silver', 'Yes', 'Both');
INSERT INTO `client` VALUES (4, 'Individual', 'Raj Kumar', 'Phone', 'raj@example.com', '0123456789', 'Long-term Cooperation', 'Referral', 'E-wallet', 1200, 'Gold', 'Yes', 'Pro');
INSERT INTO `client` VALUES (5, 'Individual', 'Aisha Binti Hassan', 'Email', 'aisha@example.com', '0123456789', 'New Client', 'Social Media', 'Credit Card', 50, 'Bronze', 'No', 'Tourist');
INSERT INTO `client` VALUES (6, 'Individual', 'Tan Seng Huat', 'Phone', 'tan@example.com', '0123456789', 'Long-term Cooperation', 'Google Ad', 'Blockchain Token', 900, 'Silver', 'Yes', 'Both');
INSERT INTO `client` VALUES (7, 'Individual', 'Fatimah Binti Yusof', 'Email', 'fatimah@example.com', '0123456789', 'New Client', 'Referral', 'E-wallet', 200, 'Silver', 'No', 'Pro');
INSERT INTO `client` VALUES (8, 'Individual', 'John Smith', 'Phone', 'john@example.com', '0123456789', 'Long-term Cooperation', 'Social Media', 'Credit Card', 1500, 'Gold', 'Yes', 'Both');
INSERT INTO `client` VALUES (9, 'Individual', 'Muthu Subramaniam', 'Email', 'muthu@example.com', '0123456789', 'New Client', 'Google Ad', 'Blockchain Token', 300, 'Bronze', 'No', 'Tourist');
INSERT INTO `client` VALUES (10, 'Individual', 'Nor Binti Ismail', 'Phone', 'nor@example.com', '0123456789', 'Long-term Cooperation', 'Referral', 'E-wallet', 700, 'Silver', 'Yes', 'Pro');
INSERT INTO `client` VALUES (11, 'Corporate', 'ABC Logistics Sdn Bhd', 'Email', 'contact@abc-logistics.com', '0321456789', 'Long-term Cooperation', 'Referral', 'Blockchain Token', 5000, 'Gold', 'Yes', 'Pro');
INSERT INTO `client` VALUES (12, 'Corporate', 'XYZ Tech Solutions', 'Phone', 'info@xyz-tech.com', '0312456789', 'New Client', 'Google Ad', 'Credit Card', 1000, 'Silver', 'No', 'Both');
INSERT INTO `client` VALUES (13, 'Corporate', '123 Transport Services', 'Email', 'admin@123transport.com', '0323456789', 'Long-term Cooperation', 'Social Media', 'E-wallet', 1000, 'Gold', 'Yes', 'Pro');
INSERT INTO `client` VALUES (14, 'Corporate', 'QnG Construction Sdn Bhd', 'Phone', 'support@qng-construction.com', '0324456789', 'New Client', 'Referral', 'Credit Card', 400, 'Bronze', 'No', 'Tourist');
INSERT INTO `client` VALUES (15, 'Corporate', 'ASD Retail Group', 'Email', 'rg@asd-retail.com', '0325456789', 'Long-term Cooperation', 'Google Ad', 'Blockchain Token', 4000, 'Silver', 'Yes', 'Both');


-- -----------------------------
-- Table structure for clientbrand
-- -----------------------------
DROP TABLE IF EXISTS `clientbrand`;
CREATE TABLE `clientbrand` (
    `ClientBrandID` int(11) NOT NULL AUTO_INCREMENT,
    `ClientID` int(11) NOT NULL,
    `BrandID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`ClientBrandID`) USING BTREE,
    UNIQUE INDEX `uk_client_brand`(`ClientID` ASC, `BrandID` ASC) USING BTREE,
    INDEX `BrandID`(`BrandID` ASC) USING BTREE,
    CONSTRAINT `clientbrand_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `client` (`ClientID`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `clientbrand_ibfk_2` FOREIGN KEY (`BrandID`) REFERENCES `brand` (`BrandID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `clientbrand` VALUES (1, 1, 'PRO');
INSERT INTO `clientbrand` VALUES (2, 2, 'TOURIST');
INSERT INTO `clientbrand` VALUES (3, 3, 'BOTH');
INSERT INTO `clientbrand` VALUES (4, 4, 'PRO');
INSERT INTO `clientbrand` VALUES (5, 5, 'TOURIST');
INSERT INTO `clientbrand` VALUES (6, 6, 'BOTH');
INSERT INTO `clientbrand` VALUES (7, 7, 'PRO');
INSERT INTO `clientbrand` VALUES (8, 8, 'BOTH');
INSERT INTO `clientbrand` VALUES (9, 9, 'TOURIST');
INSERT INTO `clientbrand` VALUES (10, 10, 'PRO');
INSERT INTO `clientbrand` VALUES (11, 11, 'PRO');
INSERT INTO `clientbrand` VALUES (12, 12, 'BOTH');
INSERT INTO `clientbrand` VALUES (13, 13, 'PRO');
INSERT INTO `clientbrand` VALUES (14, 14, 'TOURIST');
INSERT INTO `clientbrand` VALUES (15, 15, 'BOTH');


-- -----------------------------
-- Table structure for individualclient
-- -----------------------------
DROP TABLE IF EXISTS `individualclient`;
CREATE TABLE `individualclient` (
    `ClientID` int(11) NOT NULL,
    PRIMARY KEY (`ClientID`) USING BTREE,
    CONSTRAINT `individualclient_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `client` (`ClientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `individualclient` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);


-- -----------------------------
-- Table structure for corporateclient
-- -----------------------------
DROP TABLE IF EXISTS `corporateclient`;
CREATE TABLE `corporateclient` (
    `ClientID` int(11) NOT NULL,
    `PrimaryContactName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`ClientID`) USING BTREE,
    CONSTRAINT `corporateclient_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `client` (`ClientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `corporateclient` VALUES (11, 'David Tan');
INSERT INTO `corporateclient` VALUES (12, 'Sarah Lee');
INSERT INTO `corporateclient` VALUES (13, 'Mohammed Amin');
INSERT INTO `corporateclient` VALUES (14, 'Chong Wai Keong');
INSERT INTO `corporateclient` VALUES (15, 'Priya Nair');


-- -----------------------------
-- Table structure for dynamicpricingrule
-- -----------------------------
DROP TABLE IF EXISTS `dynamicpricingrule`;
CREATE TABLE `dynamicpricingrule` (
    `DynamicPricingRuleID` int(11) NOT NULL AUTO_INCREMENT,
    `SurchargePercent` decimal(5,2) NOT NULL,
    `ApplicableZone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `ApplicableSpaceType` enum('Standard','Premium-Covered','EV-Charger','Motorbike') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `PeakHourStart` time NOT NULL,
    `PeakHourEnd` time NOT NULL,
    `EffectiveStartDate` date NOT NULL,
    `EffectiveEndDate` date NULL DEFAULT NULL,
    `RuleDescription` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `PredictedDemandScore` enum('Low','Moderate','High') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `OptimalPricingIndex` decimal(5,2) NOT NULL,
    PRIMARY KEY (`DynamicPricingRuleID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `dynamicpricingrule` VALUES (1, 20.00, 'KL Sentral Zone A', 'Standard', '07:00:00', '09:00:00', '2025-01-01', NULL, 'Monday to Friday Morning Peak Surcharge', 'High', 1.20);
INSERT INTO `dynamicpricingrule` VALUES (2, 25.00, 'KL Sentral Zone C', 'Premium-Covered', '07:00:00', '09:00:00', '2025-01-01', NULL, 'Monday to Friday Morning Peak Premium-Covered Space Surcharge', 'High', 1.25);
INSERT INTO `dynamicpricingrule` VALUES (3, 15.00, 'The Gardens Mall Zone A', 'Standard', '17:00:00', '19:00:00', '2025-01-01', NULL, 'Monday to Friday Evening Peak Surcharge', 'High', 1.15);
INSERT INTO `dynamicpricingrule` VALUES (4, 15.00, 'The Gardens Mall Zone B', 'Premium-Covered', '17:00:00', '19:00:00', '2025-01-01', NULL, 'Monday to Friday Evening Peak Premium-Covered Space Surcharge', 'High', 1.15);
INSERT INTO `dynamicpricingrule` VALUES (5, -10.00, 'Cyberjaya Zone A', 'Standard', '00:00:00', '23:59:59', '2025-01-01', '2025-12-31', 'Cyberjaya Low Demand Area Subsidy', 'Low', 0.90);
INSERT INTO `dynamicpricingrule` VALUES (6, -8.00, 'Cyberjaya Zone B', 'EV-Charger', '00:00:00', '23:59:59', '2025-01-01', '2025-12-31', 'Cyberjaya EV Charger Space Subsidy', 'Moderate', 0.92);
INSERT INTO `dynamicpricingrule` VALUES (7, 15.00, 'KL Sentral Zone D', 'EV-Charger', '18:00:00', '22:00:00', '2025-01-01', NULL, 'KL Sentral Concert Special Surcharge', 'High', 1.15);
INSERT INTO `dynamicpricingrule` VALUES (8, 5.00, 'Jalan Ampang Zone A', 'Standard', '12:00:00', '14:00:00', '2025-01-01', NULL, 'Midday Off-Peak Surcharge', 'Moderate', 1.05);
INSERT INTO `dynamicpricingrule` VALUES (9, 8.00, 'Golden Horse Place Zone A', 'EV-Charger', '12:00:00', '14:00:00', '2025-01-01', '2025-12-31', 'Midday EV Charger Space Surcharge', 'Moderate', 1.08);
INSERT INTO `dynamicpricingrule` VALUES (10, 10.00, 'The Gardens Hall Zone C', 'EV-Charger', '18:00:00', '22:00:00', '2025-01-01', NULL, 'Weekend The Gardens Hall EV Charger Space Surcharge', 'High', 1.10);
INSERT INTO `dynamicpricingrule` VALUES (11, 0.00, 'Jalan Ampang Zone D', 'Motorbike', '00:00:00', '23:59:59', '2025-01-01', NULL, 'Motorbike Space Base Pricing (No Surcharge)', 'Low', 1.00);


-- -----------------------------
-- Table structure for parkinglot
-- -----------------------------
DROP TABLE IF EXISTS `parkinglot`;
CREATE TABLE `parkinglot` (
    `LotID` int(11) NOT NULL AUTO_INCREMENT,
    `LotName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `SiteTier` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `Location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `MaxCapacity` int(11) NOT NULL,
    PRIMARY KEY (`LotID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `parkinglot` VALUES (1, 'KL ParkEasy Bukit Bintang Branch', 'Tier 1', 'Bukit Bintang, Kuala Lumpur', 200);
INSERT INTO `parkinglot` VALUES (2, 'KL ParkEasy KL Sentral Branch', 'Tier 1', 'KL Sentral, Kuala Lumpur', 300);
INSERT INTO `parkinglot` VALUES (3, 'KL ParkEasy Jalan Ampang Branch', 'Tier 2', 'Jalan Ampang, Kuala Lumpur', 150);
INSERT INTO `parkinglot` VALUES (4, 'KL ParkEasy Golden Horse Plaza Branch', 'Tier 2', 'Golden Horse Plaza, Kuala Lumpur', 180);
INSERT INTO `parkinglot` VALUES (5, 'KL ParkEasy Cyberjaya Branch', 'Tier 3', 'Cyberjaya, Kuala Lumpur', 250);


-- -----------------------------
-- Table structure for parkingspot
-- -----------------------------
DROP TABLE IF EXISTS `parkingspot`;
CREATE TABLE `parkingspot` (
    `SpotID` int(11) NOT NULL AUTO_INCREMENT,
    `LotID` int(11) NOT NULL,
    `LocationZone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `SpaceType` enum('Standard','Premium-Covered','EV-Charger','Motorbike') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `DemandRating` enum('Low','Moderate','High') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `StandardHourlyRate` decimal(10,2) NOT NULL,
    `SensorStatus` enum('Operational','Needs Calibration','Offline') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `LastMaintenanceDate` date NOT NULL,
    `OperationalStatus` enum('Available','Occupied') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`SpotID`) USING BTREE,
    INDEX `LotID`(`LotID` ASC) USING BTREE,
    CONSTRAINT `parkingspot_ibfk_1` FOREIGN KEY (`LotID`) REFERENCES `parkinglot` (`LotID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `parkingspot` VALUES (1, 1, 'Bukit Bintang Zone A', 'Standard', 'High', 5.00, 'Operational', '2025-01-10', 'Available');
INSERT INTO `parkingspot` VALUES (2, 1, 'Bukit Bintang Zone B', 'Premium-Covered', 'High', 8.00, 'Offline', '2025-01-05', 'Occupied');
INSERT INTO `parkingspot` VALUES (3, 1, 'Bukit Bintang Zone C', 'EV-Charger', 'Moderate', 6.00, 'Needs Calibration', '2025-01-08', 'Available');
INSERT INTO `parkingspot` VALUES (4, 2, 'KL Sentral Zone A', 'Standard', 'High', 4.50, 'Operational', '2025-01-12', 'Occupied');
INSERT INTO `parkingspot` VALUES (5, 2, 'KL Sentral Zone B', 'Motorbike', 'Low', 2.00, 'Offline', '2025-01-03', 'Available');
INSERT INTO `parkingspot` VALUES (6, 3, 'Jalan Ampang Zone A', 'Standard', 'Moderate', 4.00, 'Operational', '2025-01-15', 'Occupied');
INSERT INTO `parkingspot` VALUES (7, 3, 'Jalan Ampang Zone B', 'Premium-Covered', 'Moderate', 7.00, 'Needs Calibration', '2025-01-07', 'Available');
INSERT INTO `parkingspot` VALUES (8, 4, 'Golden Horse Plaza Zone A', 'EV-Charger', 'High', 6.50, 'Operational', '2025-01-11', 'Occupied');
INSERT INTO `parkingspot` VALUES (9, 4, 'Golden Horse Plaza Zone B', 'Standard', 'Moderate', 5.00, 'Offline', '2025-01-02', 'Available');
INSERT INTO `parkingspot` VALUES (10, 5, 'Cyberjaya Zone A', 'Standard', 'Low', 3.50, 'Operational', '2025-01-13', 'Occupied');
INSERT INTO `parkingspot` VALUES (11, 5, 'Cyberjaya Zone B', 'EV-Charger', 'Moderate', 5.50, 'Needs Calibration', '2025-01-06', 'Available');
INSERT INTO `parkingspot` VALUES (12, 1, 'Bukit Bintang Zone D', 'Motorbike', 'Low', 2.50, 'Operational', '2025-01-09', 'Occupied');
INSERT INTO `parkingspot` VALUES (13, 2, 'KL Sentral Zone C', 'Premium-Covered', 'High', 7.50, 'Offline', '2025-01-01', 'Available');
INSERT INTO `parkingspot` VALUES (14, 3, 'Jalan Ampang Zone C', 'EV-Charger', 'Moderate', 6.00, 'Operational', '2025-01-14', 'Occupied');
INSERT INTO `parkingspot` VALUES (15, 4, 'Golden Horse Plaza Zone C', 'Motorbike', 'Low', 2.00, 'Needs Calibration', '2025-01-04', 'Available');


-- -----------------------------
-- Table structure for vehicle
-- -----------------------------
DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE `vehicle` (
    `PlateNumber` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `VehicleType` enum('Sedan','SUV','Motorbike','Van') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `ClientID` int(11) NOT NULL,
    PRIMARY KEY (`PlateNumber`) USING BTREE,
    INDEX `ClientID`(`ClientID` ASC) USING BTREE,
    CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `client` (`ClientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `vehicle` VALUES ('WRA1234', 'Sedan', 1);
INSERT INTO `vehicle` VALUES ('WRB5678', 'SUV', 2);
INSERT INTO `vehicle` VALUES ('WRC9012', 'Sedan', 3);
INSERT INTO `vehicle` VALUES ('WRD3456', 'Van', 4);
INSERT INTO `vehicle` VALUES ('WRE7890', 'Motorbike', 5);
INSERT INTO `vehicle` VALUES ('WRF2345', 'Sedan', 6);
INSERT INTO `vehicle` VALUES ('WRG6789', 'SUV', 7);
INSERT INTO `vehicle` VALUES ('WRH0123', 'Sedan', 8);
INSERT INTO `vehicle` VALUES ('WRI4567', 'Van', 9);
INSERT INTO `vehicle` VALUES ('WRJ8901', 'Motorbike', 10);
INSERT INTO `vehicle` VALUES ('WRK3456', 'Sedan', 11);
INSERT INTO `vehicle` VALUES ('WRL7890', 'SUV', 12);
INSERT INTO `vehicle` VALUES ('WRM2345', 'SUV', 13);
INSERT INTO `vehicle` VALUES ('WRN6789', 'Van', 14);
INSERT INTO `vehicle` VALUES ('WRO0123', 'Sedan', 15);


-- -----------------------------
-- Table structure for evvehicle
-- -----------------------------
DROP TABLE IF EXISTS `evvehicle`;
CREATE TABLE `evvehicle` (
    `PlateNumber` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `IsEV` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Yes',
    PRIMARY KEY (`PlateNumber`) USING BTREE,
    CONSTRAINT `evvehicle_ibfk_1` FOREIGN KEY (`PlateNumber`) REFERENCES `vehicle` (`PlateNumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `evvehicle` VALUES ('WRA1234', 'Yes');
INSERT INTO `evvehicle` VALUES ('WRC9012', 'Yes');
INSERT INTO `evvehicle` VALUES ('WRF2345', 'Yes');
INSERT INTO `evvehicle` VALUES ('WRH0123', 'Yes');
INSERT INTO `evvehicle` VALUES ('WRK3456', 'Yes');
INSERT INTO `evvehicle` VALUES ('WRL7890', 'Yes');
INSERT INTO `evvehicle` VALUES ('WRM2345', 'Yes');
INSERT INTO `evvehicle` VALUES ('WRO0123', 'Yes');


-- -----------------------------
-- Table structure for nonevvehicle
-- -----------------------------
DROP TABLE IF EXISTS `nonevvehicle`;
CREATE TABLE `nonevvehicle` (
    `PlateNumber` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`PlateNumber`) USING BTREE,
    CONSTRAINT `nonevvehicle_ibfk_1` FOREIGN KEY (`PlateNumber`) REFERENCES `vehicle` (`PlateNumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `nonevvehicle` VALUES ('WRB5678'),('WRD3456'),('WRE7890'),('WRG6789'),('WRI4567'),('WRJ8901'),('WRN6789');


-- -----------------------------
-- Table structure for parkingsession
-- -----------------------------
DROP TABLE IF EXISTS `parkingsession`;
CREATE TABLE `parkingsession` (
    `ParkingSessionID` int(11) NOT NULL AUTO_INCREMENT,
    `VehiclePlateNumber` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `SpotID` int(11) NOT NULL,
    `StartTime` datetime NOT NULL,
    `EndTime` datetime NOT NULL,
    `DurationHours` decimal(5,1) NOT NULL,
    `BaseCharge` decimal(10,2) NOT NULL,
    `FinalCharge` decimal(10,2) NOT NULL,
    `LPRFailureCount` int(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (`ParkingSessionID`) USING BTREE,
    INDEX `VehiclePlateNumber`(`VehiclePlateNumber` ASC) USING BTREE,
    INDEX `SpotID`(`SpotID` ASC) USING BTREE,
    CONSTRAINT `parkingsession_ibfk_1` FOREIGN KEY (`VehiclePlateNumber`) REFERENCES `vehicle` (`PlateNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `parkingsession_ibfk_2` FOREIGN KEY (`SpotID`) REFERENCES `parkingspot` (`SpotID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `parkingsession` VALUES (1, 'WRA1234', 1, '2025-02-01 07:30:00', '2025-02-01 10:30:00', 3.0, 15.00, 17.10, 0);
INSERT INTO `parkingsession` VALUES (2, 'WRB5678', 2, '2025-02-01 08:00:00', '2025-02-01 11:00:00', 3.0, 24.00, 27.60, 1);
INSERT INTO `parkingsession` VALUES (3, 'WRC9012', 3, '2025-02-01 09:00:00', '2025-02-01 12:00:00', 3.0, 18.00, 18.90, 0);
INSERT INTO `parkingsession` VALUES (4, 'WRD3456', 4, '2025-02-01 10:00:00', '2025-02-01 13:00:00', 3.0, 13.50, 13.50, 0);
INSERT INTO `parkingsession` VALUES (5, 'WRE7890', 5, '2025-02-01 11:00:00', '2025-02-01 14:00:00', 3.0, 6.00, 6.30, 2);
INSERT INTO `parkingsession` VALUES (6, 'WRF2345', 6, '2025-02-01 12:00:00', '2025-02-01 15:00:00', 3.0, 12.00, 12.60, 0);
INSERT INTO `parkingsession` VALUES (7, 'WRG6789', 7, '2025-02-01 13:00:00', '2025-02-01 16:00:00', 3.0, 21.00, 22.05, 1);
INSERT INTO `parkingsession` VALUES (8, 'WRH0123', 8, '2025-02-01 14:00:00', '2025-02-01 17:00:00', 3.0, 19.50, 22.43, 0);
INSERT INTO `parkingsession` VALUES (9, 'WRI4567', 9, '2025-02-01 15:00:00', '2025-02-01 18:00:00', 3.0, 15.00, 15.75, 2);
INSERT INTO `parkingsession` VALUES (10, 'WRJ8901', 10, '2025-02-01 16:00:00', '2025-02-01 19:00:00', 3.0, 10.50, 11.03, 0);
INSERT INTO `parkingsession` VALUES (11, 'WRK3456', 12, '2025-02-01 17:00:00', '2025-02-01 20:00:00', 3.0, 7.50, 7.88, 0);
INSERT INTO `parkingsession` VALUES (12, 'WRL7890', 13, '2025-02-01 07:15:00', '2025-02-01 10:15:00', 3.0, 22.50, 26.44, 1);
INSERT INTO `parkingsession` VALUES (13, 'WRM2345', 14, '2025-02-01 10:30:00', '2025-02-01 13:30:00', 3.0, 18.00, 18.90, 0);
INSERT INTO `parkingsession` VALUES (14, 'WRN6789', 15, '2025-02-01 13:30:00', '2025-02-01 16:30:00', 3.0, 6.00, 6.30, 2);
INSERT INTO `parkingsession` VALUES (15, 'WRA1234', 1, '2025-02-02 17:00:00', '2025-02-02 20:00:00', 3.0, 15.00, 17.10, 0);
INSERT INTO `parkingsession` VALUES (16, 'WRB5678', 2, '2025-02-02 07:00:00', '2025-02-02 10:00:00', 3.0, 24.00, 28.20, 1);
INSERT INTO `parkingsession` VALUES (17, 'WRC9012', 3, '2025-02-02 12:00:00', '2025-02-02 15:00:00', 3.0, 18.00, 19.80, 0);
INSERT INTO `parkingsession` VALUES (18, 'WRD3456', 4, '2025-02-02 18:00:00', '2025-02-02 21:00:00', 3.0, 13.50, 15.53, 0);
INSERT INTO `parkingsession` VALUES (19, 'WRE7890', 5, '2025-02-02 07:30:00', '2025-02-02 10:30:00', 3.0, 6.00, 6.90, 3);
INSERT INTO `parkingsession` VALUES (20, 'WRF2345', 6, '2025-02-02 17:30:00', '2025-02-02 20:30:00', 3.0, 12.00, 12.60, 0);
INSERT INTO `parkingsession` VALUES (21, 'WRG6789', 7, '2025-02-02 12:30:00', '2025-02-02 15:30:00', 3.0, 21.00, 23.10, 1);
INSERT INTO `parkingsession` VALUES (22, 'WRH0123', 8, '2025-02-03 07:45:00', '2025-02-03 10:45:00', 3.0, 19.50, 23.40, 0);
INSERT INTO `parkingsession` VALUES (23, 'WRI4567', 9, '2025-02-03 18:30:00', '2025-02-03 21:30:00', 3.0, 15.00, 15.75, 2);
INSERT INTO `parkingsession` VALUES (24, 'WRJ8901', 10, '2025-02-03 11:30:00', '2025-02-03 14:30:00', 3.0, 10.50, 11.55, 0);
INSERT INTO `parkingsession` VALUES (25, 'WRK3456', 11, '2025-02-03 17:45:00', '2025-02-03 20:45:00', 3.0, 16.50, 17.33, 1);
INSERT INTO `parkingsession` VALUES (26, 'WRL7890', 12, '2025-02-04 07:20:00', '2025-02-04 10:20:00', 3.0, 7.50, 8.25, 0);
INSERT INTO `parkingsession` VALUES (27, 'WRM2345', 13, '2025-02-04 12:15:00', '2025-02-04 15:15:00', 3.0, 22.50, 23.63, 1);
INSERT INTO `parkingsession` VALUES (28, 'WRN6789', 14, '2025-02-04 08:00:00', '2025-02-04 11:00:00', 3.0, 18.00, 21.60, 0);
INSERT INTO `parkingsession` VALUES (29, 'WRA1234', 15, '2025-02-04 18:15:00', '2025-02-04 21:15:00', 3.0, 6.00, 6.60, 2);
INSERT INTO `parkingsession` VALUES (30, 'WRB5678', 1, '2025-02-04 11:00:00', '2025-02-04 14:00:00', 3.0, 15.00, 15.00, 0);
INSERT INTO `parkingsession` VALUES (31, 'WRC9012', 2, '2025-02-05 17:20:00', '2025-02-05 20:20:00', 3.0, 24.00, 27.00, 1);
INSERT INTO `parkingsession` VALUES (32, 'WRD3456', 3, '2025-02-05 07:50:00', '2025-02-05 10:50:00', 3.0, 18.00, 20.70, 0);
INSERT INTO `parkingsession` VALUES (33, 'WRE7890', 4, '2025-02-05 12:45:00', '2025-02-05 15:45:00', 3.0, 13.50, 13.50, 1);
INSERT INTO `parkingsession` VALUES (34, 'WRF2345', 5, '2025-02-05 18:45:00', '2025-02-05 21:45:00', 3.0, 6.00, 6.30, 0);
INSERT INTO `parkingsession` VALUES (35, 'WRG6789', 6, '2025-02-06 07:10:00', '2025-02-06 10:10:00', 3.0, 12.00, 12.60, 2);
INSERT INTO `parkingsession` VALUES (36, 'WRH0123', 7, '2025-02-06 17:10:00', '2025-02-06 20:10:00', 3.0, 21.00, 22.05, 0);
INSERT INTO `parkingsession` VALUES (37, 'WRI4567', 8, '2025-02-06 12:20:00', '2025-02-06 15:20:00', 3.0, 19.50, 20.48, 1);
INSERT INTO `parkingsession` VALUES (38, 'WRJ8901', 9, '2025-02-06 08:15:00', '2025-02-06 11:15:00', 3.0, 15.00, 18.00, 0);
INSERT INTO `parkingsession` VALUES (39, 'WRK3456', 10, '2025-02-07 17:30:00', '2025-02-07 20:30:00', 3.0, 10.50, 11.03, 1);
INSERT INTO `parkingsession` VALUES (40, 'WRL7890', 11, '2025-02-07 07:40:00', '2025-02-07 10:40:00', 3.0, 16.50, 19.80, 0);
INSERT INTO `parkingsession` VALUES (41, 'WRM2345', 12, '2025-02-07 11:45:00', '2025-02-07 14:45:00', 3.0, 7.50, 7.88, 2);
INSERT INTO `parkingsession` VALUES (42, 'WRN6789', 13, '2025-02-07 18:00:00', '2025-02-07 21:00:00', 3.0, 22.50, 25.88, 0);
INSERT INTO `parkingsession` VALUES (43, 'WRA1234', 14, '2025-02-08 12:00:00', '2025-02-08 15:00:00', 3.0, 18.00, 18.90, 1);
INSERT INTO `parkingsession` VALUES (44, 'WRB5678', 15, '2025-02-08 07:00:00', '2025-02-08 10:00:00', 3.0, 6.00, 6.60, 0);
INSERT INTO `parkingsession` VALUES (45, 'WRC9012', 1, '2025-02-08 18:20:00', '2025-02-08 21:20:00', 3.0, 15.00, 17.10, 1);


-- -----------------------------
-- Table structure for appliedsurcharge
-- -----------------------------
DROP TABLE IF EXISTS `appliedsurcharge`;
CREATE TABLE `appliedsurcharge` (
    `AppliedSurchargeID` int(11) NOT NULL AUTO_INCREMENT,
    `ParkingSessionID` int(11) NOT NULL,
    `DynamicPricingRuleID` int(11) NOT NULL,
    `SurchargePercent` decimal(5,2) NOT NULL,
    `SurchargeAmount` decimal(10,2) NOT NULL,
    PRIMARY KEY (`AppliedSurchargeID`) USING BTREE,
    INDEX `ParkingSessionID`(`ParkingSessionID` ASC) USING BTREE,
    INDEX `DynamicPricingRuleID`(`DynamicPricingRuleID` ASC) USING BTREE,
    CONSTRAINT `appliedsurcharge_ibfk_1` FOREIGN KEY (`ParkingSessionID`) REFERENCES `parkingsession` (`ParkingSessionID`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `appliedsurcharge_ibfk_2` FOREIGN KEY (`DynamicPricingRuleID`) REFERENCES `dynamicpricingrule` (`DynamicPricingRuleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `appliedsurcharge` VALUES (1, 1, 1, 20.00, 3.00);
INSERT INTO `appliedsurcharge` VALUES (2, 2, 4, 25.00, 6.00);
INSERT INTO `appliedsurcharge` VALUES (3, 3, 3, 10.00, 1.80);
INSERT INTO `appliedsurcharge` VALUES (4, 4, 2, 15.00, 2.03);
INSERT INTO `appliedsurcharge` VALUES (5, 5, 5, 5.00, 0.30);
INSERT INTO `appliedsurcharge` VALUES (6, 6, 5, 5.00, 0.60);
INSERT INTO `appliedsurcharge` VALUES (7, 7, 3, 10.00, 2.10);
INSERT INTO `appliedsurcharge` VALUES (8, 8, 2, 15.00, 2.93);
INSERT INTO `appliedsurcharge` VALUES (9, 9, 5, 5.00, 0.75);
INSERT INTO `appliedsurcharge` VALUES (10, 10, 2, 15.00, 1.58);


-- -----------------------------
-- Table structure for staff
-- -----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
    `StaffID` int(11) NOT NULL AUTO_INCREMENT,
    `StaffName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `Role` enum('Technician','Manager','Attendant','FinanceOfficer') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `AssignedLocation` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`StaffID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `staff` VALUES (1, 'Ahmed Kamal', 'Technician', 'Bukit Bintang Parking Lot');
INSERT INTO `staff` VALUES (2, 'Siti Rahmah', 'Technician', 'KL Sentral Parking Lot');
INSERT INTO `staff` VALUES (3, 'Lee Chong', 'Manager', 'Bukit Bintang Parking Lot');
INSERT INTO `staff` VALUES (4, 'Rajesh Menon', 'Manager', 'Cyberjaya Parking Lot');
INSERT INTO `staff` VALUES (5, 'Fatimah Zain', 'Attendant', 'Jalan Ampang Parking Lot');
INSERT INTO `staff` VALUES (6, 'John Tan', 'Attendant', 'Golden Horse Plaza Parking Lot');
INSERT INTO `staff` VALUES (7, 'Nor Azizah', 'FinanceOfficer', 'Headquarters Finance Office');
INSERT INTO `staff` VALUES (8, 'Muthu Palani', 'FinanceOfficer', 'Headquarters Finance Office');
INSERT INTO `staff` VALUES (9, 'Aisha Omar', 'Technician', 'Jalan Ampang Parking Lot');
INSERT INTO `staff` VALUES (10, 'David Ng', 'Manager', 'KL Sentral Parking Lot');
INSERT INTO `staff` VALUES (11, 'Sarah Lim', 'Attendant', 'Cyberjaya Parking Lot');
INSERT INTO `staff` VALUES (12, 'Chong Wei', 'Technician', 'Golden Horse Plaza Parking Lot');


-- Staff subtype tables (EER inheritance)
DROP TABLE IF EXISTS `technician`;
CREATE TABLE `technician` (
    `StaffID` int(11) NOT NULL,
    PRIMARY KEY (`StaffID`) USING BTREE,
    CONSTRAINT `technician_ibfk_1` FOREIGN KEY (`StaffID`) REFERENCES `staff` (`StaffID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `technician` VALUES (1),(2),(9),(12);

DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
    `StaffID` int(11) NOT NULL,
    PRIMARY KEY (`StaffID`) USING BTREE,
    CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`StaffID`) REFERENCES `staff` (`StaffID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `manager` VALUES (3),(4),(10);

DROP TABLE IF EXISTS `attendant`;
CREATE TABLE `attendant` (
    `StaffID` int(11) NOT NULL,
    PRIMARY KEY (`StaffID`) USING BTREE,
    CONSTRAINT `attendant_ibfk_1` FOREIGN KEY (`StaffID`) REFERENCES `staff` (`StaffID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `attendant` VALUES (5),(6),(11);

DROP TABLE IF EXISTS `financeofficer`;
CREATE TABLE `financeofficer` (
    `StaffID` int(11) NOT NULL,
    PRIMARY KEY (`StaffID`) USING BTREE,
    CONSTRAINT `financeofficer_ibfk_1` FOREIGN KEY (`StaffID`) REFERENCES `staff` (`StaffID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `financeofficer` VALUES (7),(8);


-- -----------------------------
-- Table structure for maintenanceaction
-- -----------------------------
DROP TABLE IF EXISTS `maintenanceaction`;
CREATE TABLE `maintenanceaction` (
    `MaintenanceID` int(11) NOT NULL AUTO_INCREMENT,
    `SpotID` int(11) NOT NULL,
    `TechnicianID` int(11) NOT NULL,
    `Date` date NOT NULL,
    `DescriptionOfWork` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`MaintenanceID`) USING BTREE,
    INDEX `SpotID`(`SpotID` ASC) USING BTREE,
    INDEX `TechnicianID`(`TechnicianID` ASC) USING BTREE,
    CONSTRAINT `maintenanceaction_ibfk_1` FOREIGN KEY (`SpotID`) REFERENCES `parkingspot` (`SpotID`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `maintenanceaction_ibfk_2` FOREIGN KEY (`TechnicianID`) REFERENCES `technician` (`StaffID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `maintenanceaction` VALUES (1, 1, 1, '2025-01-10', 'Sensor Calibration');
INSERT INTO `maintenanceaction` VALUES (2, 2, 1, '2025-01-05', 'Sensor Replacement');
INSERT INTO `maintenanceaction` VALUES (3, 3, 2, '2025-01-08', 'EV Charger Maintenance');
INSERT INTO `maintenanceaction` VALUES (4, 5, 2, '2025-01-03', 'Motorbike Spot Sensor Repair');
INSERT INTO `maintenanceaction` VALUES (5, 7, 9, '2025-01-07', 'Premium Covered Lighting Fix');
INSERT INTO `maintenanceaction` VALUES (6, 9, 12, '2025-01-02', 'Standard Spot Sensor Replacement');
INSERT INTO `maintenanceaction` VALUES (7, 11, 9, '2025-01-06', 'EV Charger Software Update');
INSERT INTO `maintenanceaction` VALUES (8, 13, 1, '2025-01-01', 'Premium Covered Sensor Calibration');
INSERT INTO `maintenanceaction` VALUES (9, 14, 12, '2025-01-14', 'EV Charger Hardware Check');
INSERT INTO `maintenanceaction` VALUES (10, 15, 2, '2025-01-04', 'Motorbike Spot Lighting Repair');


-- -----------------------------
-- Table structure for pointearning
-- -----------------------------
DROP TABLE IF EXISTS `pointearning`;
CREATE TABLE `pointearning` (
    `EarningID` int(11) NOT NULL AUTO_INCREMENT,
    `ClientID` int(11) NOT NULL,
    `EarningDate` date NOT NULL,
    `PointsEarned` int(11) NOT NULL,
    `EarningType` enum('OffPeakParking','EVChargerUsage','MultiVehicleRegistration') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`EarningID`) USING BTREE,
    INDEX `ClientID`(`ClientID` ASC) USING BTREE,
    CONSTRAINT `pointearning_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `client` (`ClientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `pointearning` VALUES (1, 1, '2025-02-02', 50, 'EVChargerUsage');
INSERT INTO `pointearning` VALUES (2, 2, '2025-02-02', 10, 'OffPeakParking');
INSERT INTO `pointearning` VALUES (3, 3, '2025-02-02', 30, 'MultiVehicleRegistration');
INSERT INTO `pointearning` VALUES (4, 4, '2025-02-02', 60, 'EVChargerUsage');
INSERT INTO `pointearning` VALUES (5, 5, '2025-02-02', 15, 'OffPeakParking');
INSERT INTO `pointearning` VALUES (6, 6, '2025-02-02', 25, 'MultiVehicleRegistration');
INSERT INTO `pointearning` VALUES (7, 7, '2025-02-02', 40, 'EVChargerUsage');
INSERT INTO `pointearning` VALUES (8, 8, '2025-02-02', 70, 'OffPeakParking');
INSERT INTO `pointearning` VALUES (9, 9, '2025-02-02', 20, 'MultiVehicleRegistration');
INSERT INTO `pointearning` VALUES (10, 10, '2025-02-02', 55, 'EVChargerUsage');


-- -----------------------------
-- Table structure for pointredemption
-- -----------------------------
DROP TABLE IF EXISTS `pointredemption`;
CREATE TABLE `pointredemption` (
    `RedemptionID` int(11) NOT NULL AUTO_INCREMENT,
    `ClientID` int(11) NOT NULL,
    `RedemptionDate` date NOT NULL,
    `PointsUsed` int(11) NOT NULL,
    PRIMARY KEY (`RedemptionID`) USING BTREE,
    INDEX `ClientID`(`ClientID` ASC) USING BTREE,
    CONSTRAINT `pointredemption_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `client` (`ClientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `pointredemption` VALUES (1, 1, '2025-02-03', 100);
INSERT INTO `pointredemption` VALUES (2, 2, '2025-02-03', 50);
INSERT INTO `pointredemption` VALUES (3, 3, '2025-02-03', 150);
INSERT INTO `pointredemption` VALUES (4, 4, '2025-02-03', 200);
INSERT INTO `pointredemption` VALUES (5, 5, '2025-02-03', 30);
INSERT INTO `pointredemption` VALUES (6, 6, '2025-02-03', 80);
INSERT INTO `pointredemption` VALUES (7, 7, '2025-02-03', 120);
INSERT INTO `pointredemption` VALUES (8, 8, '2025-02-03', 250);
INSERT INTO `pointredemption` VALUES (9, 9, '2025-02-03', 40);
INSERT INTO `pointredemption` VALUES (10, 10, '2025-02-03', 90);


-- -----------------------------
-- Table structure for referralbonus
-- -----------------------------
DROP TABLE IF EXISTS `referralbonus`;
CREATE TABLE `referralbonus` (
    `ReferralBonusID` int(11) NOT NULL AUTO_INCREMENT,
    `ReferrerClientID` int(11) NOT NULL,
    `NewClientID` int(11) NOT NULL,
    `NewClientBrand` enum('Pro','Tourist','Both') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `FirstSessionZone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`ReferralBonusID`) USING BTREE,
    INDEX `ReferrerClientID`(`ReferrerClientID` ASC) USING BTREE,
    INDEX `NewClientID`(`NewClientID` ASC) USING BTREE,
    CONSTRAINT `referralbonus_ibfk_1` FOREIGN KEY (`ReferrerClientID`) REFERENCES `client` (`ClientID`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `referralbonus_ibfk_2` FOREIGN KEY (`NewClientID`) REFERENCES `client` (`ClientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

INSERT INTO `referralbonus` VALUES (1, 1, 12, 'Both', 'KL Sentral Zone A');
INSERT INTO `referralbonus` VALUES (2, 4, 14, 'Tourist', 'Golden Horse Plaza Zone B');
INSERT INTO `referralbonus` VALUES (3, 8, 11, 'Pro', 'KL Sentral Zone A');
INSERT INTO `referralbonus` VALUES (4, 10, 13, 'Pro', 'Jalan Ampang Zone C');
INSERT INTO `referralbonus` VALUES (5, 3, 15, 'Both', 'Cyberjaya Zone B');
INSERT INTO `referralbonus` VALUES (6, 1, 9, 'Pro', 'KL Sentral Zone D');
INSERT INTO `referralbonus` VALUES (7, 4, 7, 'Tourist', 'Golden Horse Plaza Zone C');
INSERT INTO `referralbonus` VALUES (8, 8, 5, 'Pro', 'Jalan Ampang Zone A');
INSERT INTO `referralbonus` VALUES (9, 10, 2, 'Tourist', 'Cyberjaya Zone A');
INSERT INTO `referralbonus` VALUES (10, 3, 6, 'Both', 'The Gardens Mall Zone A');
INSERT INTO `referralbonus` VALUES (11, 7, 4, 'Both', 'The Gardens Mall Zone B');

SET FOREIGN_KEY_CHECKS = 1;


-- =====================================================
-- PART C: SQL REPORT (20 marks)
-- =====================================================

-- Q5. KLParkEasy Pro ブランドの Corporate EV 所有者一覧
SELECT c.ClientName, v.PlateNumber
FROM CorporateClient cc
JOIN Client c ON cc.ClientID = c.ClientID
    JOIN Vehicle v ON c.ClientID = v.ClientID
    JOIN EVVehicle ev ON v.PlateNumber = ev.PlateNumber
    JOIN ClientBrand cb ON c.ClientID = cb.ClientID
    JOIN Brand b ON cb.BrandID = b.BrandID
WHERE b.BrandName = 'KLParkEasy Pro' AND ev.IsEV = 'Yes';


-- Q6. Bukit Bintang ゾーンの総 BaseCharge 収益
SELECT SUM(BaseCharge)
FROM parkingsession
WHERE parkingsession.SpotID IN (
    SELECT SpotID
    FROM parkingspot
    WHERE LocationZone LIKE "Bukit Bintang%"
);


-- Q7. センサーが Offline のスポット一覧
SELECT
    pspt.SpotID,
    pspt.LocationZone,
    pspt.LastMaintenanceDate
FROM ParkingSpot pspt
WHERE pspt.SensorStatus = 'Offline';


-- Q8. Gold Tier ユーザーの FinalCharge 計算
--     (3時間 × 5.00 × 1.20 サーチャージ × (1 - 5%割引))
SELECT
    (5.00 * 3) AS BaseCharge,
    (5.00 * 3) * 1.20 AS BaseChargeWithSurcharge,
    (5.00 * 3) * 1.20 * (1 - COALESCE(ad.DiscountPercent, 0) / 100) AS FinalCharge
FROM AppliedDiscount ad
WHERE ad.DiscountType = 'GoldTier';


-- Q9. LPR 失敗セッションのゾーン別集計
SELECT
    pspt.LocationZone,
    COUNT(ps.ParkingSessionID) AS FailureSessionCount
FROM ParkingSession ps
JOIN ParkingSpot pspt ON ps.SpotID = pspt.SpotID
WHERE ps.LPRFailureCount >= 1
GROUP BY pspt.LocationZone;


-- Q10. Blockchain Token 支払い客の ParkPoints Top 10
SELECT
    c.ClientName,
    c.ParkPointsBalance,
    c.LoyaltyTier,
    b.BrandName
FROM Client c
    JOIN ClientBrand cb ON c.ClientID = cb.ClientID
    JOIN Brand b ON cb.BrandID = b.BrandID
WHERE
    c.PreferredPaymentMethod = 'Blockchain Token'
ORDER BY
    c.ParkPointsBalance DESC
LIMIT 10;


-- =====================================================
-- PART D: ANALYTICAL REPORTS (15 marks)
-- 5つの分析レポート - 様々な SQL 演算子を活用
-- =====================================================

-- Report 1: ロイヤリティ階層別収益分析
-- 使用演算子: JOIN, GROUP BY, 集計関数 (COUNT/SUM/AVG/ROUND)
-- 目的: 各ロイヤリティ階層の収益貢献度を分析
SELECT
    c.LoyaltyTier,
    COUNT(ps.ParkingSessionID) AS TotalTransactions,
    SUM(ps.FinalCharge) AS TotalRevenue,
    ROUND(AVG(ps.FinalCharge), 2) AS AvgRevenuePerSession
FROM Client c
JOIN Vehicle v ON c.ClientID = v.ClientID
JOIN ParkingSession ps ON v.PlateNumber = ps.VehiclePlateNumber
GROUP BY c.LoyaltyTier
ORDER BY TotalRevenue DESC;


-- Report 2: トップ10 顧客生涯収益ランキング
-- 使用演算子: 複数 JOIN, GROUP BY, ORDER BY, LIMIT
-- 目的: 最も収益に貢献している上位10顧客を特定
SELECT
    c.ClientID,
    c.ClientName,
    c.LoyaltyTier,
    c.BrandAffiliation,
    SUM(ps.FinalCharge) AS LifetimeRevenue
FROM Client c
JOIN Vehicle v ON c.ClientID = v.ClientID
JOIN ParkingSession ps ON v.PlateNumber = ps.VehiclePlateNumber
GROUP BY
    c.ClientID,
    c.ClientName,
    c.LoyaltyTier,
    c.BrandAffiliation
ORDER BY LifetimeRevenue DESC
LIMIT 10;


-- Report 3: ピーク時間 vs オフピーク時間の収益比較
-- 使用演算子: CASE WHEN, 条件集計, JOIN
-- 目的: ゾーン別にピーク/オフピーク時間の収益構造を比較
SELECT
    p.LocationZone,
    SUM(
        CASE
            WHEN HOUR(ps.StartTime) BETWEEN 7 AND 9
              OR HOUR(ps.StartTime) BETWEEN 17 AND 19
            THEN ps.FinalCharge
            ELSE 0
        END
    ) AS PeakHourRevenue,
    SUM(
        CASE
            WHEN NOT (
                HOUR(ps.StartTime) BETWEEN 7 AND 9
                OR HOUR(ps.StartTime) BETWEEN 17 AND 19
            )
            THEN ps.FinalCharge
            ELSE 0
        END
    ) AS OffPeakRevenue
FROM ParkingSession ps
JOIN ParkingSpot p ON ps.SpotID = p.SpotID
GROUP BY p.LocationZone;


-- Report 4: 平均利用時間が全体平均を上回るクライアント (ネストクエリ)
-- 使用演算子: サブクエリ (ネスト), HAVING, AVG
-- 目的: 駐車時間が長いヘビーユーザーを特定
SELECT
    c.ClientID,
    c.ClientName,
    ROUND(AVG(ps.DurationHours), 2) AS AvgDuration
FROM Client c
JOIN Vehicle v ON c.ClientID = v.ClientID
JOIN ParkingSession ps ON v.PlateNumber = ps.VehiclePlateNumber
GROUP BY
    c.ClientID,
    c.ClientName
HAVING AVG(ps.DurationHours) > (
    SELECT AVG(DurationHours)
    FROM ParkingSession
)
ORDER BY AvgDuration DESC;


-- Report 5: ゾーン別パフォーマンスサマリー
-- 使用演算子: JOIN, 集計関数の組み合わせ (COUNT/SUM/AVG/ROUND)
-- 目的: 各ゾーンの運営パフォーマンスを多角的に評価
SELECT
    p.LocationZone,
    COUNT(ps.ParkingSessionID) AS TotalTransactions,
    SUM(ps.FinalCharge) AS TotalRevenue,
    ROUND(AVG(ps.DurationHours), 2) AS AvgParkingDuration
FROM ParkingSpot p
JOIN ParkingSession ps ON p.SpotID = ps.SpotID
GROUP BY p.LocationZone
ORDER BY TotalRevenue DESC;


-- =====================================================
-- PART E: UNFORESEEN CHALLENGES (15 marks)
-- 洪水警報ディスカウント機能 - Monsoon Climate Impact への対応
-- =====================================================

-- 1. ParkingSpot に洪水リスクレベルカラムを追加
ALTER TABLE parkingspot
ADD COLUMN FloodRiskLevel ENUM('Low','Medium','High')
DEFAULT 'Low';


-- 2. 洪水リスクイベントテーブルの新規作成
DROP TABLE IF EXISTS floodriskevent;
CREATE TABLE floodriskevent (
    FloodRiskEventID INT AUTO_INCREMENT PRIMARY KEY,
    SpotID INT NOT NULL,
    RiskLevel ENUM('Low','Medium','High') NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME DEFAULT NULL,
    Source VARCHAR(50) DEFAULT 'WeatherAPI',
    INDEX idx_floodrisk_time (SpotID, StartTime),
    CONSTRAINT floodriskevent_ibfk_1
        FOREIGN KEY (SpotID) REFERENCES parkingspot(SpotID)
        ON DELETE CASCADE ON UPDATE CASCADE
);


-- 3. ParkingSession に割引追跡用カラムを追加
ALTER TABLE parkingsession
ADD COLUMN FloodDiscountApplied ENUM('Yes','No') DEFAULT 'No',
ADD COLUMN FloodDiscountAmount DECIMAL(10,2) DEFAULT 0.00;


-- 4. 洪水警報割引タイプを割引マスタに追加
INSERT INTO applieddiscount (DiscountType, DiscountPercent)
VALUES ('FloodWarning', 50.00);


-- 5. 新規駐車セッション開始時に洪水リスクをチェックし
--    High リスク時に自動で 50% 割引を適用するトリガー
DROP TRIGGER IF EXISTS trg_apply_flood_discount;
DELIMITER $$

CREATE TRIGGER trg_apply_flood_discount
BEFORE INSERT ON parkingsession
FOR EACH ROW
BEGIN
    DECLARE v_risk ENUM('Low','Medium','High');

    SELECT fr.RiskLevel
    INTO v_risk
    FROM floodriskevent fr
    WHERE fr.SpotID = NEW.SpotID
      AND NEW.StartTime BETWEEN fr.StartTime AND IFNULL(fr.EndTime, NOW())
    ORDER BY fr.StartTime DESC
    LIMIT 1;

    IF v_risk = 'High' THEN
        SET NEW.FloodDiscountApplied = 'Yes';
        SET NEW.FloodDiscountAmount = NEW.BaseCharge * 0.50;
        SET NEW.FinalCharge = NEW.BaseCharge - NEW.FloodDiscountAmount;
    END IF;
END$$

DELIMITER ;


-- =====================================================
-- 設計上のメリット:
-- 1. アプリ側のロジックに依存せず、DBレベルで整合性を保証
-- 2. 透明性のある自動割引で顧客信頼を維持
-- 3. 履歴データの正確性（監査対応）
-- 4. AIベースの予測/サージプライシング拡張の基盤となる
-- =====================================================
-- END OF FILE
-- =====================================================
