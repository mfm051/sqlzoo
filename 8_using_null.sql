-- This exercise uses two tables:
--  teacher (id, dept, name, phone, mobile)
--  dept (id, name)
-- The school includes many departments. Most teachers work exclusively for a single department.
-- Some teachers have no department

-- 1. List the teachers who have NULL for their department
SELECT name 
  FROM teacher 
 WHERE dept IS NULL;

-- 2. Note the INNER JOIN misses the teachers with no department and the departments with no teacher
SELECT teacher.name, dept.name
 FROM teacher 
  INNER JOIN dept ON (teacher.dept = dept.id);

-- 3. Use a different JOIN so that all teachers are listed
SELECT teacher.name, dept.name
  FROM teacher
   LEFT JOIN dept ON teacher.dept = dept.id;

-- 4. Use a different JOIN so that all departments are listed
SELECT teacher.name, dept.name 
  FROM dept
   LEFT JOIN teacher ON dept.id = teacher.dept;

-- 5. Show teacher name and mobile number or '07986 444 2266'
SELECT name, COALESCE(mobile, '07986 444 2266') AS mobile
  FROM teacher;

-- 6. Print the teacher name and department name. Use the string 'None' where there is no department
SELECT teacher.name, COALESCE(dept.name, 'None') AS dept
  FROM teacher
   LEFT JOIN dept ON teacher.dept = dept.id;

-- 7. Use COUNT to show the number of teachers and the number of mobile phones
SELECT COUNT(name) AS num_teachers, COUNT(mobile) AS num_mobs
  FROM teacher;

-- 8. Show each department and the number of staff
SELECT dept.name, COUNT(teacher.id) AS personnel
  FROM teacher
   RIGHT JOIN dept ON teacher.dept = dept.id
 GROUP BY dept.name;

-- 9. Show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise
SELECT name, CASE WHEN dept IN (1,2)
                   THEN 'Sci'
                  ELSE 'Art' END AS dept
  FROM teacher;

-- 10. Show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2,
-- show 'Art' if the teacher's dept is 3 and 'None' otherwise
SELECT name, CASE WHEN dept IN (1,2)
                   THEN 'Sci'
                  WHEN dept = 3
                   THEN 'Art'
                  ELSE 'None' END AS 'dept'
FROM teacher;