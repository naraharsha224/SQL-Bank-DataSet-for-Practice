USE bank;

/*
1. Write a query to display account number, customer’s number, customer’s firstname,
lastname, account opening date. Display the records sorted in ascending order based on
account number.
*/

SELECT am.account_number, 
       cm.customer_number,
	   cm.firstname,
	   cm.lastname, 
	   am.account_opening_date
FROM customer_master cm
JOIN account_master am ON am.customer_number=cm.customer_number
ORDER BY am.account_number ASC


/*
2. Write a query to display the number of customer’s from Delhi. Give the count an alias name of Cust_Count.
*/

SELECT COUNT(*) AS Cust_Count
FROM customer_master
WHERE CUSTOMER_CITY = 'DELHI'

/*
3. Write a query to display the customer number, customer firstname, account number for the
customer’s whose accounts were created after 15th of any month. Display the records sorted in
ascending order based on customer number and then by account number.
*/

SELECT cm.customer_number,
       cm.firstname,
	   am.account_number
FROM customer_master cm
JOIN account_master am ON am.customer_number=cm.customer_number
WHERE DAY(account_opening_date) > 15
ORDER BY cm.customer_number,am.account_number ASC

/*
4. Write a query to display customer number, customer's first name, account number where the
account status is terminated. Display the records sorted in ascending order based on customer number
and then by account number.
*/

SELECT cm.customer_number,
       cm.firstname,
	   am.account_number
FROM customer_master cm
JOIN account_master am ON am.customer_number=cm.customer_number
WHERE am.account_status='TERMINATED'
ORDER BY cm.customer_number,am.account_number ASC


/*
5. Write a query to display the total number of withdrawals and total number of deposits being done
by customer whose customer number ends with 001. The query should display transaction type and
the number of transactions. Give an alias name as Trans_Count for number of transactions. Display the
records sorted in ascending order based on transaction type.
*/

SELECT td.transaction_type, 
       COUNT(td.transaction_type) AS No_of_transactions
FROM account_master am
JOIN transaction_details td ON td.account_number=am.account_number
WHERE am.customer_number LIKE '%001'
GROUP BY td.transaction_type
ORDER BY td.transaction_type


/*
6. Write a query to display the number of customers who have registration but no account in the bank.
Give the alias name as Count_Customer for number of customers.
*/

SELECT COUNT(cm.customer_number) AS Count_Customer
FROM customer_master cm
WHERE CUSTOMER_NUMBER NOT IN (SELECT customer_number
                              FROM account_master)


/*
7. Write a query to display account number and total amount deposited by each account holder
(Including the opening balance). Give the total amount deposited an alias name of Deposit_Amount.
Display the records in sorted order based on account number.
*/

SELECT am.account_number,
       (am.opening_balance+SUM(td.transaction_amount)) AS Depost_Amount
FROM account_master am
JOIN transaction_details td ON td.account_number=am.account_number
WHERE td.transaction_type='Deposit'
GROUP BY am.account_number,am.opening_balance


/*
8. Write a query to display the number of accounts opened in each city .The Query should display
Branch City and number of accounts as No_of_Accounts.For the branch city where we don’t have any
accounts opened display 0. Display the records in sorted order based on branch city.
*/

SELECT b.branch_city,COUNT(a.account_number) AS no_of_accounts
FROM account_master a
RIGHT JOIN branch_master b ON b.branch_id=a.branch_id
GROUP BY b.branch_city
ORDER BY b.branch_city

/*
9. Write a query to display the firstname of the customers who have more than 1 account. Display the
records in sorted order based on firstname.
*/

SELECT cm.FIRSTNAME,COUNT(am.account_number) no_of_accounts
FROM customer_master cm
JOIN account_master am ON am.customer_number=cm.CUSTOMER_NUMBER
GROUP BY cm.customer_number, cm.FIRSTNAME
HAVING COUNT(am.account_number) > 1


/*
10. Write a query to display the customer number, customer firstname, customer lastname who has
taken loan from more than 1 branch. Display the records sorted in order based on customer number.
*/

SELECT l.CUSTOMER_NUMBER,cm.FIRSTNAME,cm.lastname
FROM customer_master cm
JOIN loan_details l ON l.customer_number=cm.CUSTOMER_NUMBER
GROUP By l.customer_number,cm.FIRSTNAME, cm.lastname
HAVING COUNT(l.customer_number) > 1
ORDER BY l.CUSTOMER_NUMBER


/*
11. Write a query to display the customer’s number, customer’s firstname, customer’s city and branch
city where the city of the customer and city of the branch is different. Display the records sorted in
ascending order based on customer number.
*/

