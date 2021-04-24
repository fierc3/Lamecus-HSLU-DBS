
/*
	Constants
*/
INSERT INTO series (name)
SELECT DISTINCT SERIES FROM atp_matches_2019;

INSERT INTO pitch (court,surface)
SELECT DISTINCT court, surface FROM atp_matches_2019;

INSERT INTO round (name)
SELECT DISTINCT round FROM atp_matches_2019;

INSERT IGNORE INTO tournament (sId, name, location)
SELECT DISTINCT series.sId, A.tournament, A.location FROM atp_matches_2015 as A, series
WHERE series.name = A.series;


INSERT IGNORE INTO player (firstName, lastName, countryCode, weight, height, birthYear, handed, backhand, nameDisplay)
SELECT first_name, last_name, flag_code, weight_kg, height_cm, birth_year, handedness, backhand, full_name FROM atp_players;

/*
matches / dynamic
Read all matches with players from the player db.
Might be changed.
*/

INSERT INTO matches (date, l1,l2,l3,l4,l5,w1,w2,w3,w4,w5,wrank,lrank,lpts,wpts,bestOf,tId,rId,wpId,lpId,piId)
SELECT DISTINCT str_to_date(a.match_date,'%Y-%m-%d'), a.l1, a.l2,a.l3,a.l4,a.l5,a.w1,a.w2,a.w3,a.w4,a.w5, a.wrank, a.lrank, a.lpts, a.wpts, a.best_of, tournament.tId, round.rId, winner.pId, loser.pId, pitch.piId  
FROM atp_matches_2015 AS a, series, tournament, round, player AS winner, player AS loser, pitch
WHERE winner.nameDisplay = REPLACE(a.winner,'.','') AND loser.nameDisplay = REPLACE(a.loser,'.','') AND a.tournament = tournament.name AND a.round = round.name AND a.court = pitch.court AND a.surface = pitch.surface 
;
