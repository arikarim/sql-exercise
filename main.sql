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



