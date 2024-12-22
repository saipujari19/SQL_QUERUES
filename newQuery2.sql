create table student(
s_id int,
s_name varchar(20),
s_age int,
s_dept varchar(20),
s_marks int
);

drop table student;

insert into student values(
1,'roy',16,'electronics',80
);


insert into student values(
2,'roy',16,'electronics',80
);


insert into student values(
3,'ray',26,'economics',70
);


insert into student values(
4,'yoy',46,'social',90
);


insert into student values(
5,'tuy',19,'hindi',65
);




alter table student
add gender varchar(20)

update student
set gender= 'female'
where s_age = 16


update student
set gender= 'male'
where s_id = 2


update student
set gender= 'female'
where s_marks = 80


update student
set gender= 'male'
where s_name ='yoy'


update student
set gender= 'female'
where s_name ='tuy'

select * from student;

update student
set s_dept = 'maths'
where s_id = 1

update student
set s_dept ='chemistry'
where s_id = 2

update student
set gender = 'male'
where s_marks = 70


select * from student where s_name= 'roy';

select distinct s_age from student;


select distinct s_name from student;

select * from student where s_age = 19 or s_marks> 90;

select * from student where not s_gender = 'female';

select * from student where s_name like 'r%';

select * from student where s_age like '1_';

select * from student where s_marks between 50 and 80;

select min(s_marks) from student;

select count(*) from student where s_marks = 100;

select sum(s_id) from student;

select avg(s_marks) from student; 