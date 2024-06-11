CREATE DATABASE q1;
USE q1;

CREATE TABLE sites (
    location VARCHAR(100) PRIMARY KEY,
    district VARCHAR(100)
);

CREATE TABLE resistence_days(
    date DATE PRIMARY KEY,
    budget_r FLOAT
);

CREATE TABLE events(
    start_time DATETIME PRIMARY KEY,
    location VARCHAR(100),
    date DATE,
    FOREIGN KEY (location) REFERENCES sites(location),
    FOREIGN KEY (date) REFERENCES resistence_days(date),
    budget_e FLOAT
    );

CREATE TABLE resistence_groups(
    name VARCHAR(100) PRIMARY KEY
);

CREATE TABLE lawyers(
    licence_number VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100)
    );

CREATE TABLE protestors(
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100)
    );


CREATE TABLE lawyer_protestor (
    licence_number VARCHAR(10),
    id VARCHAR(10),
    PRIMARY KEY (licence_number, id),
    FOREIGN KEY (licence_number) REFERENCES lawyers(licence_number),
    FOREIGN KEY (id) REFERENCES protestors(id)
);



CREATE TABLE resistance_group_protestor (
    name VARCHAR(100),
    id VARCHAR(10),
    PRIMARY KEY (name, id),
    FOREIGN KEY (name) REFERENCES resistence_groups(name),
    FOREIGN KEY (id) REFERENCES protestors(id)
);

CREATE TABLE protestor_event (
    id VARCHAR(10),
    start_time DATETIME,
    PRIMARY KEY (id, start_time),
    FOREIGN KEY (id) REFERENCES protestors(id),
    FOREIGN KEY (start_time) REFERENCES events(start_time),
    job VARCHAR(100),
    equipment VARCHAR(100) 
    );

CREATE TABLE policeman(
    badge_number VARCHAR(10) PRIMARY KEY
    );






CREATE TABLE policeman_event (
    badge_number VARCHAR(10),
    start_time DATETIME,
    PRIMARY KEY (badge_number, start_time),
    FOREIGN KEY (badge_number) REFERENCES policeman(badge_number),
    FOREIGN KEY (start_time) REFERENCES events(start_time)
    );
    

CREATE TABLE policeman_protestor (
    badge_number VARCHAR(10),
    id VARCHAR(10),
    PRIMARY KEY (badge_number, id),
    FOREIGN KEY (badge_number) REFERENCES policeman(badge_number),
    FOREIGN KEY (id) REFERENCES protestors(id)
    );
SHOW TABLES;



