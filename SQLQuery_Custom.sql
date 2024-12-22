create table customer(
c_id int primary key,
c_name varchar(200),
c_address varchar(250),
c_city varchar(40),
c_pincode varchar(50),
c_country varchar(20)
);

insert into customer values(
1, 'pollard', '5360 lownden drive', 'johnsville', 41043, 'united states'
)

insert into customer values(
2, 'jennie', '5670 inwood drive', 'boston', 41043, 'united states'
)


select * from customer;

insert into customer values
(3, 'pollard', '5360 lownden drive', 'johnsville', 41043, 'united states')


