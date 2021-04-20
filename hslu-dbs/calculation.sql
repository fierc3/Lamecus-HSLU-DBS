DROP PROCEDURE IF EXISTS form_player;

DELIMITER //
CREATE PROCEDURE form_player
(IN firstName VARCHAR(250),IN lastName VARCHAR(250), IN fromDatum date, IN toDatum date)
BEGIN
SELECT (
SELECT count(mId)  FROM player,matches
WHERE player.lastName = lastName AND player.firstName = firstName AND (player.pId = matches.wpId OR player.pId = matches.lpId ) AND matches.date between fromDatum and toDatum
Group by pId
) AS TotalMatches,
(
SELECT count(mId)  FROM player,matches
WHERE player.lastName = lastName AND player.firstName = firstName AND (player.pId = matches.wpId) AND matches.date between fromDatum and toDatum
Group by pId
) AS Wins,
(
SELECT count(mId)  FROM player,matches
WHERE player.lastName =  lastName AND player.firstName = firstName AND (player.pId = matches.lpId ) AND matches.date between fromDatum and toDatum
Group by pId
) AS Loses;
END //
DELIMITER ;



/* 
input = player 1Id, player 2Id, tournament Id, datum 
*/
SET @tournamentId = 2050;
SET @maxDate = date('2021/04/20');

SET @first1 = 'Novak';
SET @last1 = 'Djokovic';
SET @first2 = 'Adrian';
SET @last2 = 'Mannarino';


SET @fromDate = date('2000/08/1');
SET @toDate = @maxDate;

/**get match date**/
SELECT matches.date INTO @toDate  FROM matches WHERE matches.tId = @tournamentId AND matches.date < (@maxDate) ORDER BY matches.date desc LIMIT 1;
SET @fromDate = CAST(@fromDate AS DATE);
SELECT @toDate, @fromDate;


/* get player2 form**/
CALL form_player(@first2 , @last2, @fromDate, @toDate);


