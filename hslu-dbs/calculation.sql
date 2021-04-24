SET @tournamentId = 2065; /*frenchopen=2467, usopen=2065*/
SET @maxDate = date('2018/12/31');

SET @first1 = 'Novak';			/*Novak */
SET @last1 = 'Djokovic';		/*Djokovic */
SET @first2 = 'Juan Martin';	/*Andy Stan */
SET @last2 = 'del Potro';		/*Murray Wawrinka */

SET @p1 = 0;
SET @p2 = 0;
SELECT player.pId INTO @p1 FROM player WHERE player.lastName = @last1 AND player.firstName = @first1;
SELECT player.pId INTO @p2 FROM player WHERE player.lastName = @last2 AND player.firstName = @first2;


SET @p2Rank = 100000;



SET @fromDate = date('2000/08/1');
SET @toDate = @maxDate;
SET @pitchId = 0;

/**get match date**/
SELECT matches.date, matches.piId INTO @toDate, @pitchId FROM matches WHERE matches.tId = @tournamentId AND matches.date < (@maxDate) ORDER BY matches.date desc LIMIT 1;
SET @fromDate = CAST(@fromDate AS DATE);

/*get player 1 ranking at that point in time */
SET @p1Pts = 0;
SELECT IF(matches.wpId = @p1, matches.wpts ,matches.lpts )/10 INTO @p1Pts FROM matches WHERE (matches.wpId = @p1 OR matches.lpId = @p1)   AND matches.date < (@toDate) ORDER BY matches.date desc LIMIT 1;
SET @p1Pts = CAST( @p1Pts AS decimal);

/*get player 2 ranking at that point in time */
SET @p2Pts = 0;
SELECT IF(matches.wpId = @p2, matches.wpts ,matches.lpts )/10 INTO @p2Pts FROM matches WHERE (matches.wpId = @p2 OR matches.lpId = @p2)   AND matches.date < (@toDate) ORDER BY matches.date desc LIMIT 1;
SET @p2Pts = CAST( @p2Pts AS decimal);


SET @h2h1Wins = 0;
SELECT count(m.mId) into @h2h1Wins FROM matches as m where m.wpId = @p1 AND m.lpId = @p2 LIMIT 5;

SET @h2h2Wins = 0;
SELECT count(m.mId) into @h2h2Wins FROM matches as m where m.wpId = @p2 AND m.lpId = @p1 LIMIT 5;



/* get player2 form**/
SET @form2W = 0;
SET @form2L = 0;

SELECT count(mId) into @form2W  FROM player,matches
WHERE player.pId = @p2 AND (player.pId = matches.wpId) AND matches.date between @fromDate and @toDate
Group by pId;

SELECT count(mId) into @form2L  FROM player,matches
WHERE player.pId = @p2 AND (player.pId = matches.lpId ) AND matches.date between @fromDate and @toDate
Group by pId;

SET @form2T = @form2W + @form2L;

/* get player2 pitch form**/
SET @pitch2W = 0;
SET @pitch2L = 0;

SELECT count(mId) into @pitch2W  FROM player,matches, pitch
WHERE player.pId = @p2 AND (player.pId = matches.wpId) AND matches.date between @fromDate and @toDate AND matches.piId = pitch.piId AND pitch.piId = @pitchId
Group by pId;

SELECT count(mId) into @pitch2L  FROM player,matches, pitch
WHERE player.pId = @p2 AND (player.pId = matches.lpId ) AND matches.date between @fromDate and @toDate AND matches.piId = pitch.piId AND pitch.piId = @pitchId
Group by pId;

SET @pitch2T = @pitch2W + @pitch2L;


/* get player1 form**/
SET @form1W = 0;
SET @form1L = 0;

SELECT count(mId) into @form1W  FROM player,matches
WHERE player.pId = @p1 AND (player.pId = matches.wpId) AND matches.date between @fromDate and @toDate
Group by pId;

SELECT count(mId) into @form1L  FROM player,matches
WHERE player.pId = @p1 AND (player.pId = matches.lpId ) AND matches.date between @fromDate and @toDate
Group by pId;

SET @form1T = @form1W + @form1L;

/* get player1 pitch form**/
SET @pitch1W = 0;
SET @pitch1L = 0;

SELECT count(mId) into @pitch1W  FROM player,matches, pitch
WHERE player.pId = @p1 AND (player.pId = matches.wpId) AND matches.date between @fromDate and @toDate AND matches.piId = pitch.piId AND pitch.piId = @pitchId
Group by pId;

SELECT count(mId) into @pitch1L  FROM player,matches, pitch
WHERE player.pId = @p1 AND (player.pId = matches.lpId ) AND matches.date between @fromDate and @toDate AND matches.piId = pitch.piId AND pitch.piId = @pitchId
Group by pId;

SET @pitch1T = @pitch1W + @pitch1L;


SET @p1Power = (@p1Pts * (1+@h2h1Wins + (@form1T/100*@form1W) + (@pitch1T/100*@pitch1W)));
SET @p2Power = (@p2Pts * (1+@h2h2Wins + (@form2T/100*@form2W) + (@pitch2T/100*@pitch2W)));
SET @p1Odds = 100/(@p1Power + @p2Power) * @p1Power;
SET @p2Odds = 100 / (@p1Power + @p2Power ) * @p2Power;

SELECT @toDate, @fromDate, @pitchId, @p1, @p1Pts, @h2h1Wins, @form1T,@form1W, @form1L, @pitch1T, @pitch1W,@pitch1L, @p2, @p2Pts, @h2h2Wins, @form2T,@form2W, @form2L, @pitch2T, @pitch2W,@pitch2L, truncate(@p1Power,2), truncate(@p2Power,2), truncate(@p1Odds,2) AS 'Player 1 Odds', truncate(@p2Odds,2) AS'Player 2 Odds';

/*****************************************RESULT*********************************************/
SELECT tournament.name AS 'Tournament', @toDate AS 'Match Date', concat(concat(@first1,' '), @last1) AS 'Player 1',  truncate(@p1Odds,2) AS 'Odds Player 2', concat(concat(@first2,' '), @last2)  AS 'Player 2',truncate(@p2Odds,2) AS 'Odds Player 2' FROM tournament WHERE tournament.tId = @tournamentId LIMIT 1;
