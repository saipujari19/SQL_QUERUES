/*int - whole numbers                                                           data types in sql which is most widely used
varchar(1) -  string of text of length 1
BLOB - Binary large object which stores large data
decimal(m, n) -  decimal with exact values
date - "YYYY-MM-DD"
timestamp  - "YYYY-MM-DD" "HH-MM-SS"  */
/*IN SSMS SERVER FOR DISPLAYING ONLY SELECTED ROWS WE CANNOT USE LIMIT FUNCTION, WE SHOULD USE "TOP". */
-- OR /*   */ USED FOR COMMENTING IN SQL

CREATE TABLE student(
 student_id INT,                      /* uniquely identified so we can add a primary key we can also write as PRIMARY KEY(student_id) */
 names VARCHAR(20) NOT NULL,           /* NAMES CANNOT BE EMPTY when not null is is used */
 /*major VARCHAR(20) UNIQUE   when this keyword is used the inserted data must be unique */
 major VARCHAR(20) DEFAULT 'undecided' /*when the major is not specifiednwe can use default and add something in it */
 PRIMARY KEY(student_id)
 ); 

 drop table student;

 SELECT * FROM student;

 ALTER TABLE student ADD gpa DECIMAL(3,2); 

 ALTER TABLE student DROP column gpa;

 INSERT INTO student VALUES(4,'Jack', 'Biology');
 INSERT INTO student VALUES(5, 'Mike', 'Computer Science');
 /*INSERT INTO student(student_id, names) VALUES(3, 'Claire');  when we dont know some fields to enter data it displays as null
 INSERT INTO student (student_id, names) VALUES(1, 'Jack'); */
 INSERT INTO student VALUES(1,'Jack', 'Biology');
 INSERT INTO student VALUES(2, 'Kate', 'Sociology');
 INSERT INTO student VALUES(3, 'NULL', 'Chemistry');

 UPDATE student 
 SET names = 'Claire'
 WHERE student_id = 3

 UPDATE student
 SET names = 'king', major = 'undecided'
 WHERE major = 'Biology'

 
 UPDATE student
 SET major = 'Biology'
 WHERE major = 'BIO' OR major = 'computer science'

 DELETE FROM student
 WHERE student_id = 5

 DELETE FROM student
 WHERE names = 'king' AND major = 'undecided'

 SELECT student_id, names 
 FROM student WHERE 
 major = 'Biology' OR names = 'Kate';

 SELECT student.names, student.major /* order by clause */
 FROM student
 ORDER BY names;                     /* by default they are arranged in ascending order.*/

/* for descending order we must use DESC*/

SELECT *
FROM student
ORDER BY student_id DESC


SELECT *
FROM student
ORDER BY student_id ASC /* arranged in ascending order.*/

SELECT * FROM
student
ORdER BY names, major DESC

SELECT * FROM student LIMIT/* limit amy be not working in all data bases.*/

select top 3 *    /* FOR DISPLAYING ONLY MENTIONED ROWS*/
from student
order by student_id desc


 SELECT *
 FROM student WHERE 
 major<>'Biology';

 -- <> NOT EQUAL
/* = EQUAL
 . GREATER THAN
 < LESSER THAN
 <= LESS THAN OR WQUAL TO
 >= GREATER THAN OR EQUAL TO
 AND OPERATOR
 OR OPERATOR 
 IN OPERATOR */


 
 SELECT *
 FROM student 
 WHERE major IN ('chemistry', 'biology') AND student_id < 2;








 