SELECT c.CUSTOMER_NUMBER,c.FIRSTNAME, c.CUSTOMER_CITY, b.branch_city
FROM customer_master c
JOIN account_master a ON a.customer_number=c.CUSTOMER_NUMBER
JOIN branch_master b ON b.branch_id=a.branch_id
WHERE c.CUSTOMER_CITY != b.branch_city
ORDER BY c.CUSTOMER_NUMBER ASC

/*
12. Write a query to display the number of clients who have asked for loans but they don’t have any
account in the bank though they are registered customers. Give the count an alias name of Count.
*/

SELECT COUNT(customer_number) AS count
FROM loan_details
WHERE customer_number not in (SELECT DISTINCT customer_number FROM account_master)

/*
13. Write a query to display the account number who has done the highest transaction. For example
the account A00023 has done 5 transactions i.e. suppose 3 withdrawal and 2 deposits. Whereas the
account A00024 has done 3 transactions i.e. suppose 2 withdrawals and 1 deposit. So account number
of A00023 should be displayed. In case of multiple records, display the records sorted in ascending
order based on account number.
*/

SELECT TOP 1 account_number, 
       COUNT(transaction_type) AS no_of_transactions
FROM transaction_details
GROUP BY account_number

/*
14. Write a query to show the branch name,branch city where we have the maximum customers. For
example the branch B00019 has 3 customers, B00020 has 7 and B00021 has 10. So branch id B00021 is
having maximum customers. If B00021 is Koramangla branch Bangalore, Koramangla branch should be
displayed along with city name Bangalore. In case of multiple records, display the records sorted in
ascending order based on branch name.
*/

SELECT TOP 1 b.branch_name,b.branch_city, COUNT(a.customer_number) no_of_customers
FROM account_master a
JOIN branch_master b ON b.branch_id=a.branch_id
GROUP BY a.branch_id, b.branch_name, b.branch_city
ORDER BY no_of_customers DESC


/*
15. Write a query to display all those account number, deposit, withdrawal where withdrawal is more
than deposit amount. Hint: Deposit should include opening balance as well. For example A00011
account opened with Opening Balance 1000 and A00011 deposited 2000 rupees on 2012-12-01 and
3000 rupees on 2012-12-02. The same account i.e A00011 withdrawn 3000 rupees on 2013-01-01 and
7000 rupees on 2013-01-03. So the total deposited amount is 6000 and total withdrawal amount is
10000. So withdrawal amount is more than deposited amount for account number A00011. Display
the records sorted in ascending order based on account number.
*/

SELECT t.account_number,
       SUM(CASE WHEN t.transaction_type='Deposit' THEN transaction_amount END) + (SELECT opening_balance FROM account_master GROUP BY opening_balance) AS DepositAmount,
	   SUM(CASE WHEN t.transaction_type='Withdrawal' THEN transaction_amount END) AS withDrawalAmount
FROM transaction_details t
GROUP BY t.account_number
HAVING (SUM(CASE WHEN t.transaction_type='Withdrawal' THEN transaction_amount END)) > (SUM(CASE WHEN t.transaction_type='Deposit' THEN transaction_amount END) + (SELECT opening_balance FROM account_master GROUP BY opening_balance))
ORDER BY account_number

/*
16. Write a query to show the balance amount for account number that ends with 001. Note: Balance
amount includes account opening balance also. Give alias name as Balance_Amount. For example
A00015 is having an opening balance of 1000. A00015 has deposited 2000 on 2012-06-12 and
deposited 3000 on 2012-07-13. The same account has drawn money of 500 on 2012-08-12 , 500 on
2012-09-15, 1000 on 2012-12-17. So balance amount is 4000 i.e (1000 (opening balance)+2000+3000 )
– (500+500+1000).
*/

SELECT t.account_number,
       (SUM(CASE WHEN transaction_type='Deposit' THEN transaction_amount END) + (SELECT opening_balance FROM account_master GROUP BY opening_balance)) -
	   SUM(CASE WHEN transaction_type='withdrawal' THEN transaction_amount END) AS BalanceAmount
FROM transaction_details t
WHERE t.account_number LIKE '%001'
GROUP BY t.account_number

/*
17. Display the customer number, customer's first name, account number and number of transactions
being made by the customers from each account. Give the alias name for number of transactions as
Count_Trans. Display the records sorted in ascending order based on customer number and then by
account number.
*/

SELECT c.CUSTOMER_NUMBER,
       c.FIRSTNAME,
	   a.account_number,
	   COUNT(transaction_type) AS count_trans
FROM customer_master c
JOIN account_master a ON a.customer_number=c.CUSTOMER_NUMBER
JOIN transaction_details t ON t.account_number=a.account_number
GROUP BY c.CUSTOMER_NUMBER,c.FIRSTNAME, a.account_number
ORDER BY c.CUSTOMER_NUMBER, a.account_number


