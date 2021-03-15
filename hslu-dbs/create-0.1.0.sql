
CREATE DATABASE lamecus;


CREATE TABLE Series (
sId int NOT NULL AUTO_INCREMENT,
name varchar(255),
PRIMARY KEY (sId)
);

CREATE TABLE Tournament (
tId int NOT NULL AUTO_INCREMENT,
sId int NOT NULL,
name varchar(255),
location varchar(255),
PRIMARY KEY (tId),
FOREIGN KEY (sId) references Series(sId)
);

CREATE TABLE Round (
rId int NOT NULL AUTO_INCREMENT,
name varchar(255),
PRIMARY KEY (rId)
);


CREATE TABLE Player (
pId int NOT NULL AUTO_INCREMENT,
firstName varchar(255),
lastName varchar(255),
countryCode varchar(5),
weight int,
height int,
birthYear int,
handed ENUM('right','left'),
backhand ENUM('one','two'),
PRIMARY KEY (pId)
);

CREATE TABLE Pitch (
piId int NOT NULL AUTO_INCREMENT,
court ENUM('indoor','outdoor'),
surface ENUM('hard','grass', 'clay'),
PRIMARY KEY (piId)
);


CREATE TABLE Matches (
mId int NOT NULL AUTO_INCREMENT,
date Date,
l1 int,
l2 int,
l3 int,
l4 int,
l5 int,
w1 int,
w2 int,
w3 int,
w4 int,
w5 int,
wrank int,
lrank int,
lpts int,
wpts int,
bestOf int,
tId int,
rId int,
wpId int,
lpId int,
piId int,

PRIMARY KEY (mId),
FOREIGN KEY (tId) references  Tournament(tId),
FOREIGN KEY (rId) references  Round(rId),
FOREIGN KEY (wpId) references Player(pId),
FOREIGN KEY (lpId) references  Player(pId),
FOREIGN KEY (piId) references  Pitch(piId)
);matches