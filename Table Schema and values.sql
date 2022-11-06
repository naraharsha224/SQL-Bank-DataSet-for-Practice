--create database bank;

use bank;

/*
CREATE TABLE customer_master(
CUSTOMER_NUMBER VARCHAR(255),
FIRSTNAME VARCHAR(30),
middlename VARCHAR(30),
lastname VARCHAR(30),
CUSTOMER_CITY VARCHAR(15),
CUSTOMER_CONTACT_NO VARCHAR(10),
occupation VARCHAR(10),
CUSTOMER_DATE_OF_BIRTH DATE,
CONSTRAINT customer_custid_pk PRIMARY KEY (CUSTOMER_NUMBER));

CREATE TABLE branch_master(
branch_id VARCHAR(255),
branch_name VARCHAR(30),
branch_city VARCHAR(30),
CONSTRAINT branch_bid_pk PRIMARY KEY (branch_id));


CREATE TABLE account_master
(account_number VARCHAR(255),
customer_number VARCHAR(255),
branch_id VARCHAR(255),
opening_balance INT,
account_opening_date DATE,
account_type VARCHAR(10),
account_status VARCHAR(10),
PRIMARY KEY (account_number),
FOREIGN KEY (customer_number) references customer_master(customer_number),
FOREIGN KEY (branch_id) references branch_master(branch_id));


CREATE TABLE transaction_details(
transaction_number VARCHAR(6),
account_number VARCHAR(255),
date_of_transaction DATE,
medium_of_transaction VARCHAR(20),
transaction_type VARCHAR(20),
transaction_amount INT,
CONSTRAINT transaction_details_tnumber_pk PRIMARY KEY (transaction_number),
CONSTRAINT transaction_details_acnumber_fk FOREIGN KEY (account_number)
REFERENCES account_master (account_number));


CREATE TABLE loan_details
(customer_number varchar(255),
branch_id varchar(255),
loan_amount bigint,
foreign key(customer_number) references customer_master(customer_number));
*/

/*
insert into customer_master values('C00001', 'RAMESH', 'CHANDRA', 'SHARMA', 'DELHI', '9543198345', 'SERVICE' ,'1976-12-06');
insert into customer_master values('C00002', 'AVINASH', 'SUNDER', 'MINHA', 'DELHI', '9876532109' ,'SERVICE', '1974-10-16');
insert into customer_master values('C00003', 'RAHUL', 'NULL', 'RASTOGI', 'DELHI', '9765178901', 'STUDENT', '1981-09-26');
insert into customer_master values('C00004', 'PARUL', 'NULL', 'GANDHI', 'DELHI', '9876532109' ,'HOUSEWIFE','1976-11-03');
insert into customer_master values('C00005', 'NAVEEN' ,'CHANDRA', 'AEDEKAR', 'MUMBAI', '8976523190', 'SERVICE' ,'1976-09-19');
insert into customer_master values('C00006', 'CHITRESH', 'NULL', 'BARWE', 'MUMBAI', '7651298321', 'STUDENT' ,'1992-11-06');
insert into customer_master values('C00007', 'AMIT' ,'KUMAR', 'BORKAR', 'MUMBAI', '9875189761', 'STUDENT', '1981-09-06');
insert into customer_master values('C00008', 'NISHA',NULL, 'DAMLE', 'MUMBAI', '7954198761', 'SERVICE', '1975-12-03');
insert into customer_master values('C00009', 'ABHISHEK', NULL, 'DUTTA', 'KOLKATA','9856198761', 'SERVICE' ,'1973-05-22');
insert into customer_master values('C00010','SHANKAR' ,NULL, 'NAIR', 'CHENNAI', '8765489076', 'SERVICE', '1976-07-12');
*/

