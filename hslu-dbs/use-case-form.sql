SET @from ='2020/08/1';
SET @to = '2020/12/31';
SET @first = 'Djokovic';
SET @last = 'Novak';


SELECT (
SELECT count(mId)  FROM player,matches
WHERE player.lastName = @first AND player.firstName = @last AND (player.pId = matches.wpId OR player.pId = matches.lpId ) AND matches.date between @from and @to
Group by pId
) AS TotalMatches,
(
SELECT count(mId)  FROM player,matches
WHERE player.lastName = @first AND player.firstName = @last AND (player.pId = matches.wpId) AND matches.date between @from and @to
Group by pId
) AS Wins,
(
SELECT count(mId)  FROM player,matches
WHERE player.lastName =  @first AND player.firstName = @last AND (player.pId = matches.lpId ) AND matches.date between @from and @to
Group by pId
) AS Loses