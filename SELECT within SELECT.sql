/*

name	         continent	 area	    population	      gdp
Afghanistan	    Asia	     652230	  25500100	   20343000000
Albania	        Europe	   28748	   2831741	   12960000000
Algeria	        Africa	  2381741	   37100000	   188681000000
Andorra	        Europe	   468	     78115	     3712000000
Angola	        Africa	  1246700	  20609294	   100990000000
...


*/

/*Ouestion 1
List each country name where the population is larger than that of 'Russia'.*/

SELECT name FROM world
WHERE population > (SELECT population FROM world WHERE name='Russia')



/*Question 2
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'. */

select name
from world
where continent = 'Europe' and
gdp/population > (select gdp/population from world where name = 'United Kingdom')

/*Question 3
List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.*/

select name, continent from world
where continent in (select continent from world where name in ('Argentina' , 'Australia'))
ORDER BY name

/*Question 4
Which country has a population that is more than Canada but less than Poland? Show the name and the population.*/

select name , population from world
where (population > (select population from world where name = 'Canada') ) AND
(population < (select population from world where name = 'Poland') )

/*Question 5
Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

The format should be Name, Percentage for example:

name	percentage
Albania	3%
Andorra	0%
Austria	11%
...	...
*/

select name, CONCAT(round(population*100/(select SUM(population) from world where name = 'Germany'),0), '%') as percentage
from world
where continent = 'Europe'

/*
Question 6
Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)*/

select name from world 
where gdp > (select max(gdp) from world where continent = 'Europe')

/*Question 7
Find the largest country (by area) in each continent, show the continent, the name and the area: */
SELECT continent, name, area 
FROM world
WHERE area IN (SELECT MAX(area) 
                  FROM world 
                 GROUP BY continent)
                 
/*Question 8
List each continent and the name of the country that comes first alphabetically.*/
SELECT continent, MIN(name) AS name
FROM world 
GROUP BY continent
ORDER by continent

/*Question 9
Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.*/
select name , continent , population from world x where 
25000000 > ALL(select population from world y where x.continent = y.continent)


/*Question 10
Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.*/

select name ,continent from world x
where x.population > ALL(select (population*3) from world y where x.continent = y.continent AND x.name != y.name)

