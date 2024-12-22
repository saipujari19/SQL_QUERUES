create table employee(

e_id int not null,
e_name varchar(20),
e_salary int,
e_age int,
e_gender varchar(20),
e_depts varchar(20),
primary key(e_id)
);

drop table employee;



insert into employee values(
1,'spp',10000,30,'male','cis'
);


insert into employee values(
2,'sop',1000,34,'female','gis'
);


insert into employee values(
3,'sap',1200,20,'male','ois'
);


insert into employee values(
4,'ssp',13000,37,'female','wis'
);


insert into employee values(
5,'ppp',10200,60,'female','sis'
);


select * from employee;

select distinct e_age from employee; -- particular coloumn will be shown.


select * from employee where e_gender ='male'; -- where condition.

select * from employee where e_age > 20 and e_gender = 'male'; -- -- this executes when both the statements are correct.


select * from employee where e_age < 20 or e_depts = 'cis'; -- this executes when any one of the statement is correct.

select * from employee where not e_gender = 'male'; -- not equal to operator.

select * from employee where e_name like 's%'; -- like operator should end with % and shold be inserted in a single quote.

select * from employee where e_age like '3_'; -- underscore operator is used to print the next missing item.

select * from employee where e_age between 20 and 50; -- displays the output which is mentioned between the inputs.

select min(e_age) from employee; -- minimum function.

select min(e_salary) from employee;


select max(e_salary) from employee; -- maximum function.

select count(*) from employee where e_gender = 'male'; -- how many male or female are there. it just counts.

select sum(e_salary) from employee;-- it gives the total sum. means it adds the values, it cannot be used for variable, as it throws error.

select avg(e_salary) from employee; -- it gives the average of the numeric count. and only valid for the numbers.

select * from employee order by e_salary; -- by default it orders by ascending

select * from employee order by e_age desc;-- it orders in descending order

select top 3 * from employee; -- top clause is used to print the first N in the table.

select top 3 * from employee order by e_salary desc;

select top 3 * from employee order by e_salary;

select sum(e_salary),e_gender from employee group by e_gender;-- this is a group by clause

select avg(e_age), e_gender from employee group by e_gender order by avg(e_age);

select e_depts, avg(e_salary) as avg_salary -- using the having clausekkk
from employee
group by e_depts
having avg(e_salary)> 10000

delete from employee where e_age = 60;

alter table employee
add blood_group varchar(20)

update employee
set blood_group = 'O+ve'
where e_id = 1

update employee
set blood_group = 'A-ve'
where e_id = 2


update employee
set blood_group = 'AB-ve'
where e_id = 3


update employee
set blood_group = 'B-ve'
where e_id = 4


select * from employee;

update employee
set e_salary = 1003
where e_id = 4

drop table department;


create table department(
d_id int,
d_name varchar(20),
d_city varchar(20)
);


insert into department values(
11, 'wis', 'new york'
)

insert into department values(
12, 'QA', 'ohio'
)

insert into department values(
13, 'cis', 'boston'
)

insert into department values(
14, 'tech', 'florida'
)

select * from department;
select * from employee;

select employee.e_name, employee.e_depts, department.d_name, department.d_city
from employee
inner join department on employee.e_depts = department.d_name; -- inner join, and this results a data below as the data provided above are not same.

select employee.e_name, employee.e_depts, department.d_name, department.d_city
from employee
left join department on employee.e_depts = department.d_name; -- left inner join. 

select employee.e_name, e_depts, department.d_name, d_city
from employee
right join department on e_depts = d_name;-- right join

select employee.e_name, e_depts, department.d_name, d_city
from employee
full join department on e_depts = d_name; -- full join


update employee 
set e_age = e_age + 10
from employee
join department on e_depts = d_name
where d_city = 'new york';

select * from employee
union                    -- combines both the inputs and gives the output which are same. it discards null value
select * from department




select * from employee
union all                -- combines both the inputs and gives the output which are same. includes null value
select * from department


select * from employee
except
select * from department

--All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.



select * from employee
intersect
select * from department

create view female_employees as 
select * from employee
where e_gender = 'female';   -- creating a table using view from the output which is visible

select * from female_employees;

--drop view female_employees; drops the view table

alter table employee
add e_dob date;

alter table employee
drop column e_dob;  -- dropping individual column






















 