/*
18. Write a query to display the customer’s firstname who have multiple accounts (atleast 2
accounts). Display the records sorted in ascending order based on customer's firstname.
*/

SELECT c.FIRSTNAME,
       COUNT(a.account_number) AS no_of_accounts
FROM customer_master c
JOIN account_master a ON a.customer_number=c.CUSTOMER_NUMBER
GROUP BY c.FIRSTNAME
HAVING COUNT(a.account_number) > 1
ORDER BY c.FIRSTNAME

/*
19. Write a query to display the customer number, firstname, lastname for those client where total
loan amount taken is maximum and at least taken from 2 branches. For example the customer C00012
took a loan of 100000 from bank branch with id B00009 and C00012 Took a loan of 500000 from bank
branch with id B00010. So total loan amount for customer C00012 is 600000. C00013 took a loan of
100000 from bank branch B00009 and 200000 from bank branch B00011. So total loan taken is
300000. So loan taken by C00012 is more then C00013.
*/


SELECT TOP 1 c.CUSTOMER_NUMBER,
       c.FIRSTNAME,
	   c.lastname,
	   SUM(l.loan_amount) AS TotalLoan
FROM customer_master c
JOIN loan_details l ON l.customer_number=c.CUSTOMER_NUMBER
GROUP BY c.CUSTOMER_NUMBER, c.FIRSTNAME, c.lastname
ORDER BY TotalLoan DESC

--Or
SELECT TOP 1 c.CUSTOMER_NUMBER,
       c.FIRSTNAME,
	   c.lastname
FROM customer_master c
JOIN loan_details l ON l.customer_number=c.CUSTOMER_NUMBER
GROUP BY c.CUSTOMER_NUMBER, c.FIRSTNAME, c.lastname
HAVING COUNT(l.branch_id)>=2 AND SUM(l.loan_amount)>=ALL
(SELECT SUM(loan_amount) FROM loan_details GROUP BY customer_number)


/*
20. Write a query to display the customer’s number, customer’s firstname, branch id and loan amount
for people who have taken loans. Display the records sorted in ascending order based on customer
number and then by branch id and then by loan amount.
*/

SELECT l.customer_number,
       c.FIRSTNAME,
	   l.branch_id,
       SUM(l.loan_amount) AS Loan_taken
FROM loan_details l
JOIN customer_master c ON c.CUSTOMER_NUMBER=l.customer_number
GROUP BY l.customer_number, c.FIRSTNAME, l.branch_id
ORDER BY l.customer_number,l.branch_id,Loan_taken

/*
21. Write a query to display city name and count of branches in that city. Give the count of branches
an alias name of Count_Branch. Display the records sorted in ascending order based on city name.
*/

SELECT branch_city, COUNT(branch_id) AS Count_Branch
FROM branch_master
GROUP BY branch_city
ORDER BY branch_city

/*
22. Write a query to display account id, customer’s firstname, customer’s lastname for the customer’s
whose account is Active. Display the records sorted in ascending order based on account id /account
number.
*/

SELECT a.account_number,c.FIRSTNAME,c.lastname
FROM customer_master c
JOIN account_master a ON a.customer_number=c.CUSTOMER_NUMBER
WHERE a.account_status='ACTIVE'
ORDER BY a.account_number

/*
23. Write a query to display customer’s number, first name and middle name. For the customers who
don’t have middle name, display their last name as middle name. Give the alias name as
Middle_Name. Display the records sorted in ascending order based on customer number.
*/

SELECT customer_number,
       firstname,
	   isnull(middlename,lastname) AS Middle_name 
	   FROM
Customer_master ORDER BY customer_number;

/*
24. Write a query to display the customer number , firstname, customer’s date of birth . Display the
records sorted in ascending order of date of birth year and within that sort by firstname in ascending
order.
*/

SELECT c.CUSTOMER_NUMBER,
       c.FIRSTNAME,
	   c.CUSTOMER_DATE_OF_BIRTH
FROM customer_master c
ORDER BY YEAR(c.CUSTOMER_DATE_OF_BIRTH), c.FIRSTNAME

/*
25. Write a query to display the customers firstname, city and account number whose occupation are
not into Business, Service or Student. Display the records sorted in ascending order based on customer
first name and then by account number.
*/

SELECT c.FIRSTNAME,
       c.CUSTOMER_CITY,
	   a.account_number
FROM customer_master c
JOIN account_master a ON a.customer_number=c.CUSTOMER_NUMBER
WHERE c.occupation NOT IN ('SERVICE','BUSINESS','STUDENT')
ORDER BY c.FIRSTNAME,a.account_number