/*
insert into branch_master values('B00001', 'ASAF ALI ROAD','DELHI');
insert into branch_master values('B00002','NEW DELHI MAIN BRANCH','DELHI');
insert into branch_master values('B00003' ,'DELHI CANTT', 'DELHI');
insert into branch_master values('B00004' ,'JASOLA', 'DELHI');
insert into branch_master values('B00005' ,'MAHIM' ,'MUMBAI');
insert into branch_master values('B00006' ,'VILE PARLE', 'MUMBAI');
insert into branch_master values('B00007', 'MANDVI' ,'MUMBAI');
insert into branch_master values('B00008' ,'JADAVPUR', 'KOLKATA');
insert into branch_master values('B00009' ,'KODAMBAKKAM', 'CHENNAI');
*/

/*
insert into account_master values('A00001' ,'C00001','B00001',1000 ,'2012-12-15','SAVING','ACTIVE');
insert into account_master values('A00002' ,'C00002','B00001',1000,'2012-06-12' ,'SAVING','ACTIVE');
insert into account_master values('A00003' ,'C00003', 'B00002', 1000 ,'2012-05-17','SAVING', 'ACTIVE');
insert into account_master values('A00004' ,'C00002', 'B00005', 1000 ,'2013-01-27','SAVING ','ACTIVE');
insert into account_master values('A00005' ,'C00006', 'B00006', 1000 ,'2012-12-17','SAVING','ACTIVE');
insert into account_master values('A00006' ,'C00007', 'B00007', 1000 ,'2010-08-12','SAVING ','SUSPENDED');
insert into account_master values('A00007' ,'C00007', 'B00001', 1000 ,'2012-10-02','SAVING ','ACTIVE');
insert into account_master values('A00008' ,'C00001','B00003', 1000 ,'2009-11-09','SAVING ','TERMINATED');
insert into account_master values('A00009' ,'C00003', 'B00007', 1000 ,'2008-11-30','SAVING', 'TERMINATED');
insert into account_master values('A00010' ,'C00004', 'B00002', 1000 ,'2013-03-01','SAVING', 'ACTIVE');
*/

/*
insert into transaction_details values('T00001', 'A00001', '2013-01-01', 'CHEQUE','DEPOSIT', 2000);
insert into transaction_details values('T00002' ,'A00001' ,'2013-02-01' ,'CASH','WITHDRAWAL', 1000);
insert into transaction_details values('T00003', 'A00002 ', '2013-01-01', 'CASH' ,'DEPOSIT',2000);
insert into transaction_details values('T00004', 'A00002', '2013-02-01' , 'CASH' ,'DEPOSIT',3000);
insert into transaction_details values('T00005', 'A00007', '2013-01-11', 'CASH' ,'DEPOSIT',7000);
insert into transaction_details values('T00006', 'A00007', '2013-01-13', 'CASH' ,'DEPOSIT',9000);
insert into transaction_details values('T00007', 'A00001', '2013-03-13', 'CASH' ,'DEPOSIT',4000);
insert into transaction_details values('T00008', 'A00001', '2013-03-14', 'CHEQUE','DEPOSIT' ,3000);
insert into transaction_details values('T00009', 'A00001', '2013-03-21', 'CASH' ,'WITHDRAWAL',9000);
insert into transaction_details values('T00010', 'A00001', '2013-03-22', 'CASH' ,'WITHDRAWAL',2000);
insert into transaction_details values('T00011', 'A00002', '2013-03-25', 'CASH' ,'WITHDRAWAL',7000);
insert into transaction_details values('T00012', 'A00007', '2013-03-26', 'CASH' ,'WITHDRAWAL',2000);
*/

/*
insert into Loan_details values('C00001', 'B00001', 100000);
insert into Loan_details values('C00002', 'B00002', 200000);
insert into Loan_details values('C00009', 'B00008', 400000);
insert into Loan_details values('C00010', 'B00009', 500000);
insert into Loan_details values('C00001', 'B00003', 600000);
insert into Loan_details values('C00002', 'B00001', 600000);
*/

