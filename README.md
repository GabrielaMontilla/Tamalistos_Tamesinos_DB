# Tamalitos Don Juanito - Database Management System

## Description

Tamalitos Don Juanito is a relational database project designed to manage the operations of a traditional food business. The system handles customer information, employees, suppliers, inventory, products, sales, payroll, recipes, and purchases.

This project is implemented using MySQL and includes tables, relationships, stored procedures, triggers, and sample data to simulate a real business environment.

It is intended for academic and learning purposes, focusing on database design, data integrity, and advanced SQL features.

---

## Technologies Used

- MySQL
- SQL
- Stored Procedures
- Triggers
- Transactions

---

## Database Structure

The database contains the following main tables:

- Cliente (Customers)
- Empleado (Employees)
- Proveedor (Suppliers)
- Insumo (Supplies)
- Producto (Products)
- Factura (Invoices)
- Nomina (Payroll)
- Receta (Recipes)
- Compra (Purchases)
- inventario_Insumo (Supply Inventory)

Each table is connected using primary and foreign keys to ensure data consistency and relational integrity.

---

## Main Features

### 1. Data Management

- Create, update, search, and delete records for customers, employees, suppliers, products, and supplies.
- Manage inventory and purchase history.
- Register sales and generate invoices.
- Store payroll information.

### 2. Stored Procedures

The project includes multiple stored procedures for automation and validation, such as:

- `GestionarProveedor`: Manage suppliers (insert, update, search, delete).
- `GestionarReceta`: Manage recipes.
- `RegistrarCompraActualizarInventario`: Register purchases and update inventory.
- `checkcliente`: Check if a customer exists.
- `totalfacturacion`: Calculate total revenue.
- `SalarioNetoPromedioPorCargo`: Calculate average net salary by job position.
- `EmpleadosConSalarioSuperior`: Get employees with salaries above a given value.

### 3. Triggers

Automatic actions are implemented using triggers:

- `calcular_salario_neto`: Calculates net salary before inserting payroll data.
- `calcular_salario_neto_update`: Updates net salary before modifying payroll records.
- `validar_descuentos`: Prevents discounts greater than gross salary.
- `actualizar_estado_insumo`: Updates supply status based on expiration date.

### 4. Transactions

The system uses transactions to ensure data integrity when performing critical operations, such as registering payroll and purchases.

---

## Installation and Setup

### 1. Requirements

- MySQL Server 8.0 or higher
- MySQL Workbench or any SQL client
