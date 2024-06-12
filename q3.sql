CREATE DATABASE FuelMonitoring;

USE FuelMonitoring;

CREATE TABLE VehicleOwners (
    OwnerID INT AUTO_INCREMENT PRIMARY KEY,
    OwnerName VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL
);

CREATE TABLE Vehicles (
    VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    OwnerID INT,
    LicensePlate VARCHAR(20) NOT NULL,
    FOREIGN KEY (OwnerID) REFERENCES VehicleOwners(OwnerID)
);

CREATE TABLE FuelStations (
    StationID INT AUTO_INCREMENT PRIMARY KEY,
    StationName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    FuelCompany VARCHAR(255) NOT NULL
);

CREATE TABLE Fuelings (
    FuelingID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleID INT,
    StationID INT,
    FuelingDate DATE,
    WaterMixed BOOLEAN,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
    FOREIGN KEY (StationID) REFERENCES FuelStations(StationID)
);

-- הזנת בעלי רכבים
INSERT INTO VehicleOwners (OwnerName, City) VALUES
('Yossi Cohen', 'Petach Tikva'),
('Rina Levi', 'Tel Aviv'),
('Avi Shwartz', 'Jerusalem'),
('Sara Moshe', 'Haifa'),
('David Yair', 'Rishon Lezion');

-- הזנת רכבים
INSERT INTO Vehicles (OwnerID, LicensePlate) VALUES
(1, '123-45-678'),
(2, '234-56-789'),
(3, '345-67-890'),
(4, '456-78-901'),
(5, '567-89-012');

-- הזנת תחנות דלק
INSERT INTO FuelStations (StationName, Address, City, FuelCompany) VALUES
('Station A', 'Rebbanitzky 8', 'Petach Tikva', 'Sonol'),
('Station B', 'Herzl 12', 'Tel Aviv', 'Paz'),
('Station C', 'Jaffa 45', 'Jerusalem', 'Delek'),
('Station D', 'Haneviim 33', 'Haifa', 'Ten'),
('Station E', 'Rothschild 20', 'Rishon Lezion', 'Sonol');

-- הזנת תדלוקים
INSERT INTO Fuelings (VehicleID, StationID, FuelingDate, WaterMixed) VALUES
(1, 1, '2023-06-01', TRUE),
(2, 2, '2023-06-02', FALSE),
(3, 3, '2023-06-03', TRUE),
(4, 4, '2023-06-04', FALSE),
(5, 5, '2023-06-05', TRUE);



--3.1
SELECT COUNT(DISTINCT VehicleID) AS MixedVehiclesCount
FROM Fuelings
WHERE WaterMixed = TRUE;



--3.2
SELECT City, COUNT(*) AS OwnersCount
FROM VehicleOwners
GROUP BY City
ORDER BY OwnersCount DESC
LIMIT 1;

--3.3
SELECT o.City, (COUNT(DISTINCT f.VehicleID) / COUNT(DISTINCT v.VehicleID)) * 100 AS DamageRate
FROM VehicleOwners o
JOIN Vehicles v ON o.OwnerID = v.OwnerID
JOIN Fuelings f ON v.VehicleID = f.VehicleID
WHERE f.WaterMixed = TRUE
GROUP BY o.City
ORDER BY DamageRate DESC
LIMIT 1;



--3.4
SELECT City, FuelCompany, COUNT(*) AS StationsCount
FROM FuelStations
GROUP BY City, FuelCompany
ORDER BY City, FuelCompany;

--3.5
SELECT o.OwnerName, v.LicensePlate, COUNT(f.FuelingID) AS DamageCount
FROM VehicleOwners o
JOIN Vehicles v ON o.OwnerID = v.OwnerID
JOIN Fuelings f ON v.VehicleID = f.VehicleID
WHERE f.WaterMixed = TRUE
GROUP BY o.OwnerName, v.LicensePlate
ORDER BY DamageCount ASC;


--3.6
CREATE VIEW DamagedVehiclesView AS
SELECT o.OwnerName, v.LicensePlate, o.City, COUNT(f.FuelingID) AS DamageCount
FROM VehicleOwners o
JOIN Vehicles v ON o.OwnerID = v.OwnerID
JOIN Fuelings f ON v.VehicleID = f.VehicleID
WHERE f.WaterMixed = TRUE
GROUP BY o.OwnerName, v.LicensePlate, o.City
ORDER BY DamageCount DESC;


--3.7
CREATE USER 'fuel_monitor_user'@'localhost' IDENTIFIED BY 'password';

GRANT SELECT ON FuelMonitoring.DamagedVehiclesView TO 'fuel_monitor_user'@'localhost';
