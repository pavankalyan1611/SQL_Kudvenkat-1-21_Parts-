								--PART 2 (create data base )---
create database pavan -- create database
select * from sys.databases --showing databases 
use pavan;  -- use database
use kudvenkat;
alter database pavan modify name= pavan_kalyan; -- modify database name
drop database pavan_kalyan;	-- deleting database (system databases cannot drop)

					--PART 3(creat table, primary, foreign constraint) --
use [kudvenkat]
create table tbl_gender (
id int not null primary key,
gender nvarchar(50) not null
);
insert into tbl_gender values(3,'unknown');
alter table tbl_person add constraint fk_tblperson foreign key (genderid)
references tbl_gender(id);  --add constraint to column to existing table clmn
select * from tbl_gender
select * from tbl_person		-- retrieving data from database

						-- PART 4 (default constraint)--
alter table tbl_person add	-- alterting an exsting clm to add default constraint
constraint df_tblperson_genderid default '3' for genderid; 

--alter table [tbl_person] add [clm name] 	-- alterting an new clm to add default constraint
--[data type] [null | not null] constraint [constraint_name] default '3'; 

alter table [table_name] drop constraint [constraint_name];  --drop constraint

					-- PART 5 (cascading referential integrity constraint)--
delete from tbl_gender where id = 3; 
insert into tbl_person(id,name,email,age) values (7,'pardhu','pa@.com',152);

					-- PART 6 (check constraint)--(grafically and queries)
alter table tbl_person add age int;            --(hilate table and perss alt + f1)
select * from tbl_gender;
select * from tbl_person;
alter table tbl_person add constraint [CK_tblperson_age] check (age >0 and age <150);
alter table tbl_person add extra int check (extra >0 and extra<150);
alter table tbl_person drop constraint CK__tbl_perso__extra__412EB0B6;

						-- PART 7 (identity ) -- 
create table tblperson2(id int identity not null primary key,
name nvarchar(50) not null);
select * from tblperson2;
insert into tblperson2 values('vandana');
delete from tblperson2 where id = 3;
insert into tblperson2 values(3,'vandana'); -- there is a error when a column list is used and IDENTITY_INSERT is ON.
set IDENTITY_INSERT tblperson2 on;
insert into tblperson2 values(3,'vandana'); -- it would give error bcz u have to give columns name also
insert into tblperson2(id,name) values(3,'vandana'); --executived successful
set IDENTITY_INSERT tblperson2 off;  -- after fill the gape again put IDENTITY_INSERT off
insert into tblperson2 values('karishma');
update tblperson2 set name = 'meghana' where id =5;  --updating existing rows 
truncate table tblperson2; /*deleting only data in the table, NOTE: if u use this truncate statement
to delete data in the table and insert again data into table id column automatically reset to (1,1) means zero */
insert into tblperson2 values('karishma');
delete from tblperson2; /* if u use this command then if u insert new data then id will not reset it will
 update the id which the previous num has*/
 insert into tblperson2 values('vija');
--alter table tblperson2 add /*constraint uk_person2*/ unique (name); -- compiler would generete name automatically
--alter table tblperson2 drop constraint UQ__tblperso__72E12F1B7F7CF4D7;

--NOTE : if u want to reset the identity 
dbcc checkident (tblperson2,reseed,0);-- id will stert from 1

					-- PART 8 (get last generated identity column )
--retreve the last indentity num use 
select SCOPE_IDENTITY()--mostly usedn
select @@IDENTITY
select IDENT_CURRENT(table_name);
create table test1(id int identity,
name nvarchar(50) not null);
create table test2(id int identity,
name nvarchar(50) not null);
create trigger trforinsert on test1 for insert
as
begin
	insert into test2 values ('yyy');
end;
select * from test1
select * from test2

					-- PART 9 (unique key) --
alter table tbl_person add constraint uq_tblperson_email unique (email); -- connot keep duplecate values on email
alter table tbl_person drop constraint uq_tblperson_email;
select * from tbl_person

