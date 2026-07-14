-- =========================================================
-- STUDENT ID: 31517 | CAR RENTAL DATABASE SYSTEM
-- FILE: packages_and_logic.sql
-- DESCRIPTION: Phase VI - PL/SQL Packages for Booking & Cost Logic
-- =========================================================

-- 1. Package Specification
CREATE OR REPLACE PACKAGE CAR_RENTAL_PKG AS
    FUNCTION Calculate_Total_Cost(p_car_id IN NUMBER, p_start_date IN DATE, p_end_date IN DATE) RETURN NUMBER;
    
    PROCEDURE Create_New_Booking(
        p_customer_id IN NUMBER,
        p_car_id IN NUMBER,
        p_start_date IN DATE,
        p_end_date IN DATE
    );
END CAR_RENTAL_PKG;
/

-- 2. Package Body
CREATE OR REPLACE PACKAGE BODY CAR_RENTAL_PKG AS

    -- Function to calculate dynamic total cost based on daily rate and reservation days
    FUNCTION Calculate_Total_Cost(p_car_id IN NUMBER, p_start_date IN DATE, p_end_date IN DATE) RETURN NUMBER IS
        v_daily_rate NUMBER(8,2);
        v_days NUMBER;
    BEGIN
        SELECT daily_rate INTO v_daily_rate FROM Cars WHERE car_id = p_car_id;
        
        v_days := (p_end_date - p_start_date);
        IF v_days = 0 THEN v_days := 1; END IF;
        
        RETURN v_days * v_daily_rate;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END Calculate_Total_Cost;

    -- Procedure to perform booking transaction, verify availability, and update car status
    PROCEDURE Create_New_Booking(
        p_customer_id IN NUMBER,
        p_car_id IN NUMBER,
        p_start_date IN DATE,
        p_end_date IN DATE
    ) IS
        v_total_cost NUMBER(10,2);
        v_status VARCHAR2(20);
    BEGIN
        -- Verify if the car exists and check its availability status
        SELECT status INTO v_status FROM Cars WHERE car_id = p_car_id;
        
        IF v_status != 'Available' THEN
            RAISE_APPLICATION_ERROR(-20001, 'Selected car is not available for booking.');
        END IF;

        -- Calculate the dynamic pricing
        v_total_cost := Calculate_Total_Cost(p_car_id, p_start_date, p_end_date);

        -- Insert into Bookings table
        INSERT INTO Bookings (customer_id, car_id, start_date, end_date, total_amount)
        VALUES (p_customer_id, p_car_id, p_start_date, p_end_date, v_total_cost);

        -- Update Car status to Rented
        UPDATE Cars SET status = 'Rented' WHERE car_id = p_car_id;

        -- Commit the transaction
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; -- Undo all actions if any step fails
            RAISE_APPLICATION_ERROR(-20002, 'Error creating booking: ' || SQLERRM);
    END Create_New_Booking;

END CAR_RENTAL_PKG;
/