-- =========================================================
-- STUDENT ID: 31517 | CAR RENTAL DATABASE SYSTEM
-- FILE: create_tables.sql
-- DESCRIPTION: Phase V - Table definitions and constraints
-- =========================================================

-- 1. Create Cars Table
CREATE TABLE Cars (
    car_id NUMBER PRIMARY KEY,
    model VARCHAR2(100) NOT NULL,
    daily_rate NUMBER(8,2) NOT NULL,
    status VARCHAR2(20) DEFAULT 'Available' CONSTRAINT chk_car_status CHECK (status IN ('Available', 'Rented'))
);
/

-- 2. Create Customers Table
CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(100) NOT NULL
);
/

-- 3. Create Bookings Table
CREATE TABLE Bookings (
    booking_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id NUMBER REFERENCES Customers(customer_id),
    car_id NUMBER REFERENCES Cars(car_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_amount NUMBER(10,2),
    CONSTRAINT chk_booking_dates CHECK (end_date >= start_date)
);
/