CREATE DATABASE q1;
USE q1;

CREATE TABLE sites (
    location VARCHAR(100) PRIMARY KEY,
    district VARCHAR(100)
);

insert into sites (location, district) VALUES 
('Kaplan Street', 'Tel Aviv'), 
('Kizilay Square', 'Cankaya'), 
('Kugulu Park', 'Cankaya') , 
('Times Square', 'Manhattan'), 
('Taksim Square', 'Beyoglu');

insert into sites (location, district) VALUES 
('eiffel tower', 'paris');

CREATE TABLE resistence_days(
    date DATE PRIMARY KEY,
    budget_r FLOAT
);


insert into resistence_days (date, budget_r) VALUES 
('2020-01-01', 1000), 
('2020-01-02', 2000), 
('2020-01-03', 3000), 
('2020-01-04', 4000), 
('2020-01-05', 5000);



CREATE TABLE events(
    start_time TIME PRIMARY KEY,
    location VARCHAR(100),
    date DATE,
    FOREIGN KEY (location) REFERENCES sites(location),
    FOREIGN KEY (date) REFERENCES resistence_days(date),
    budget_e FLOAT
    );


INSERT into events (start_time, location, date, budget_e) VALUES
('12:00:00', 'Kaplan Street', '2020-01-01', 1000),
('13:00:00', 'Kizilay Square', '2020-01-02', 200),
('14:00:00', 'Kugulu Park', '2020-01-03', 300),
('15:00:00', 'Times Square', '2020-01-04', 400),
('16:00:00', 'Taksim Square', '2020-01-05', 500);

-- i altered the table for question ט
ALTER TABLE events
ADD COLUMN budget_manager VARCHAR(10),
ADD FOREIGN KEY (budget_manager) REFERENCES protestors(id);

update events
set budget_manager='1234567'
where start_time='12:00:00';

update events
set budget_manager='2345678'
where start_time='13:00:00';

update events
set budget_manager='3456789'
where start_time='14:00:00';

update events
set budget_manager='4567890'
where start_time='15:00:00';

update events
set budget_manager='5678901'
where start_time='16:00:00';


-- i added this line for the question that needs to sum the budget per budget_manager
insert into events 
(start_time, location, date, budget_e, budget_manager)
values ('17:00:00', 'eiffel tower', '2020-01-01', 10000000, '1234567');

--

CREATE TABLE resistence_groups(
    name VARCHAR(100) PRIMARY KEY
);

insert into resistence_groups (name) VALUES 
('Black Lives Matter'), 
('Extinction Rebellion'), 
('Fridays for Future'), 
('Greenpeace'), 
('Idle No More');

CREATE TABLE lawyers(
    licence_number VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100)
    );

insert into lawyers (licence_number, name) VALUES 
('1234', 'John Doe'), 
('5678', 'Jane Doe'), 
('9101', 'John Smith'), 
('1121', 'Jane Smith'), 
('3141', 'John Johnson');

CREATE TABLE protestors(
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100)
    );

INSERT INTO protestors (id, name) 
VALUES 
('1234567', 'Michael Scott'), 
('2345678', 'Jim Halpert'), 
('3456789', 'Pam Beesly'), 
('4567890', 'Dwight Schrute'), 
('5678901', 'Angela Martin');


--represents
CREATE TABLE lawyer_protestor (
    licence_number VARCHAR(10),
    id VARCHAR(10),
    PRIMARY KEY (licence_number, id),
    FOREIGN KEY (licence_number) REFERENCES lawyers(licence_number),
    FOREIGN KEY (id) REFERENCES protestors(id)
);

insert into lawyer_protestor (licence_number, id) VALUES 
('1234', '1234567'), 
('5678', '2345678'), 
('9101', '3456789'), 
('1121', '4567890'), 
('3141', '5678901');


i
CREATE TABLE resistance_group_protestor (
    name VARCHAR(100),
    id VARCHAR(10),
    PRIMARY KEY (name, id),
    FOREIGN KEY (name) REFERENCES resistence_groups(name),
    FOREIGN KEY (id) REFERENCES protestors(id)
);

insert into resistance_group_protestor (name, id) VALUES 
('Black Lives Matter', '1234567'), 
('Extinction Rebellion', '2345678'), 
('Fridays for Future', '3456789'), 
('Greenpeace', '4567890'), 
('Idle No More', '5678901');


--participates
CREATE TABLE protestor_event (
    id VARCHAR(10),
    start_time TIME,
    PRIMARY KEY (id, start_time),
    FOREIGN KEY (id) REFERENCES protestors(id),
    FOREIGN KEY (start_time) REFERENCES events(start_time),
    job VARCHAR(100),
    equipment VARCHAR(100) 
    );


