SELECT name
  FROM world
 WHERE population >= 200000000;

 SELECT name, gdp/population
  FROM world
 WHERE population >= 200000000;

 SELECT name, population
  FROM world
 WHERE name IN ('france', 'germany', 'italy');

 SELECT name
  FROM world
 WHERE name like '%united%';

 SELECT name
  FROM world
 WHERE name like '%united%'

select name, population, area
from world
where (population >= 250000000 and area < 3000000) or (area >= 3000000 and population < 250000000);

select name, round(population/1000000, 2),  round(gdp/1000000000, 2)from world
where continent = 'South America';


