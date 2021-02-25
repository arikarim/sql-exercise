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


