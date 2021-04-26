/*
5142 nadal
4560 djokovic
4635 federer
5563 Wawrinka
4562 del Potro
4571 delbonis
5477 thiem
4365 bryan mike
4785 haider-maurer
5280 andy roddick
5083 andy murray
*/


/*				Tournament start  			*/
SET @stId = 1;
SET @maxDate = date('2018/8/13');
SET @tId = 2065; /*frenchopen=2467, usopen=2065*/


SET @round = 1;
SET @participantCount = 0;

SELECT COUNT(pId) INTO @participantCount FROM simulatedparticipant as sp WHERE sp.stId = @stId; 


INSERT INTO simulatedmatch(stId, matchDate, sp1Id, sp2Id, round, p1Odds, p2Odds)
SELECT @stId, @maxDate, p1.spId, p2.spId, @round, -1000,-1000 FROM simulatedparticipant p1, simulatedparticipant p2 WHERE p1.position/2 != FORMAT(p1.position/2,0) AND p1.position + 1 = p2.position;





/*PER MATCH LOGIC */

SET @player1 = cast(0 as decimal);
SET @player2 = cast(0 as decimal);
SET @matchId = 0;
SET @matchDate = @maxdate;

SELECT sp.pId, sp2.pId, sm.smId, sm.matchDate INTO @player1, @player2, @matchId, @matchDate FROM simulatedmatch sm, simulatedparticipant sp, simulatedparticipant sp2 WHERE @stId=sm.stId AND sm.round = @round AND sm.p1Odds = -1000 AND sp.spId = sm.sp1Id AND (sp2.spId = sm.sp2Id OR sm.sp2Id is null) LIMIT 1; 

SET @player1Odds = 0;
SET @player2Odds = 0;

CALL matchOdds(@player1,@player2,@matchDate, @tId, @player1Odds,@player2Odds);

SELECT @player1, @player1Odds, @player2, @player2Odds;

Update simulatedmatch 
SET p1Odds = @player1Odds, p2Odds = @player2Odds
WHERE smId = @matchId;



/*generate matches next round*/
SET @round = @round+1;
SET @rownum := 0;
SELECT @round;

CREATE TEMPORARY TABLE tempmatches
SELECT @round,sm.stId, DATE_SUB(sm.matchDate, INTERVAL -1 DAY), IF(sm.p1Odds > sm.p2Odds, sp1Id, sp2Id) as spId, @rownum := @rownum + 1 as position FROM simulatedmatch sm WHERE sm.round = @round-1;

CREATE TEMPORARY TABLE homeplayers
SELECT @stId, @maxDate, p1.spId, p1.position, @round FROM tempmatches p1 WHERE p1.position/2 != FORMAT(p1.position/2,0) ;

CREATE TEMPORARY TABLE awayplayers
SELECT @stId, @maxDate, p1.spId, p1.position,  @round FROM tempmatches p1 WHERE p1.position/2 = FORMAT(p1.position/2,0) ;

INSERT INTO simulatedmatch(stId, matchDate, sp1Id, sp2Id, round, p1Odds, p2Odds)
SELECT  @stId, @maxDate, p1.spId, p2.spId, @round, -1000,-1000 FROM homeplayers p1 LEFT JOIN awayplayers p2 on p1.position+1 = p2.position; 

DROP TEMPORARY TABLE tempmatches;
DROP TEMPORARY TABLE homeplayers;
DROP TEMPORARY TABLE awayplayers;


