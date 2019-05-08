create database Library_Project;

use Library_Project;

create table Members (
	Library_Card_#		Int		not null	identity(1,1),
	First_Name		Char(30)	not null,
	Last_Name		Char(30)	not null,
	Address			Char(50)	null,
	Phone			Int		null,
	Email			Char(30)	null,
	constraint		MembersPK	primary key(Library_Card_#)
	);

create table Catalog (
	ISBN			Int		not null	identity(1,1),
	Title			Char(50)	not null,
	Author			Char(30)	not null,
	Genre			Char(50)	not null,
	Edition			Int		null,
	#_of_copies		Int		not null,
	constraint		CatalogPK	primary key(ISBN)
	);

create table Copies (
	Inventory_#		Int		not null	identity(1,1),
	ISBN			Int		not null,
	Year_Printed		Int		null,
	Condition		Char(25)	null,
	constraint		CopiesPK	primary key(Inventory_#),
	constraint		CopiesFK	foreign key(ISBN)
				references	Catalog(ISBN)
						on update cascade
						on delete cascade
	);

create table Loan (
	Transaction_ID		Int		not null	identity(1,1),
	Library_Card_#		Int		not null,
	Inventory_#		Int		not null,
	Date_Borrowed		date		not null,
	Due_Date		date		not null,
	Date_Returned		date		not null,
	constraint		LoanPK		primary key(Transaction_ID),
	constraint		LoanFK1		foreign key(Library_Card_#)
				references	Members(Library_Card_#),
	constraint		LoanFK2		foreign key(Inventory_#)
				references	Copies(Inventory_#),
	);

create table Loan_Copy_Int (
	Transaction_ID		Int		not null,
	Inventory_#		Int		not null,
	constraint		IntPK		primary key(Transaction_ID, Inventory_#),
	constraint		IntFK1		foreign key(Transaction_ID)
				references	Loan(Transaction_ID)
						on update cascade
						on delete cascade,
	constraint		IntFK2		foreign key(Inventory_#)
				references	Copies(Inventory_#)
	);

insert into Members values ('Sarah', 'Cox', '120 Pecan Pl', '9794019', 'scox20@atu.edu');
insert into Members values ('Mickey', 'Smith', '506 Rose Lane', '6478889', 'rose3@gmail.com');
insert into Members values ('Rory', 'Williams', '78 Nurse Ln', '2047563', 'mrpond@gmail.com');
insert into Members values ('Amy', 'Pond', '74 Scotts Dr', '7896523', 'mrsrory@hotmail.com');
insert into Members values ('Rose', 'Tyler', '12 London Ave', '7458632', 'badwolf@yahoo.com');
insert into Members values ('Clara', 'Oswald', '56 Victorian Ln', '7854122', 'impossiblegrl@gmail.com');
insert into Members values ('River', 'Song', '789 Pandorica Pl', '7894123', 'spoilers@gmail.com');
insert into Members values ('Jack', 'Harkness', '14 Captian Cr', '7894561', 'jharkness@torchwood.net');
insert into Members values ('Martha', 'Jones', '47 Cardiff Dr', '7896322', 'mjones1@atu.edu');
insert into Members values ('Donna', 'Noble', '78 Bride Dr', '7864124', 'drdonna@yahoo.com');

insert into catalog values ('The Lord of the Rings', 'Tolkien', 'Fantasy', '1', '1');
insert into catalog values ('Harry Potter and the Philosophers Stone', 'J.K. Rowling', 'Fantasy', '3', '1');
insert into catalog values ('The Hobbit', 'Tolkien', 'Fantasy', '4', '1');
insert into catalog values ('And Then There Were None', 'Agatha Christie', 'Mystery', '1', '1');
insert into catalog values ('The Da Vinci Code', 'Dan Brown', 'Thriller', '3', '1');
insert into catalog values ('The Catcher in the Rye', 'J.D. Salinger', 'Classic', '7', '1');
insert into catalog values ('Charlottes Web', 'E.B. White', 'Childrens', '4', '1');
insert into catalog values ('To Kill a Mockingbird', 'Harper Lee', 'Classic', '4', '1');
insert into catalog values ('The Hunger Games', 'Suzanne Collins', 'Dystopian', '1', '1');
insert into catalog values ('The Fault in Our Stars', 'John Green', 'Fiction', '4', '1');

insert into Copies values (1, 1954, 'Good');
insert into Copies values (2, 1997, 'Poor');
insert into Copies values (3, 1937, 'Excellent');
insert into Copies values (4, 1939, 'Good');
insert into Copies values (5, 2003, 'Poor');
insert into Copies values (6, 1951, 'Fair');
insert into Copies values (7, 1952, 'Great');
insert into Copies values (8, 1960, 'Fair');
insert into Copies values (9, 2008, 'Excellent');
insert into Copies values (10, 2012, 'Good');
insert into Copies values (7, 1952, 'Fair');
insert into Copies values (1, 1954, 'Poor');
insert into Copies values (7, 1952, 'Good');
insert into Copies values (8, 1960, 'Great');
insert into Copies values (10, 2012, 'Great');

insert into loan values (10, 3, 'January 1, 2018', 'January 14, 2018', 'January 14, 2018');
insert into loan values (9, 6, 'February 7, 2018', 'February 21, 2018', 'February 22, 2018');
insert into loan values (8, 9, 'March 10, 2018', 'March 24, 2018', 'March 24, 2018');
insert into loan values (7, 2, 'April 14, 2018', 'April 28, 2018', 'April 29, 2018');
insert into loan values (6, 4, 'June 20, 2018', 'July 4, 2018', 'July 4, 2018');
insert into loan values (5, 8, 'July 25, 2018', 'August 2, 2018', 'July 31, 2018');
insert into loan values (4, 10, 'August 3, 2018', 'August 17, 2018', 'August 17, 2018');
insert into loan values (3, 1, 'September 11, 2018', 'September 25, 2018', 'September 14, 2018');
insert into loan values (2, 5, 'October 13, 2018', 'October 27, 2018', 'October 27, 2018');
insert into loan values (1, 7, 'May 2, 2018', 'May 16, 2018', 'May 18, 2018');

insert into Loan_Copy_Int (Transaction_ID, Inventory_#)
select Transaction_ID, Inventory_#
from Loan;

--Aggregate Function to see how many books the library owns
select COUNT(*)
from copies;

--Aggregate Function to see how many copies of a specific book
select COUNT(*)
from copies
where ISBN = 7;

--Join to see customers names and the transactions they have made
select members.First_Name, members.Last_Name, loan.Transaction_ID
from members
join loan on members.Library_Card_# = loan.Library_Card_#;

--Join to see customers names and the books they have loaned out
select m.First_Name, m.Last_Name, ca.title
from members m, loan l, copies co, catalog ca
where m.Library_Card_# = l.Library_Card_#
and l.Inventory_# = co.Inventory_#
and co.ISBN = ca.ISBN;

--Nested query to see all the cusomters with late books
select First_Name, Last_Name
from members
where Library_Card_# in
	(select Library_Card_#
	from Loan
	where Date_Returned > Due_Date);

--Nested query to see all of the books in fair or poor condition
select title, author
from catalog
where ISBN in
	(select ISBN
	from copies
	where condition in ('Fair', 'Poor'));

--Uses a derived table to bring back the name and transaction id for a loan with a certian book
select m.First_Name, m.Last_Name, l.Transaction_ID
from members m,
	(select Transaction_ID, Library_Card_#
	from loan
	where Inventory_# in (1)) l
where m.Library_Card_# = l.Library_Card_#;

--Uses a derived table to bring back all members who returned a book in fair or poor condition
select m.First_Name, m.Last_Name, ca.Title, l.Transaction_ID, co.Inventory_#
from members m, catalog ca, loan l,
	(select ISBN, Inventory_#
	from Copies
	where condition in ('Fair', 'Poor')) co
where m.Library_Card_# = l.Library_Card_#
and l.Inventory_# = co.Inventory_#
and ca.ISBN = co.ISBN;