INSERT INTO protestor_event (id, start_time, job, equipment) 
VALUES 
('1234567', '12:00:00', 'leader', 'megaphone'), 
('2345678', '13:00:00', 'organizer', 'banner'), 
('3456789', '14:00:00', 'speaker', 'flag'), 
('4567890', '15:00:00', 'participant', 'sign'), 
('5678901', '16:00:00', 'participant', 'sign');
CREATE TABLE policeman(
    badge_number VARCHAR(10) PRIMARY KEY
    );

INSERT into policeman (badge_number) VALUES 
('1234'), 
('5678'), 
('9101'), 
('1121'), 
('3141');



--trying to prevent
CREATE TABLE policeman_event (
    badge_number VARCHAR(10),
    start_time TIME,
    PRIMARY KEY (badge_number, start_time),
    FOREIGN KEY (badge_number) REFERENCES policeman(badge_number),
    FOREIGN KEY (start_time) REFERENCES events(start_time)
    );


insert into policeman_event (badge_number, start_time) VALUES 
('1234', '12:00:00'), 
('5678', '13:00:00'), 
('9101', '14:00:00'), 
('1121', '15:00:00'), 
('3141', '16:00:00');



CREATE TABLE policeman_protestor (
    badge_number VARCHAR(10),
    id VARCHAR(10),
    success BOOLEAN,
    PRIMARY KEY (badge_number, id),
    FOREIGN KEY (badge_number) REFERENCES policeman(badge_number),
    FOREIGN KEY (id) REFERENCES protestors(id)
    );



-- is arresting
INSERT INTO policeman_protestor (badge_number, id, success) 
VALUES 
('1234', '1234567', TRUE), 
('5678', '2345678', FALSE), 
('9101', '3456789', TRUE), 
('1121', '4567890', FALSE), 
('3141', '5678901', TRUE);


-- ג
ALTER TABLE policeman_protestor
DROP COLUMN success,
ADD COLUMN protestors_comment VARCHAR(255),
ADD COLUMN jail VARCHAR(255);


alter table policeman
add column name varchar(100);

update policeman
set name = 'cop_a'
where badge_number = '1234';

update policeman
set name = 'cop_b'
where badge_number = '5678';

update policeman
set name = 'cop_c'
where badge_number = '9101';

update policeman
set name = 'cop_d'
where badge_number = '1121';

update policeman
set name = 'cop_e'
where badge_number = '3141';

-- ד
UPDATE policeman_protestor
SET protestors_comment = 'Comment for 1234', jail = 'Jail for 1234'
WHERE badge_number = '1234';

UPDATE policeman_protestor
SET protestors_comment = 'Comment for 5678', jail = 'Jail for 5678'
WHERE badge_number = '5678';

UPDATE policeman_protestor
SET protestors_comment = 'Comment for 9101', jail = 'Jail for 9101'
WHERE badge_number = '9101';

update policeman_protestor
set protestors_comment = 'Comment for 1121', jail = 'Jail for 1121'
where badge_number = '1121';

update policeman_protestor 
set protestors_comment = 'Comment for 3141', jail = 'Jail for 3141'
where badge_number = '3141';

-- ה
SELECT COUNT(DISTINCT jail) AS NumberOfJails
FROM policeman_protestor;
--ו
SELECT p.name AS PolicemanName, pr.name AS ProtestorName, pp.jail AS JailName
FROM policeman_protestor pp
JOIN policeman p ON pp.badge_number = p.badge_number
JOIN protestors pr ON pp.id = pr.id;

--ז 
SELECT 
    (CAST((SELECT COUNT(*) FROM protestors WHERE id NOT IN (SELECT id FROM lawyer_protestor)) AS FLOAT) / CAST((SELECT COUNT(*) FROM protestors) AS FLOAT)) * 100 AS PercentageOfUnrepresentedProtestors



--ח

-- ט

SELECT p.name, SUM(e.budget_e) AS total_budget
FROM events e
JOIN protestors p ON e.budget_manager = p.id
GROUP BY p.name
HAVING SUM(e.budget_e) > 32000;

--י

create table budget_managers(
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    budget FLOAT
    );

INSERT INTO budget_managers (id, name, budget)
SELECT p.id, p.name, SUM(e.budget_e) AS total_budget
FROM events e
JOIN protestors p ON e.budget_manager = p.id
GROUP BY p.id, p.name;

-- יא
CREATE TEMPORARY TABLE IF NOT EXISTS temp_avgbudget AS (SELECT AVG(budget) AS avg_budget FROM budget_managers);

DELETE FROM budget_managers
WHERE budget < (SELECT avg_budget FROM temp_avgbudget);


DROP TEMPORARY TABLE IF EXISTS temp_avgbudget;