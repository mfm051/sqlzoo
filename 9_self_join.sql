-- This exercise uses two tables:
--  stops (id, name)
--  route (num, company, pos, stop)
-- As different companies use numbers arbitrarily 
-- the num and the company are both required to identify a route

-- 1. How many stops are in the database
SELECT COUNT(*) 
  FROM stops;

-- 2. Find the id value for the stop 'Craiglockhart'
SELECT id 
  FROM stops 
 WHERE name = 'Craiglockhart';

-- 3. Give the id and the name for the stops on the '4' 'LRT' service
SELECT id, name 
  FROM stops
   JOIN route ON stops.id = stop
 WHERE num = '4' AND company = 'LRT';

-- 4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).
-- Run the query and notice the two services that link these stops have a count of 2.
-- Add a HAVING clause to restrict the output to these two routes.
SELECT company, num, COUNT(*) AS stops_count
  FROM route 
 WHERE stop = 149 OR stop = 53
 GROUP BY company, num
 HAVING stops_count = 2;

-- 5. Change the query so that it shows the services from Craiglockhart to London Road
SELECT a.company, a.num, a.stop, b.stop
  FROM route a 
   JOIN route b ON (a.company = b.company AND a.num = b.num)
 WHERE a.stop = 53 AND b.stop = (SELECT id FROM stops WHERE name = 'London Road');

-- 6. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown
SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a 
   JOIN route b ON (a.company = b.company AND a.num = b.num)
   JOIN stops stopa ON (a.stop = stopa.id)
   JOIN stops stopb ON (b.stop = stopb.id)
 WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road';

-- 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT a.company, a.num
  FROM route a 
   JOIN route b ON (a.company = b.company AND a.num = b.num)
   JOIN stops stopa ON (stopa.id = a.stop)
   JOIN stops stopb ON (stopb.id = b.stop)
 WHERE stopa.name = 'Haymarket' AND stopb.name = 'Leith';

-- 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT a.company, a.num 
  FROM route a 
   JOIN route b ON (a.company = b.company) AND (a.num = b.num)
   JOIN stops stopa ON stopa.id = a.stop
   JOIN stops stopb ON stopb.id = b.stop
 WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross';

-- 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus,
-- including 'Craiglockhart' itself, offered by the LRT company.
SELECT stopb.name, a.company, a.num
  FROM route a 
   JOIN route b ON (a.company = b.company AND a.num = b.num)
   JOIN stops stopa ON (stopa.id = a.stop)
   JOIN stops stopb ON (stopb.id = b.stop)
 WHERE (a.company = 'LRT') AND (stopa.name = 'Craiglockhart');

-- 10. Find the routes involving two buses that can go from Craiglockhart to Lochend
SELECT DISTINCT bus1.num, bus1.company, t1stop.name transfer, bus2.num, bus2.company
  FROM route bus1
   JOIN route transfer1 ON (bus1.num = transfer1.num) AND (bus1.company = transfer1.company)
   JOIN route transfer2 ON (transfer1.stop = transfer2.stop)
   JOIN route bus2 ON (transfer2.num = bus2.num) AND (transfer2.company = bus2.company)
   JOIN stops b1stop ON (bus1.stop = b1stop.id)
   JOIN stops t1stop ON (transfer1.stop = t1stop.id)
   JOIN stops t2stop ON (transfer2.stop = t2stop.id)
   JOIN stops b2stop ON (bus2.stop = b2stop.id)
 WHERE (b1stop.name = 'Craiglockhart') AND (b2stop.name = 'Lochend')
 ORDER BY bus1.num, transfer, bus2.num;

-- NOTE: Got the idea of using two routes to each bus from https://stackoverflow.com/a/63046817