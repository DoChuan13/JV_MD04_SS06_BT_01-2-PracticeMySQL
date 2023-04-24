create database if not exists TestManagement;

use TestManagement;

create table if not exists TestManagement.Student
(
    RN   int primary key auto_increment,
    Name varchar(20) not null,
    Age  int         not null
);

create table if not exists TestManagement.Test
(
    TestID int primary key auto_increment,
    Name   varchar(20) not null
);

create table if not exists TestManagement.StudentTest
(
    RN     int      not null,
    TestID int      not null,
    Date   datetime not null,
    Mark   float    not null,
    constraint fr_StudentTest_RN foreign key (RN) references Student (RN),
    constraint fr_StudentTest_TestID foreign key (TestID) references Test (TestID)
);

# 1. Insert Value
insert into TestManagement.Student (RN, Name, Age)
values (1, 'Nguyen Hong Ha', 20),
       (2, 'Truong Ngoc Anh', 30),
       (3, 'Tuan Minh', 25),
       (4, 'Dan Truong', 22);

insert into TestManagement.Test (TestID, Name)
values (1, 'EPC'),
       (2, 'DWMX'),
       (3, 'SQL1'),
       (4, 'SQL2');

insert into TestManagement.StudentTest (RN, TestID, Date, Mark)
values (1, 1, '2006/7/17', 8),
       (1, 2, '2006/7/18', 5),
       (1, 3, '2006/7/19', 7),
       (2, 1, '2006/7/17', 7),
       (2, 2, '2006/7/18', 4),
       (2, 3, '2006/7/19', 2),
       (3, 1, '2006/7/17', 10),
       (3, 3, '2006/7/18', 1);

# 2. Alter to Modify
alter table TestManagement.Student
    add constraint chk_Age check ( Age > 15 and Age < 50 );

alter table TestManagement.StudentTest
    alter column Mark set default (0);

alter table TestManagement.StudentTest
    add primary key (RN, TestID);

alter table TestManagement.Test
    add constraint Uni_Name unique (Name);

alter table TestManagement.Test
    drop constraint Uni_Name;

# 3. Show list student join Test
select S.Name                    as `Student Name`,
       T.Name                    as `Test Name`,
       format(ST.Mark, 1)        as Mark,
       cast(ST.Date as datetime) as `Date`
from Student as S
         join TestManagement.StudentTest ST on S.RN = ST.RN
         join TestManagement.Test T on ST.TestID = T.TestID;

# 4.
select Student.RN, Student.Name, Student.Age
from Student
         left join TestManagement.StudentTest ST on Student.RN = ST.RN
where ST.RN is null;

# 5.
select Student.Name,
       T.Name             as `Test Name`,
       format(ST.Mark, 1) as `Mark`,
       ST.Date            as `Date`
from Student
         join TestManagement.StudentTest ST on Student.RN = ST.RN
         join TestManagement.Test T on ST.TestID = T.TestID
where St.Mark < 5;;
# 6.
select Student.Name as `Student Name`, format(avg(ST.Mark), 2) as Average
from Student
         join TestManagement.StudentTest ST on Student.RN = ST.RN
group by Student.RN
order by avg(ST.Mark) desc;

# 7.
set @max = 0;
select Student.Name as `Student Name`, format(avg(ST.Mark), 2) as Average
from Student
         join TestManagement.StudentTest ST on Student.RN = ST.RN
group by Student.RN
order by avg(ST.Mark) desc
limit 1;

# 8.
select Test.Name as `Test Name`, max(StudentTest.Mark) as `Max Mark`
from Test
         join StudentTest on Test.TestID = StudentTest.TestID
group by Test.TestID;

# 9.
select Student.Name, T.Name
from Student
         left join TestManagement.StudentTest ST on Student.RN = ST.RN
         left join TestManagement.Test T on ST.TestID = T.TestID;

# 10.
update Student
set Age = Age + 1;

# 11
alter table Student
    add column Status varchar(10);

# 12
update Student
set Status = if(Age < 30, 'Young', 'Old');

select *
from Student;


# 13

select Student.Name as `Student Name`, T.Name as `Test Name`, format(ST.Mark, 1) as `Mark`, ST.Date
from Student
         join TestManagement.StudentTest ST on Student.RN = ST.RN
         join TestManagement.Test T on ST.TestID = T.TestID
order by ST.Date asc;

# 14
select Student.Name, Student.Age, avg(ST.Mark) as `Average`
from Student
         join TestManagement.StudentTest ST on Student.RN = ST.RN
where Student.Name like 'T%'
group by Student.RN
having Average > 4.5;

# 15
select Student.RN,
       Student.Name,
       Student.Age,
       avg(ST.Mark)                                   as `Average`,
       row_number() over (order by avg(ST.Mark) desc) as `Rating`
from Student
         join TestManagement.StudentTest ST on Student.RN = ST.RN
group by Student.RN;

# 16
alter table Student
    modify column Name varchar(255);

# 17
update Student
set Name = if(Age > 20, concat('Old ', Name), concat('Young ', Name));

# 18
delete  from test t1
  where not exists (select 1 from studenttest t2 where t1.TestID = t2.TestID);

# 19
delete
from StudentTest
where Mark<5;