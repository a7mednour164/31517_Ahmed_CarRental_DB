# 🚗 Car Rental Database Management System (Oracle APEX & PL/SQL)

This repository contains the complete implementation, database scripts, and documentation for the **Car Rental Management System** developed using **Oracle APEX** and **PL/SQL PL/SQL**.

---

## 📂 Project Structure

The project is organized into the following directories:

*   **`Database_Scripts/`**: Contains all SQL and PL/SQL logical scripts.
    *   `create_tables.sql`: Database schema definition (Tables, Primary Keys, Foreign Keys, and Constraints).
    *   `packages_and_logic.sql`: The complete `CAR_RENTAL_PKG` package containing business logic for price calculation and car status updates.
*   **`Documentation_and_Presentation/`**: Contains visual proofs, presentation, and design diagrams.
    *   `Presentation.pptx`: The project's presentation slides for final defense.
    *   `ER_Diagram`: Entity-Relationship Diagram detailing the $1:N$ relationships.
    *   `Screenshots`: Complete application demonstration flow (Login, Form entry, Database success confirmation, and Data verification).

---

## 🛠️ Database Schema & Logical Design

The database consists of three main normalized tables (3NF):
1.  **CUSTOMERS**: Stores customer personal profiles.
2.  **CARS**: Stores car inventory details, rental rates, and current availability status.
3.  **BOOKINGS**: Handles transactional booking details, linking customers with their selected cars.

---

## ⚙️ Key System Features (Business Logic)

The core operations are automated using a **PL/SQL Package** (`CAR_RENTAL_PKG`):
*   **Automatic Rental Cost Calculation:** Calculates the total amount dynamically based on the booking duration and the car's daily rate.
*   **Real-time Car Status Update:** Once a booking is successfully submitted, the car's status automatically toggles from `Available` to `Rented`.

---

## 🚀 Application Screenshots Flow
Inside the documentation folder, you can find the detailed step-by-step screenshots illustrating:
1.  User authentication flow (**Login Page**).
2.  Data input operations (**Booking Creation Form**).
3.  Database persistence validation (**Row Created Confirmation**).
4.  Data integrity check in Oracle APEX Object Browser (**Bookings & Cars Tables State**).# 31517_Ahmed_CarRental_DB
