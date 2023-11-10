-- Tonight create two procedures that do the following:

-- 1. EXTRA CREDIT: Create a procedure that adds a late fee to any customer who returned their rental after 7 days.
-- Use the payment and rental tables. Create a stored function that you call inside your procedure. The function will calculate the late fee amount based on how many days late they returned their rental. (Hint* You can subtract  two dates from each other and use Intervals to compare those dates, linked below).

-- 2. Add a new column in the customer table for Platinum Member. This can be a boolean.
-- Platinum Members are any customers who have spent over $200. 
-- Create a procedure that updates the Platinum Member column to True for any customer who has spent over $200 and False for any customer who has spent less than $200.
-- Use the payment and customer table.

ALTER TABLE customer ----- will change information about the table in some way DDL
-- procedure that alters the data in a column using the udate_platimum_member function
ADD COLUMN platinum_member BOOLEAN default false; --- 

SELECT *
FROM customer;



CREATE PROCEDURE update_platimum_member()

AS $$
	BEGIN
		UPDATE customer
		SET Platinum_member = true
		WHERE customer_id IN (      
			SELECT customer_id
			FROM payment
			GROUP BY payment.customer_id
			HAVING SUM(payment.amount) > 200

);

		COMMIT; --Commit our update statement inside of our transaction
	END;
$$ LANGUAGE plpgsql  -- setting the query language for the procedure


CALL update_platimum_member() -- Calling a stored procedure
SELECT *
FROM customer
WHERE customer_id = 526 OR customer_id = 148; 




	