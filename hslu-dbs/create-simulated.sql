CREATE TABLE SimulatedTournament (
stId int NOT NULL AUTO_INCREMENT,
tId int NOT NULL,
startDate date NOT NULL,
PRIMARY KEY (stId),
FOREIGN KEY (tId) references tournament(tId)
);


CREATE TABLE SimulatedParticipant(
spId int not null auto_increment,
pId int not null,
position int not null,
stId int not null,
PRIMARY KEY (spId),
FOREIGN KEY (pId) references player(pId),
FOREIGN KEY (stId) references simulatedtournament(stId)
);


CREATE TABLE SimulatedMatch (
smId int NOT NULL AUTO_INCREMENT,
stId int NOT NULL,
matchDate date NOT NULL,
sp1Id int,
sp2Id int,
p1Odds decimal,
p2Odds decimal,
PRIMARY KEY (smId),
FOREIGN KEY (stId) references SimulatedTournament(stId),
FOREIGN KEY (sp1Id) references SimulatedParticipant(spId),
FOREIGN KEY (sp2Id) references SimulatedParticipant(spId)
);



ALTER TABLE `lamecus`.`simulatedmatch` 
ADD COLUMN `round` INT NULL AFTER `p2Odds`;
