

/*-- task 1 insert data into bookings table
INSERT INTO bookings (BookingID, BookingDate, TableNumber, StaffID, CustomerID)
VALUES (1, '2022-10-10', 5, 2, 1), (2, '2022-11-12', 3, 1, 3), (3, '2022-10-11', 2, 1, 2), (4, '2022-10-13', 2, 1, 1);
*/

/*-- task 2 create stored procedure that checks whether or not a table has a reservation
DELIMITER //

CREATE PROCEDURE CheckBooking(
    IN bookingDate DATE,
    IN tableNumber INT
)
BEGIN
    -- Declare a variable to hold the booking status of the table
    DECLARE bookingStatus VARCHAR(10);

    -- Check if the table is already booked on the given date
    IF EXISTS (
        SELECT * 
        FROM bookings 
        WHERE BookingDate = bookingDate AND TableNumber = tableNumber
    ) THEN
        -- If the table is already booked, set the booking status to 'Booked'
        SET bookingStatus = 'Booked';
    ELSE
        -- If the table is not booked, set the booking status to 'Available'
        SET bookingStatus = 'Available';
    END IF;

    -- Return the booking status of the table
    SELECT CONCAT('Table ', tableNumber, ' is ', bookingStatus) AS BookingStatus;
END //

DELIMITER ;
CALL CheckBooking('2022-10-10', 5);
*/

/*---task 3 create AddValidBooking procedure using a transaction statement to perform a rollback 
-- if a customer reserves a table that’s already booked under another name

DROP PROCEDURE IF EXISTS AddValidBooking;

DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN bookingDate DATE,
    IN tableNumber INT
)
BEGIN
    -- Declare a variable to hold the booking status of the table
    DECLARE bookingStatus VARCHAR(10);

    START TRANSACTION;
    
    -- Insert booking into the bookings table
    INSERT INTO bookings (BookingID, BookingDate, TableNumber, StaffID, CustomerID)
    VALUES (5, bookingDate, tableNumber, 2, 3);
    
    -- Check if the table is already booked on the given date
    IF EXISTS (
        SELECT * 
        FROM bookings 
        WHERE BookingDate = bookingDate AND TableNumber = tableNumber
    ) THEN
        -- If the table is already booked, set the booking status to 'Booked'
        SET bookingStatus = 'Booked';
        ROLLBACK;
        SELECT CONCAT('Table ', tableNumber, ' is ', bookingStatus, ' - Booking cancelled') AS BookingStatus;
    ELSE
        -- If the table is not booked, set the booking status to 'Available'
        SET bookingStatus = 'Available';
        COMMIT;
        SELECT CONCAT('Table ', tableNumber, ' is ', bookingStatus, ' - Booking successful') AS BookingStatus;
    END IF;
END //

DELIMITER ;

 

Call AddValidBooking('2022-10-20', 6)
--------------------------------------------------------------------------------------------------------------
*/

/*-- Task 1 create AddBooking stored procedure that adds a new table booking record


DROP PROCEDURE IF EXISTS AddBooking;

DELIMITER //

CREATE PROCEDURE AddBooking(
    
    IN bookingid INT,
    IN bookingdate DATE,
    IN tablenumber INT,
    IN staffid INT,
    IN customerid INT
    )
BEGIN
	INSERT INTO bookings (BookingID, BookingDate, TableNumber, StaffID, CustomerID)
	VALUES (bookingid, bookingdate, tablenumber, staffid, customerid);
    
    -- Display messsage that booking has been recorded
    SELECT 'New booking added' AS Confirmation;

END //

DELIMITER ;

CALL AddBooking(12, '2030-04-12', 3, 1, 2);
*/

/*-- Task 2 create UpdateBooking stored procedure that updates an existing booking record


DROP PROCEDURE IF EXISTS UpdateBooking;

DELIMITER //

CREATE PROCEDURE UpdateBooking(IN p_bookingID INT, IN p_bookingDate DATE)
BEGIN
    UPDATE bookings
    SET BookingDate = p_bookingDate
    WHERE BookingID = p_bookingID;
    
    SELECT CONCAT('Booking ', p_bookingID, ' update') AS Confirmation;
END //

DELIMITER ;


CALL UpdateBooking(2, '2023-04-13');



*/

/*-- Task 3 create CancelBooking stored procedure that deletes a record from bookings

DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER $$
CREATE PROCEDURE CancelBooking (IN booking_id INT)
BEGIN
    DELETE FROM bookings WHERE BookingID = booking_id;
    SELECT CONCAT('Booking ', booking_id, ' cancelled');
END$$
DELIMITER ;

CALL CancelBooking(3);

*/

/* -- Populate some data in tables for testing
INSERT INTO customers (CustomerID, CustomerName, PhoneNumber)
VALUES (1, 'Vanessa Hernandez', 8326248997), (2, 'Katie Watkins', 7546248997), (3, 'Martha Salazar', 2147296740);



/*
INSERT INTO staff (StaffID, StaffName, Role, Salary)
VALUES (1, 'Hilary Duff', 'waitress', 50000), (2, 'Jeff McDonal', 'waiter', 51000), (3, 'Brad Cortazzo', 'cheff', 55000);
*/