--part 10 (SELECT statement) --
select * from tbl_person;
select distinct city from tbl_person
alter table tbl_person add city nvarchar(50) default 'vizag';
update tbl_person set age = 27 where id in (6)
select * from tbl_person where city ='india';
select * from tbl_person where city <>'india'; --!=
select * from tbl_person where age between 22 and 25 order by age desc,name asc;
select * from tbl_person where age in (21,22,27);
select * from tbl_person where city like 'i%';
select * from tbl_person where name like '[p-r]%'; -- first letter start with [p-r]
select * from tbl_person where name like '[^p-r]%';-- first letter not start with [p-r]
select * from tbl_person where (city ='india'or city= 'uk') and age >=22;
select top 3 * from tbl_person; 
select top 50 percent name,city from tbl_person; 
select top 1  * from tbl_person order by age desc; 

				-- PART 11(group by, difference b/w where and having)--
select * from tbl_person
insert into tbl_person values(7,'paaru','paa@r.com',2,23,'india',25000),
(8,'surya','su@.com',1,17,'india',15000),
(9,'stark','sta@.com',1,30,'usa',50000),
(10,'jahnavi','jah@f.com',2,22,'uk',20000);
alter table tbl_person add salary float;            --(hilate table and perss alt + f1)
update tbl_person set salary = 35000 where id=6;

select min(salary) from tbl_person;  --also use 'max', 'sum'
select sum(salary)as total_salary,city,genderid from tbl_person
group by city,genderid order by city;
select city,genderid,sum(salary) as total_salary,count(name) as [no of persons]
from tbl_person group  by city,genderid; 
select city,genderid,sum(salary) as total_salary,count(name) as [no of persons]
from tbl_person where genderid IN (1,2) group  by city,genderid;    --where clauss present before group by
select city,genderid,sum(salary) as total_salary,count(name) as [no of persons] 
from tbl_person group  by city,genderid HAVING genderid in (2,3);	--having clauss present after group by
select city,genderid,sum(salary) as total_salary,count(name) as [no of persons] 
from tbl_person group  by city,genderid HAVING sum(salary) > 50000;

		-- PART 12 (basic joins) --
create table emptbl (id int not null identity ,name nvarchar(100),gender nvarchar(50),
salary float,depatmentid int);
create table department_tbl (id int not null identity ,department_name nvarchar(50),
location nvarchar(50),depatment_head nvarchar(100));
drop table emptbl;
select * from emptbl;												-- formulae --
select * from department_tbl;									--	select    columns_list
--inner join (common data)										--  from      left_table_name
select name,gender,salary,department_name from emptbl			--  joinType  right_table_name
inner join department_tbl										--  on         join_condition
on emptbl.depatmentid = department_tbl.id;  -- returns 8 rows
--left join (inner + left table)
select name,gender,salary,department_name from emptbl
left join department_tbl 
on emptbl.depatmentid = department_tbl.id; 
-- right join(inner + right tbl)
select name,gender,salary,department_name from emptbl
right outer join department_tbl       -- outer is optional
on emptbl.depatmentid = department_tbl.id;
-- full outer join(left + right+inner)
select name,gender,salary,department_name from emptbl
full outer join department_tbl       -- outer is optional
on emptbl.depatmentid = department_tbl.id;
----cross join								  -- it produces cartesian 
select name,gender,salary,department_name from emptbl  -- products of 2 tables in the join
cross join department_tbl       -- cross join shouldnot have 'on' clauss

					-- PART 13 (advanced joins) --
--only left table data without common data
select      name,gender,salary,department_name 
from        emptbl
left join    department_tbl       -- outer is optional
on			emptbl.depatmentid = department_tbl.id
where		emptbl.depatmentid is null;
  -- only right table data without common data
  select      name,gender,salary,department_name 
from        emptbl
right join    department_tbl       -- outer is optional
on			emptbl.depatmentid = department_tbl.id
where		emptbl.depatmentid is null;
      -- only data  without common data from tables
select      name,gender,salary,department_name 
from        emptbl
full join    department_tbl       -- outer is optional
on			emptbl.depatmentid = department_tbl.id
where		emptbl.depatmentid is null
or			department_tbl.id  is null;

					---	PART 14  (SELF jOIN)
create table tblEmployee ( empID int unique,
name nvarchar(100), managerID int);
select * from tblemployee

select		E.name as employee, M.name as manager
from		tblEmployee E
left join	tblEmployee M
on			E.managerID = M.empID

select		E.name as employee, M.name as manager
from		tblEmployee E
inner join	tblEmployee M
on			E.managerID = M.empID

select		E.name as employee, M.name as manager
from		tblEmployee E
cross join	tblEmployee M

					-- PART 15 (replacing NULL  in joins(3 ways to replace) )

select isnull(null,'no manager') as manager
select coalesce(null,'no manager') as manager  -- more powerful
case when expression  then '' else '' end

