/*
DEPRECATED


DROP PROCEDURE IF EXISTS form_player;

DELIMITER //
CREATE PROCEDURE form_player
(IN playerId int, IN fromDatum date, IN toDatum date, OUT total INT, OUT wins INT, OUT losses INT)
BEGIN
SELECT (
SELECT count(mId)  FROM player,matches
WHERE player.pId = playerId AND (player.pId = matches.wpId OR player.pId = matches.lpId ) AND matches.date between fromDatum and toDatum
Group by pId
) AS TotalMatches,
(
SELECT count(mId)  FROM player,matches
WHERE player.pId = playerId AND (player.pId = matches.wpId) AND matches.date between fromDatum and toDatum
Group by pId
) AS Wins,
(
SELECT count(mId)  FROM player,matches
WHERE player.pId = playerId AND (player.pId = matches.lpId ) AND matches.date between fromDatum and toDatum
Group by pId
) AS Loses INTO @total, @wins, @losses
;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS form_player_pitch;
DELIMITER //
CREATE PROCEDURE form_player_pitch
(IN firstName VARCHAR(250),IN lastName VARCHAR(250), IN fromDatum date, IN toDatum date, IN pitchtype INT)
BEGIN
SELECT (
SELECT count(mId)  FROM player,matches, pitch
WHERE player.lastName = lastName AND player.firstName = firstName AND (player.pId = matches.wpId OR player.pId = matches.lpId ) AND matches.date between fromDatum and toDatum AND matches.piId = pitch.piId AND pitch.piId = pitchtype
Group by pId
) AS TotalMatches,
(
SELECT count(mId)  FROM player,matches,  pitch
WHERE player.lastName = lastName AND player.firstName = firstName AND (player.pId = matches.wpId) AND matches.date between fromDatum and toDatum AND matches.piId = pitch.piId AND pitch.piId = pitchtype
Group by pId
) AS Wins,
(
SELECT count(mId)  FROM player,matches, pitch
WHERE player.lastName =  lastName AND player.firstName = firstName AND (player.pId = matches.lpId ) AND matches.date between fromDatum and toDatum AND matches.piId = pitch.piId AND pitch.piId = pitchtype
Group by pId
) AS Loses ;
END //
DELIMITER ;
*/
/* 
input = player 1Id, player 2Id, tournament Id, datum 
*/