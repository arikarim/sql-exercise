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
  AND name NOT LIKE '% %'
