SELECT name
  FROM world
 WHERE population >= 200000000;

-- South America In millions
 SELECT name, gdp/population
  FROM world
 WHERE population >= 200000000;

-- France, Germany, Italy
 SELECT name, population
  FROM world
 WHERE name IN ('france', 'germany', 'italy');

-- United
 SELECT name
  FROM world
 WHERE name like '%united%';

-- Two ways to be big
 SELECT name
  FROM world
 WHERE name like '%united%'

-- One or the other (but not both)
select name, population, area
from world
where (population >= 250000000 and area < 3000000) or (area >= 3000000 and population < 250000000);

-- Rounding
select name, round(population/1000000, 2),  round(gdp/1000000000, 2)from world
where continent = 'South America';

-- Trillion dollar economies
SELECT name, (round((gdp/population)/1000,0) * 1000)
from world
where gdp > 1000000000000;

-- Name and capital have the same length
SELECT name,
       capital
  FROM world
 WHERE LEN(NAME) = LEN(capital)

-- Matching name and capital
SELECT name, capital
FROM world
where (LEFT(name,1) = LEFT(capital,1)) AND name <> capital

-- All the vowels
SELECT name
   FROM world
WHERE name LIKE '%a%' and name LIKE '%e%' and name LIKE '%i%' and name LIKE '%o%' and name LIKE '%u%' 
  AND name NOT LIKE '% %';

-- Winners from 1950
  SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

-- 1962 Literature
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'literature'

-- Albert Einstein
select yr, subject
from nobel
where winner =  'Albert Einstein' 

-- Recent Peace Prizes
select winner
from nobel
where subject = 'peace' and yr >= 2000

-- Literature in the 1980's
select * 
from nobel
where yr between 1980 and 1989 and subject = 'literature'

-- Only Presidents
SELECT * FROM nobel
 WHERE winner in ('Theodore Roosevelt','Woodrow Wilson','Jimmy Carter','Barack Obama')

-- john
select winner
from nobel
where winner like 'john%'

-- Chemistry and Physics from different years
select *
from nobel
where (subject = 'physics' and yr = 1980) or (subject ='chemistry' and yr = 1984)

-- Exclude Chemists and Medics
select * from nobel
where (yr = 1980) and subject <> 'Chemistry' and subject <> 'medicine'

-- Early Medicine, Late Literature
select * from nobel
where (subject = 'medicine' and yr < 1910) or subject = 'literature' and yr > 2003

-- Umlaut
select * from nobel
where winner = 'PETER GRÜNBERG'

-- Apostrophe
select * from nobel
where winner like '%EUGENE %' and winner like '%neill%'

-- Knights of the realm
select winner, yr, subject from nobel
where winner like 'sir%' order by yr desc , winner

-- Chemistry and Physics last
SELECT winner, subject
  FROM Nobel
 WHERE yr = 1984
 ORDER BY case when subject IN ('Physics', 'Chemistry')then 1 else 0 end,subject, winner

-- Bigger than Russia
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- Richer than UK
select name from world
where continent = 'europe' and gdp/population > (select gdp/population from world where name ='united kingdom' )

-- Neighbours of Argentina and Australia
select name,continent from world
where name =(select name from world where name = 'argentina' or name = 'australia')

-- Between Canada and Poland
select name, population 
from world
where population > (select population from world where name = 'canada') and population < (select population from world where name = 'poland')

-- Percentages of Germany
select name, 
            CONCAT(ROUND(100*population/(select population 
                                from world 
                                 where name = 'germany'),0), '%')
from world where continent = 'europe'

-- Bigger than every country in Europe
SELECT name
  FROM world
 WHERE gdp > ALL(SELECT gdp
                           FROM world
                          WHERE gdp>0 and continent = 'europe')

-- Largest in each continent
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)

