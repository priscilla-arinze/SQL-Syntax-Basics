create database sqlbasics; #create database

use sqlbasics; #selects database to work in

create table emp(
	id int not null auto_increment,
    ename varchar(20),
    address varchar(30),
    primary key(id)
);

drop table emp; #deletes table

create table Student(
	studentID int not null auto_increment,
	Fname varchar(20),
    LName varchar(20),
    Address varchar(30),
    City varchar(15),
    Grade int,
    primary key(studentID)
);

# Adding data to table
insert into Student
values
	(1, 'Priscilla', 'Arinze', '123 Main St', 'Dallas', 90),
    (2, 'Angelica', 'Arinze', '234 1st St', 'Austin', 88);
    
    
select * from Student; #shows all values for all columns
select FName, LName from Student; #shows values only for FName & LName columns

select FName from Student where City='Austin'; # Shows first name of all those who lives in Austin

insert into Student
values
	(3, 'Bob', 'Smith', '890 Towne Ln', 'Atlanta', 76),
    (4, 'Samantha', 'Price', '567 17th St', 'Boulder', 69);
    
select * from Student where FName='Bob' and City='Atlanta'; #using AND operator

select * from Student where City='Austin' or City='Atlanta'; #using OR operator

select * from Student where not City='Boulder'; #using NOT operator; shows all values except the one specified in the query

# Aggregate functions
select count(studentID) from Student; # counts number of records

select avg(Grade) from Student; # average of values in a specified column; e.g. Grade average

select sum(Grade) from Student; # total sum of specified column

select min(Grade) from Student; # minimum value in a specified column

select FName, LName, max(Grade) from Student; # shows firt & last name of row w/ maximum value in a specified column


insert into Student
values
	(5, 'George', 'Lane', '777 Main St', 'Dallas', 95),
    (6, 'Jordan', 'Tanner', '3 Hill Circle', 'Houston', 77);

#Used to arrange identical data into groups; like Excel
select count(studentID), FName from Student group by FName; #shows number of values/rows with a particular first name
select count(studentID), City from Student group by City; #shows number of values/rows with a particular city


#Having operator
select FName, sum(Grade) from Student group by FName having sum(Grade)>80; # filters & shows a sub-group of values that meet condition Grade > 80

#Order By operator: Sorting by ascending or descending order
select count(studentID), city from student group by city order by city desc; # shows cities in descending ['desc'] order (Z-A)

select * from Student;

insert into Student(studentID, FName, LName, Address, City)
values
	(7, 'Chris', 'Rock', '1010 Rock Ave', 'Houston');
   
#Checking for empty values
select FName, LName from Student where Grade is null; # shows student(s) where the grade field is blank/null
select FName, LName from Student where Grade is not null; # shows student(s) where the grade field is NOT blank/null

#Update operator: used to change data fields
update Student set FName='Robert' where studentID='7'; #Changed "Chris Rock" to "Robert Rock"

select * from Student;

# Delete operator: used to to delete entire rows
delete from Student where FName='Samantha' and studentID='4'; #need to add studentID (primary key) condition due to safe update mode

select * from Student;

# In operator: short-form for multiple OR statements/conditions
select studentID, FName, LName from Student where City in('Houston', 'Dallas', 'Atlanta');

# Between operator: selects particular value within specified range
select studentID, FName, LName, Grade from Student where Grade between 85 and 95;

# Alliases in SQL: secondary table or column names (meant for complex queries) & to shorten long names temporarily
select studentID as ID from Student; # change column name
select S.FName, S.LName from Student as S; #change table name


