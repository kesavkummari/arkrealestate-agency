-- Create Schemas
CREATE SCHEMA sales;
CREATE SCHEMA hr;

-- Create Customers Table in Sales Schema
CREATE TABLE sales.customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Orders Table in Sales Schema
CREATE TABLE sales.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES sales.customers(customer_id),
    order_date DATE DEFAULT CURRENT_DATE,
    amount DECIMAL(10,2) NOT NULL
);

-- Create Departments Table in HR Schema
CREATE TABLE hr.departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE NOT NULL
);

-- Create Employees Table in HR Schema
CREATE TABLE hr.employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department_id INT REFERENCES hr.departments(department_id),
    salary DECIMAL(10,2) NOT NULL,
    hire_date DATE DEFAULT CURRENT_DATE
);

-- Insert Sample Data into Customers Table
INSERT INTO sales.customers (name, email, phone) VALUES
('Alice Johnson', 'alice@example.com', '123-456-7890'),
('Bob Smith', 'bob@example.com', '987-654-3210'),
('Charlie Brown', 'charlie@example.com', '456-789-0123');

-- Insert Sample Data into Orders Table
INSERT INTO sales.orders (customer_id, order_date, amount) VALUES
(1, '2025-02-01', 250.75),
(2, '2025-02-05', 500.50),
(3, '2025-02-10', 120.00);

-- Insert Sample Data into Departments Table
INSERT INTO hr.departments (department_name) VALUES
('Engineering'),
('Marketing'),
('Human Resources');

-- Insert Sample Data into Employees Table
INSERT INTO hr.employees (name, email, department_id, salary, hire_date) VALUES
('David Lee', 'david@example.com', 1, 75000.00, '2023-06-15'),
('Emma Watson', 'emma@example.com', 2, 68000.00, '2024-03-10'),
('Frank Adams', 'frank@example.com', 3, 55000.00, '2022-11-20');