-- First country of each continent (alphabetically
SELECT continent, name FROM world x
  WHERE name <= ALL
    (SELECT name FROM world y
        WHERE y.continent=x.continent)

-- Difficult Questions That Utilize Techniques Not Covered In Prior Sections
SELECT name, continent, population FROM world x
  WHERE 25000000 >= ALL(SELECT population
	                FROM world y
		        WHERE x.continent = y.continent
                        AND y.population>0);


SELECT name, continent FROM world x
  WHERE population >= ALL(SELECT population*3
                         FROM world y
                         WHERE x.continent = y.continent
                         and y.name != x.name)


-- Total world population
SELECT SUM(population)
FROM world

-- List of continents
select distinct continent from world

-- GDP of Africa
select sum(gdp)
from world
where continent = 'africa'

-- Count the big countries
select count(area)
from world
where area > 1000000

-- Baltic states population
select sum(population)
from world
where name IN ('Estonia', 'Latvia', 'Lithuania'

-- Counting the countries of each continent
select continent, count(continent)
from world
group by continent

-- Counting big countries in each continent
select continent, count(continent)
from world
where population > 10000000
group by continent

-- Counting big continents
select continent 
from world
group by continent
having sum(population) > 100000000

-- JOIN and UEFA EURO 2012
SELECT matchid, player FROM goal 
  WHERE teamid = 'ger'

2/
SELECT id,stadium,team1,team2
  FROM game
where id = 1012

3/
SELECT player,teamid,stadium,mdate
  FROM game JOIN goal ON (id=matchid)
where teamid = 'ger'

4/
select team1,team2, player from game join goal on (id=matchid)
where player like 'mario%'

5/
SELECT player, teamid, coach, gtime
  FROM goal join eteam on(teamid=id)
 WHERE gtime<=10

6/
select mdate, teamname
from game join eteam on (team1=eteam.id)
where coach like 'fernando%'

7/
select player 
from game join goal on (id = matchid)
where stadium like '%warsaw'

8/
SELECT distinct player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER'or team2='ger') and teamid != 'ger'

9/
SELECT teamname, count(player)
  FROM eteam JOIN goal ON id=teamid
 group BY teamname

10/
select stadium, count(player)
from game join goal on id = matchid
group by stadium

11/
SELECT matchid,mdate, count(player)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
group by matchid,mdate

12/
select matchid, mdate,count(player)
from goal join game on id = matchid
where (team1 = 'ger' or team2 = 'ger') and teamid = 'ger'
group by matchid,mdate

13/
SELECT DISTINCT mdate, team1,
	SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
    team2,
    SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game
LEFT JOIN goal ON game.id = goal.matchid
GROUP BY id, mdate, team1, team2


-- MORE JOIN 
1/
SELECT id, title
 FROM movie
 WHERE yr=1962

 2/
 select yr
from movie
where title like '%kane'

3/
select id,title,yr
from movie
where title like '%star trek%'

4/
select id
from actor
where name = 'glenn close'

5/
select id from movie
where title = 'casablanca'

6/
select name 
from actor join casting on id=actorid
where movieid = 27

7/
SELECT name FROM casting
  JOIN actor ON (actor.id=actorid)
  JOIN movie ON (movie.id=movieid)
  WHERE title = 'Alien'

8/
select title
from casting join actor on actor.id = actorid
join movie on movie.id =  movieid
where name = 'Harrison Ford'

9/
select title
from casting join actor on actor.id = actorid
join movie on movie.id =  movieid
where name = 'Harrison Ford' and ord >1

10/
select title,name from casting
join actor on actor.id = actorid
join movie on movie.id = movieid
where yr = 1962 and ord = 1

11/
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

12/
SELECT title, name FROM casting
  JOIN movie ON movie.id = movieid
  JOIN actor ON actor.id = actorid
WHERE ord = 1
	AND movie.id IN
	(SELECT movie.id FROM movie
	   JOIN casting ON movie.id = movieid
	   JOIN actor ON actor.id = actorid
           WHERE actor.name = 'Julie Andrews')

13/
SELECT DISTINCT name FROM casting
  JOIN movie ON movie.id = movieid
  JOIN actor ON actor.id = actorid
  WHERE actorid IN (
	SELECT actorid FROM casting
	  WHERE ord = 1
	  GROUP BY actorid
	  HAVING COUNT(actorid) >= 15)
ORDER BY name

14/
SELECT title, COUNT(actorid) FROM casting
  JOIN movie ON movieid = movie.id
  WHERE yr = 1978
  GROUP BY movieid, title
  ORDER BY COUNT(actorid) DESC

15/
SELECT DISTINCT name FROM casting
  JOIN actor ON actorid = actor.id
  WHERE name != 'Art Garfunkel'
	AND movieid IN (
		SELECT movieid
		FROM movie
		JOIN casting ON movieid = movie.id
		JOIN actor ON actorid = actor.id
		WHERE actor.name = 'Art Garfunkel'
)

-- USING NULL
1/
select name from teacher
where dept is null

2/
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

3/
SELECT teacher.name, dept.name
 FROM teacher left JOIN dept
           ON (teacher.dept=dept.id)

4/
SELECT teacher.name, dept.name
 FROM dept left JOIN teacher
           ON (teacher.dept=dept.id)

5/
select name,coalesce(mobile,'07986 444 2266')from teacher

6/
select teacher.name, coalesce(dept.name,'none')
from teacher left join dept on dept.id = teacher.dept

7/
select count(name),count(mobile)
from teacher

8/
select dept.name, count(teacher.dept)
from teacher right join dept on dept.id = teacher.dept
group by dept.name

9/
SELECT name, CASE WHEN dept IN (1,2) THEN 'Sci'
                  ELSE 'Art'
                  END
                  FROM teacher

10/
SELECT name, CASE WHEN dept IN (1,2) THEN 'Sci'
                  WHEN dept = 3 THEN 'Art'
                  ELSE 'None'
                  END
                  FROM teacher

-- SELF JOIN 
1/
select count(name) from stops

2/
select id from stops
where name = 'Craiglockhart'

3/
SELECT id, name FROM stops JOIN route ON (stops.id = route.stop)
  WHERE num = 4

4/
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
having count(*) >1

5/
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 and b.stop=149

6/
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' and stopb.name='London road'

7/
SELECT distinct a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' and stopb.name='Leith'

8/
SELECT distinct a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'  and stopb.name= 'Tollcross'

9/
SELECT DISTINCT name, a.company, a.num
FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN stops ON a.stop = stops.id
WHERE b.stop = 53;

10/
SELECT a.num, a.company, stopb.name, c.num, c.company
FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN (route c JOIN route d ON (c.company = d.company AND c.num = d.num))
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
JOIN stops stopc ON c.stop = stopc.id
JOIN stops stopd ON d.stop = stopd.id
WHERE stopa.name = 'Craiglockhart'
	AND stopd.name = 'Sighthill'
	AND stopb.name = stopc.name
ORDER BY LENGTH(a.num), b.num, stopb.name, LENGTH(c.num), d.num;





