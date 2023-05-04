# Interview Challenge

**Context**

You are going to build a small project for a factoring lender.The lender uses invoices as collateral for loans.
When the borrower is paid, he pays the lender back. Fees will be charged for the loan.

What is factoring:
https://www.youtube.com/watch?v=IE6OVk7C4dM

The expected result is a rails API project. You should send the GitHub repository.

We will create a small project that will be able to handle the invoice lifecycle as well as how it accrues fees, considering the acceptance criteria. To simplify understanding, imagine all the operations being performed by a lender.

The participant entities in the system are borrower, fee, and invoice.
Borrowers: They are the lender's borrowers, who will submit your invoices to a lender to receive an advance against their invoices.
Invoices: Invoices belong to borrowers who wish to sell them to a lender.
Fees: These are the fees that will be charged over the borrower's invoices considering the rules will be described below.

**Invoice States**
![image](https://user-images.githubusercontent.com/18500/234919346-18d17f2c-c85a-4256-8c00-83d6433847e7.png)

- created: When an invoice is created.
- rejected: When a submitted invoice is rejected for some reason.
- approved: When an invoice is approved and it is available to be purchased.
- purchased: When an invoice is purchased by the lender.
- closed: When an invoice is closed, it is in the last state of its life cycle.


**Invoices:**
- Invoice # - alphanumeric (cannot be repeated in the system)
- Invoice amount
- Invoice due date
- Status
- Invoice scan - should be an image or pdf upload

**Borrowers:**
- Name

**Fees:**
- percentage: The percentage that will be charged over the invoice

**Acceptance Criteria**
- A way to handle invoice statuses
	- Only approved invoices can be purchased
	- Only purchased invoices can be closed
- A way to accrue fees over an invoice
	- The fee should be calculated over the invoice amount. e.g: invoice amount: 100, fee: 2%, fee to accrue: 2
	- The fees should start accruing only for purchased invoices, and they should be applied after 2 days from the invoice due date.
	- The fees should be stopped accruing only when purchased invoices become closed.
	- The accrual fee process should be able to accrue retroactive dates.
	  e.g., 
	  An invoice for $100 was purchased on May 14, 2023, and its due date is May 10, 2023. Considering our rule to accrue fees after 2 days from the invoice due date, we need to accrue two days, so the total accrued is $4.

 
 
**What will be evaluated:**
* Code organization
* Documentation → need to be able to run locally without asking
* Tests
* Version control organization (meaningful commits)