1)	select		e.name as employee, isnull(m.name,'no manager') as manager
	from		tblEmployee E
	left join	tblEmployee M
	on			E.managerID = M.empID

2)	select		e.name as employee, coalesce(m.name,'no manager') as manager
	from		tblEmployee E
	left join	tblEmployee M
	on			E.managerID = M.empID

3)	select		e.name as employee, case when m.name is null  then 'no manager' else m.name end as manager
	from		tblEmployee E
	left join	tblEmployee M
	on			E.managerID = M.empID

			---------------PART 16 (COALESCE FUNCTION USES) --------------
CREATE TABLE coalesce_table1(
	[id] [int] IDENTITY(1,1) NOT NULL,		--	COALESCE FUNCTION used to  return the first 'NON NULL' VALUE
	[firstname] [nvarchar](100) ,
	middlename nvarchar(100),
	lastname [nvarchar](50)); 
	
select id,coalesce(firstname,middlename,lastname) as name from coalesce_table1;
DROP TABLE coalesce_table1;

					---------------PART 17(UNION AND UNION ALL)	---------------
CREATE TABLE TEST1(
	[id] [int] IDENTITY(1,1) NOT NULL,		
	[firstname] [nvarchar](100) ,
	EMAIL nvarchar(100));
CREATE TABLE TEST2(
	[id] [int] IDENTITY(1,1) NOT NULL,		
	[firstname] [nvarchar](100) ,
	EMAIL nvarchar(100));
	
select * from test1
union all /* OR unoin*/		--UNION combines rows from 2 or more tables hwere JOIN combiles columns from 2 or more tables
select * from test2
DROP TABLE test1;
DROP TABLE test2;


					---------------PART 18 (STORED PROCEDURES input parameters)	---------------
SELECT * FROM EMPTBL;
/*So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it.
You can also pass parameters to a stored procedure, so that the stored procedure can act based on the parameter value(s) that is passed.*/

SELECT name,gender from emptbl;    --create stored procedure to this command

create procedure /*proc*/ spGetEmp
as 
begin
	SELECT name,gender from emptbl;
end
execute /*exec*/ spGetEmpNameGender  --or  spGetEmpNameGender 

create proc spGetEmpNameGender
@gender nvarchar(100),							-- input parameters
@departmentid int 
as 
begin
	SELECT name,gender,depatmentid from emptbl where gender = @gender and depatmentid = @departmentid;
end

spGetEmpNameGender 'male',2; -- or spGetEmpNameGender  @departmentid = 2,@gender = 'male';
sp_helptext spGetEmpNameGender  -- it gives text for commmand

alter procedure /*proc*/ spGetEmp
as									/*if u want change to change implementation of existing procedure use "ALTER" command */
begin
	SELECT name,gender from emptbl order by gender;
end
drop proc spGetEmp;  -- delete procedure

alter proc spGetEmpNameGender
@gender nvarchar(100),			-- if some one try to want text for encryption proc 
@departmentid int				-- it will give some msg;
with encryption
as 
begin
	SELECT name,gender,depatmentid from emptbl where gender = @gender and depatmentid = @departmentid;
end

					---------------PART 19 (STORED PROCEDURES output parameters)	---------------
create proc spGetEmpCountbyGender
@gender nvarchar(100),							-- input parameters
@empCount int output
as 
begin
	SELECT  @empCount = count(id) from emptbl where gender = @gender;
end

declare @totalCount int
execute spGetEmpCountbyGender 'male',@totalCount out	-- these 3 lines are execution part
print @totalCount;
sp_help spGetEmpCountbyGender; -- it eill give parameter name,their data types etc..
sp_helptext spGetEmpCountbyGender;  --view the text of the stored procedure
sp_depends emptbl; 

					---------------  PART 20 (STORED PROCEDURES return parameters)	---------------
create proc spGettotalcount
as 
begin
	return (SELECT count(id) from emptbl);
end;
	-- execute
declare @totalEmp int
exec @totalEmp  = spGettotalcount 
print @totalemp ;

	/*		RETURN	value								OUTPUT parameters
		only integer datatype						any data type
		only one value								more than one value
	use to convay success or failure				use to return values like name, count etc..  */

							---------------  PART 21 (advantages of stored procedures)	---------------

	1) execution plan tension and reusability, 2) produces network traffic 3) code reusability and better maintainability
	4)better security    5) avoid SQL injection attack