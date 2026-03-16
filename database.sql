-- Database Creation
CREATE DATABASE IF NOT EXISTS driving_schoolDB;
USE driving_schoolDB;

-- Admin Table
CREATE TABLE IF NOT EXISTS admins (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Instructor Table
CREATE TABLE IF NOT EXISTS instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    vehicle_type ENUM('Car', 'Bike', 'Both') NOT NULL DEFAULT 'Car'
);

-- Vehicle Table
CREATE TABLE IF NOT EXISTS vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(100) NOT NULL,
    plate_number VARCHAR(20) NOT NULL UNIQUE,
    vehicle_type ENUM('Car', 'Bike') NOT NULL DEFAULT 'Car',
    status ENUM('Available', 'In Lesson', 'Maintenance') NOT NULL DEFAULT 'Available'
);

-- Student Table
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    nic VARCHAR(20) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL,
    address TEXT NOT NULL,
    license_type ENUM('Car', 'Bike', 'Both') NOT NULL DEFAULT 'Car',
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Lesson Table
CREATE TABLE IF NOT EXISTS lessons (
    lesson_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    instructor_id INT,
    vehicle_id INT,
    lesson_date DATE NOT NULL,
    lesson_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) ON DELETE SET NULL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE SET NULL
);

-- Payment Table
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

-- Test Table
CREATE TABLE IF NOT EXISTS tests (
    test_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    test_date DATE NOT NULL,
    result ENUM('Pending', 'Pass', 'Fail') DEFAULT 'Pending',
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

-- Sample Data Inserts
INSERT INTO admins (username, password) VALUES ('admin', 'admin123');

INSERT INTO instructors (name, phone_number, vehicle_type) VALUES 
('John Doe', '1234567890', 'Car'),
('Alice Smith', '0987654321', 'Bike');

INSERT INTO vehicles (model, plate_number, vehicle_type, status) VALUES 
('Toyota Corolla', 'CBA-1234', 'Car', 'Available'),
('Honda Civic', 'XYZ-9876', 'Car', 'Available'),
('Yamaha FZ', 'BIK-5678', 'Bike', 'Available');

INSERT INTO students (name, nic, phone_number, address, license_type, username, password) VALUES 
('Mike Johnson', '987654321V', '1112223333', '123 Main St', 'Car', 'mike', 'mike123'),
('Sarah Connor', '123456789V', '4445556666', '456 Oak Ave', 'Both', 'sarah', 'sarah123');
