CREATE DATABASE TamalitosDonJuanito;
USE TamalitosDonJuanito;

-- Tabla Cliente
Create Table Cliente (
    ID_Cliente Int Auto_Increment,
    CONSTRAINT ID_ClientePK PRIMARY KEY (ID_Cliente) ,
    Cc_Cliente int not null,
    constraint UQ_Cc_Cliente unique (Cc_Cliente),
    nombre_Cliente VARCHAR(100) NOT NULL,
    telefono_Cliente VARCHAR(15) NOT NULL default 'No tiene',
    direccion_Delivery VARCHAR(255) NOT NULL   
) auto_increment = 1001;

-- Tabla Empleado
CREATE TABLE Empleado (
    ID_Empleado INT AUTO_INCREMENT,
    CONSTRAINT ID_EmpleadoPK PRIMARY KEY (ID_Empleado),
    Cc_Empleado int not null, 
    constraint UQ_Cc_Empleado unique (Cc_Empleado),
    nombre_Empleado VARCHAR(100) NOT NULL,
    direccion_Empleado VARCHAR(255) NOT NULL,
    telefono_Empleado VARCHAR(15) NOT NULL,
    cargo_Empleado VARCHAR(50) NOT NULL
)auto_increment = 2001;

-- Tabla Insumo
CREATE TABLE Insumo (
    COD_Insumo INT AUTO_INCREMENT,
	CONSTRAINT COD_InsumoPK PRIMARY KEY (COD_Insumo),
    nombre_Insumo VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    cantidad_Insumo INT NOT NULL,
    fecha_Vencimiento_Insumo DATE NOT NULL
)auto_increment = 5001;

-- Tabla Proveedor
CREATE TABLE Proveedor (
    ID_Proveedor INT AUTO_INCREMENT,
    constraint ID_ProveedorPK Primary key (ID_Proveedor),
    nit_Proveedor int not null,
    constraint UQ_Nit_Proveedor unique (Nit_Proveedor), 
    nombre_Proveedor VARCHAR(100) NOT NULL,
    telefono_Proveedor VARCHAR(15) NOT NULL,
    direccion_Proveedor VARCHAR(255) NOT NULL
    )auto_increment = 3001;

-- Tabla Producto
CREATE TABLE Producto (
    COD_Producto INT AUTO_INCREMENT,
    CONSTRAINT COD_ProductoPK PRIMARY KEY (COD_Producto),
    nombre_Producto VARCHAR(100) NOT NULL,
    descripcion_Producto char NOT NULL,
    precio_Producto int NOT NULL	
)auto_increment = 4001;

-- Tabla Factura
CREATE TABLE Factura (
    COD_Factura INT AUTO_INCREMENT,
    CONSTRAINT COD_FacturaPK PRIMARY KEY (COD_Factura),
    fecha_Factura DATE NOT NULL,
    cantidad_Producto int not null,
    total_Venta int not null, 
    metodo_Pago enum('Efectivo','Tarjeta','Transferencia') not null, 
	ID_ClienteFK INT NOT NULL,
	CONSTRAINT ID_ClienteFK FOREIGN KEY (ID_ClienteFK) REFERENCES Cliente(ID_Cliente) 
    ON DELETE CASCADE 
	ON UPDATE CASCADE,
	ID_EmpleadoFK INT NOT NULL,
    CONSTRAINT ID_EmpleadoFK FOREIGN KEY (ID_EmpleadoFK) REFERENCES Empleado(ID_Empleado) 
    ON DELETE CASCADE 
	ON UPDATE CASCADE,
    COD_ProductoFK int not null, 
    constraint COD_ProductoFK Foreign Key (COD_ProductoFK) References Producto(COD_Producto) 
    ON DELETE CASCADE 
	ON UPDATE CASCADE
    )auto_increment = 9001;

-- Tabla Nomina
CREATE TABLE Nomina (
    COD_Nomina INT AUTO_INCREMENT,
    CONSTRAINT COD_NominaPK PRIMARY KEY (COD_Nomina),
    fecha_Pago DATE NOT NULL,
    mes_Pago enum('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'),
    año_Pago INT NOT NULL,
    salario_Bruto INT NOT NULL,
    bonificaciones INT NOT NULL default 0,
    descuentos int NOT NULL default 0,
    salario_Neto int NOT NULL,
    ID_EmpleadoFK2 INT NOT NULL,
    CONSTRAINT ID_EmpleadoFK2 FOREIGN KEY (ID_EmpleadoFK2) REFERENCES Empleado(ID_Empleado) 
    ON DELETE CASCADE 
	ON UPDATE CASCADE
)auto_increment = 0001;

-- Tabla Receta
CREATE TABLE Receta (
    COD_Receta INT AUTO_INCREMENT,
    CONSTRAINT COD_RecetaPK PRIMARY KEY (COD_Receta),
    cantidad_Usada INT NOT NULL,
    COD_ProductoFK2 INT NOT NULL,
	CONSTRAINT COD_ProductoFK2 FOREIGN KEY (COD_ProductoFK2) REFERENCES Producto(COD_Producto) 
    ON DELETE CASCADE 
	ON UPDATE CASCADE,
    COD_InsumoFK INT NOT NULL,
    CONSTRAINT COD_InsumoFK FOREIGN KEY (COD_InsumoFK) REFERENCES Insumo(COD_Insumo) 
    ON DELETE CASCADE 
	ON UPDATE CASCADE
    )auto_increment = 8001;

-- Tabla inventarioInsumo
CREATE TABLE inventario_Insumo (
    COD_inventario_Insumo INT,
    CONSTRAINT PK_COD_inventario_Insumo PRIMARY KEY (COD_inventario_Insumo),
    nombre_Insumo_Comprado VARCHAR(100) NOT NULL, 
    cantidad_Insumo INT NOT NULL,
    fecha_Ingreso_Insumo DATE NOT NULL, 
    estado_Insumo ENUM('Vigente', 'Próximo a vencer') NOT NULL,
    COD_InsumoFK2 INT NOT NULL,
    CONSTRAINT FK_COD_Insumo FOREIGN KEY (COD_InsumoFK2) REFERENCES Insumo(COD_Insumo) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
-- Tabla Compra
CREATE TABLE Compra (
    COD_Compra INT AUTO_INCREMENT,
	CONSTRAINT COD_CompraPK PRIMARY KEY (COD_Compra),
    ID_ProveedorFK INT NOT NULL,
    CONSTRAINT ID_ProveedorFK FOREIGN KEY (ID_ProveedorFK) REFERENCES Proveedor(ID_Proveedor) 
    ON DELETE CASCADE 
	ON UPDATE CASCADE,
    COD_InsumoFK2 INT NOT NULL,
    CONSTRAINT COD_InsumoFK2 FOREIGN KEY (COD_InsumoFK2) REFERENCES Insumo(COD_Insumo)
    ON DELETE CASCADE 
	ON UPDATE CASCADE,
	nombre_Insumo_Comprado varchar(100) not null, 
	cantidad_Insumo_Compra INT NOT NULL,
    fecha_Compra_Insumo DATE NOT NULL    
)auto_increment = 7001;

INSERT INTO Cliente (Cc_Cliente, nombre_Cliente, telefono_Cliente, direccion_Delivery) VALUES
(123456789, 'Ana García', '3001234567', 'Calle 1 # 2-3'),
(987654321, 'Luis Pérez', '3109876543', 'Avenida 4 # 5-6'),
(112233445, 'María López', '3201122334', 'Carrera 7 # 8-9'),
(556677889, 'Carlos Rodríguez', '3155566778', 'Diagonal 10 # 11-12'),
(998877665, 'Laura Martínez', '3019988776', 'Transversal 13 # 14-15'),
(443322119, 'Javier Sánchez', '3124433221', 'Circular 16 # 17-18'),
(667788991, 'Sofía Díaz', '3026677889', 'Manzana 1 # Casa 2'),
(889911223, 'Andrés González', '3168899112', 'Apartamento 301'),
(223344556, 'Valentina Ramírez', '3032233445', 'Bloque 4 # Apartamento 5'),
(778899112, 'Daniel Castro', '3177788991', 'Local 6 # Oficina 7');

INSERT INTO Empleado (Cc_Empleado, nombre_Empleado, direccion_Empleado, telefono_Empleado, cargo_Empleado) VALUES
(100111222, 'Pedro Gómez', 'Calle 20 # 21-22', '3181001112', 'Cajero'),
(200222333, 'Marta Ruiz', 'Avenida 23 # 24-25', '3192002223', 'Cocinero'),
(300333444, 'Ricardo Torres', 'Carrera 26 # 27-28', '3213003334', 'Administrador'),
(400444555, 'Isabel Jiménez', 'Diagonal 29 # 30-31', '3224004445', 'Mesero'),
(500555666, 'Fernando Vargas', 'Transversal 32 # 33-34', '3235005556', 'Repartidor'),
(600666777, 'Carmen Herrera', 'Circular 35 # 36-37', '3246006667', 'Ayudante de Cocina'),
(700777888, 'Roberto Núñez', 'Manzana 8 # Casa 9', '3257007778', 'Gerente'),
(800888999, 'Silvia Morales', 'Apartamento 401', '3268008889', 'Contador'),
(900999111, 'Jorge Castillo', 'Bloque 10 # Apartamento 11', '3279009991', 'Supervisor'),
(100100121, 'Elena Sandoval', 'Local 12 # Oficina 13', '3281001001', 'Cajero');

INSERT INTO Insumo (nombre_Insumo, descripcion, cantidad_Insumo, fecha_Vencimiento_Insumo) VALUES
('Harina de Maíz', 'Harina precocida para tamales', 50, '2024-12-31'),
('Carne de Cerdo', 'Carne para relleno de tamales', 30, '2024-12-25'),
('Pollo', 'Pollo desmechado para relleno', 40, '2024-12-28'),
('Arroz', 'Arroz blanco para acompañar', 60, '2025-01-15'),
('Cebolla', 'Cebolla blanca picada', 20, '2024-12-20'),
('Ajo', 'Ajo triturado', 15, '2024-12-18'),
('Pimentón', 'Pimentón rojo picado', 25, '2024-12-22'),
('Hojas de Plátano', 'Hojas para envolver tamales', 100, '2025-02-28'),
('Sal', 'Sal refinada', 10, '2025-03-30'),
('Comino', 'Comino molido', 5, '2025-04-15');

INSERT INTO Proveedor (nit_Proveedor, nombre_Proveedor, telefono_Proveedor, direccion_Proveedor) VALUES
(111222333, 'Proveedora de Harinas S.A.', '3101112223', 'Calle 40 # 41-42'),
(444555666, 'Carnes El Rey', '3114445556', 'Avenida 43 # 44-45'),
(777888999, 'Productos Avícolas Ltda.', '3127778889', 'Carrera 46 # 47-48'),
(121212131, 'Distribuidora de Arroz S.A.', '3131212121', 'Diagonal 49 # 50-51'),
(343434353, 'Verduras Frescas SAS', '3143434343', 'Transversal 52 # 53-54'),
(565656575, 'Especias del Campo', '3155656565', 'Circular 55 # 56-57'),
(787878797, 'Hojas de Plátano La Verde', '3167878787', 'Manzana 10 # Casa 11'),
(909090919, 'Salinas del Pacífico', '3179090909', 'Apartamento 501'),
(232323242, 'Comercializadora de Comino', '3182323232', 'Bloque 12 # Apartamento 13'),
(454545464, 'Proveedora la Abundancia', '329000000', 'Local 14 # Oficina 15');

INSERT INTO Producto (nombre_Producto, descripcion_Producto, precio_Producto) VALUES
('Tamal de Cerdo', 'C', 10000),
('Tamal de Pollo', 'P', 9000),
('Tamal Mixto', 'M', 11000),
('Arroz con Pollo', 'A', 8000),
('Tamal Vegano', 'V', 12000),
('Lechona', 'L', 15000),
('Sopa de Mondongo', 'S', 9500),
('Bandeja Paisa', 'B', 16000),
('Ajiaco', 'A', 13000),
('Chicharron', 'C', 8500);

INSERT INTO Factura (fecha_Factura, cantidad_Producto, total_Venta, metodo_Pago, ID_ClienteFK, ID_EmpleadoFK, COD_ProductoFK) VALUES
('2023-11-20', 2, 20000, 'Efectivo', 1001, 2001, 4001),
('2023-11-21', 1, 9000, 'Tarjeta', 1002, 2002, 4002),
('2023-11-22', 3, 33000, 'Transferencia', 1003, 2003, 4003),
('2023-11-23', 2, 16000, 'Efectivo', 1004, 2004, 4004),
('2023-11-24', 1, 12000, 'Tarjeta', 1005, 2005, 4005),
('2023-11-25', 1, 15000, 'Transferencia', 1006, 2006, 4006),
('2023-11-26', 2, 19000, 'Efectivo', 1007, 2007, 4007),
('2023-11-27', 1, 16000, 'Tarjeta', 1008, 2008, 4008),
('2023-11-28', 3, 39000, 'Transferencia', 1009, 2009, 4009),
('2023-11-29', 2, 17000, 'Efectivo', 1010, 2010, 4010);

INSERT INTO Nomina (fecha_Pago, mes_Pago, año_Pago, salario_Bruto, bonificaciones, descuentos, salario_Neto, ID_EmpleadoFK2) VALUES
('2023-11-30', 'Noviembre', 2023, 1200000, 100000, 50000, 1250000, 2001),
('2023-11-30', 'Noviembre', 2023, 1500000, 150000, 75000, 1575000, 2002),
('2023-11-30', 'Noviembre', 2023, 2000000, 200000, 100000, 2100000, 2003),
('2023-11-30', 'Noviembre', 2023, 1100000, 50000, 25000, 1125000, 2004),
('2023-11-30', 'Noviembre', 2023, 1000000, 75000, 30000, 1045000, 2005),
('2023-11-30', 'Noviembre', 2023, 1000000, 75000, 30000, 1045000, 2006),
('2023-11-30', 'Noviembre', 2023, 3000000, 200000, 100000, 3100000, 2007),
('2023-11-30', 'Noviembre', 2023, 2500000, 150000, 75000, 2575000, 2008),
('2023-11-30', 'Noviembre', 2023, 2000000, 100000, 50000, 2050000, 2009),
('2023-11-30', 'Noviembre', 2023, 1100000, 50000, 25000, 1125000, 2010);

INSERT INTO Receta (cantidad_Usada, COD_ProductoFK2, COD_InsumoFK) VALUES
(20, 4001, 5001), -- Tamal de cerdo: 20 unidades de harina de maíz
(15, 4001, 5002), -- Tamal de cerdo: 15 unidades de carne de cerdo
(18, 4002, 5001), -- Tamal de pollo: 18 unidades de harina de maíz
(12, 4002, 5003), -- Tamal de pollo: 12 unidades de pollo
(22, 4003, 5001), -- Tamal mixto: 22 unidades de harina de maíz
(10, 4003, 5002), -- Tamal mixto: 10 unidades de carne de cerdo
(10, 4003, 5003), -- Tamal mixto: 10 unidades de pollo
(25, 4004, 5004), -- Arroz con pollo: 25 unidades de arroz
(15, 4004, 5003), -- Arroz con pollo: 15 unidades de pollo
(20, 4005, 5001);-- tamal vegano: 20 unidades de harina de maiz

INSERT INTO inventario_Insumo (COD_inventario_Insumo, nombre_Insumo_Comprado, cantidad_Insumo, fecha_Ingreso_Insumo, estado_Insumo, COD_InsumoFK2) VALUES
(6001, 'Harina de Maíz', 100, '2023-11-15', 'Vigente', 5001),
(6002, 'Carne de Cerdo', 50, '2023-11-16', 'Vigente', 5002),
(6003, 'Pollo', 75, '2023-11-17', 'Vigente', 5003),
(6004, 'Arroz', 120, '2023-11-18', 'Vigente', 5004),
(6005, 'Cebolla', 40, '2023-11-19', 'Vigente', 5005),
(6006, 'Ajo', 30, '2023-11-20', 'Vigente', 5006),
(6007, 'Pimentón', 50, '2023-11-21', 'Vigente', 5007),
(6008, 'Hojas de Plátano', 200, '2023-11-22', 'Vigente', 5008),
(6009, 'Sal', 20, '2023-11-23', 'Vigente', 5009),
(6010, 'Comino', 10, '2023-11-24', 'Vigente', 5010);

INSERT INTO Compra (ID_ProveedorFK, COD_InsumoFK2, nombre_Insumo_Comprado, cantidad_Insumo_Compra, fecha_Compra_Insumo) VALUES
(3001, 5001, 'Harina de Maíz', 100, '2023-11-15'),
(3002, 5002, 'Carne de Cerdo', 50, '2023-11-16'),
(3003, 5003, 'Pollo', 75, '2023-11-17'),
(3004, 5004, 'Arroz', 120, '2023-11-18'),
(3005, 5005, 'Cebolla', 40, '2023-11-19'),
(3006, 5006, 'Ajo', 30, '2023-11-20'),
(3007, 5007, 'Pimentón', 50, '2023-11-21'),
(3008, 5008, 'Hojas de Plátano', 200, '2023-11-22'),
(3009, 5009, 'Sal', 20, '2023-11-23'),
(3010, 5010, 'Comino', 10, '2023-11-24');

select * from cliente;
select * from empleado;
select * from insumo;
select * from proveedor;
select * from producto;
select * from factura;
select * from nomina;
select * from receta;
select * from inventario_insumo;
select * from compra;


-- SAMUEL consultas --


DELIMITER //
CREATE PROCEDURE GestionarProveedor(
    IN p_accion VARCHAR(10),
    IN p_nit INT,
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(15),
    IN p_direccion VARCHAR(255),
    IN p_id_proveedor INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    CASE p_accion
        WHEN 'INSERTAR' THEN
            -- Verificar si el NIT ya existe
            IF EXISTS (SELECT 1 FROM Proveedor WHERE nit_Proveedor = p_nit) THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'El NIT ya está registrado';
            ELSE
                -- Insertar nuevo proveedor
                INSERT INTO Proveedor (nit_Proveedor, nombre_Proveedor, telefono_Proveedor, direccion_Proveedor)
                VALUES (p_nit, p_nombre, p_telefono, p_direccion);
                
                -- Mostrar el proveedor insertado
                SELECT * FROM Proveedor WHERE ID_Proveedor = LAST_INSERT_ID();
            END IF;

        WHEN 'ACTUALIZAR' THEN
            -- Actualizar datos del proveedor
            UPDATE Proveedor
            SET nombre_Proveedor = p_nombre,
                telefono_Proveedor = p_telefono,
                direccion_Proveedor = p_direccion
            WHERE ID_Proveedor = p_id_proveedor;
            
            -- Mostrar resultados de la actualización
            SELECT 
                'Registro actualizado' AS Resultado,
                ROW_COUNT() AS Filas_Afectadas;

        WHEN 'BUSCAR' THEN
            -- Buscar proveedor por NIT
            SELECT * FROM Proveedor 
            WHERE nit_Proveedor = p_nit;

        WHEN 'ELIMINAR' THEN
            -- Eliminar proveedor
            DELETE FROM Proveedor 
            WHERE ID_Proveedor = p_id_proveedor;
            
            -- Verificar eliminación
            SELECT 
                CASE WHEN ROW_COUNT() > 0 THEN 'Eliminación exitosa'
                ELSE 'No se encontró el proveedor' END AS Resultado;

        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Acción no válida. Opciones: INSERTAR, ACTUALIZAR, BUSCAR, ELIMINAR';
    END CASE;

    COMMIT;
END//
DELIMITER ;

call GestionarProveedor('BUSCAR', 343434353, NULL, NULL, NULL, NULL);

call GestionarProveedor('INSERTAR', 123456789, 'Distribuciones S.A.', '555-1234', 'Calle Principal 456', NULL);

call GestionarProveedor('ACTUALIZAR', NULL, 'Nuevo Nombre S.A.', '555-9876', 'Avenida Secundaria 789', 3001);

call GestionarProveedor('ELIMINAR', NULL, NULL, NULL, NULL, 3001);


DELIMITER //
CREATE PROCEDURE GestionarReceta(
    IN p_accion VARCHAR(10),
    IN p_cod_receta INT,
    IN p_cantidad INT,
    IN p_cod_producto INT,
    IN p_cod_insumo INT,
    IN p_nuevo_cod_producto INT,
    IN p_nuevo_cod_insumo INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    CASE p_accion
        WHEN 'INSERTAR' THEN
            -- Validar existencia de producto e insumo
            IF NOT EXISTS(SELECT 1 FROM Producto WHERE COD_Producto = p_cod_producto) THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto no existe';
            END IF;
            
            IF NOT EXISTS(SELECT 1 FROM Insumo WHERE COD_Insumo = p_cod_insumo) THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El insumo no existe';
            END IF;

            -- Insertar nueva receta
            INSERT INTO Receta(cantidad_Usada, COD_ProductoFK2, COD_InsumoFK)
            VALUES(p_cantidad, p_cod_producto, p_cod_insumo);
            
            -- Mostrar receta creada
            SELECT * FROM Receta WHERE COD_Receta = LAST_INSERT_ID();

        WHEN 'ACTUALIZAR' THEN
            -- Validar existencia de receta
            IF NOT EXISTS(SELECT 1 FROM Receta WHERE COD_Receta = p_cod_receta) THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Receta no encontrada';
            END IF;
            
            -- Validar nuevos códigos
            IF NOT EXISTS(SELECT 1 FROM Producto WHERE COD_Producto = p_nuevo_cod_producto) THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nuevo producto no existe';
            END IF;
            
            IF NOT EXISTS(SELECT 1 FROM Insumo WHERE COD_Insumo = p_nuevo_cod_insumo) THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nuevo insumo no existe';
            END IF;

            -- Actualizar receta
            UPDATE Receta
            SET cantidad_Usada = p_cantidad,
                COD_ProductoFK2 = p_nuevo_cod_producto,
                COD_InsumoFK = p_nuevo_cod_insumo
            WHERE COD_Receta = p_cod_receta;
            
            -- Mostrar resultados
            SELECT 'Actualización exitosa' AS Resultado;

        WHEN 'BUSCAR' THEN
            -- Búsqueda flexible
            SELECT r.*, p.nombre AS producto, i.nombre AS insumo
            FROM Receta r
            INNER JOIN Producto p ON r.COD_ProductoFK2 = p.COD_Producto
            INNER JOIN Insumo i ON r.COD_InsumoFK = i.COD_Insumo
            WHERE (r.COD_Receta = p_cod_receta OR p_cod_receta IS NULL)
            AND (r.COD_ProductoFK2 = p_cod_producto OR p_cod_producto IS NULL)
            AND (r.COD_InsumoFK = p_cod_insumo OR p_cod_insumo IS NULL);

        WHEN 'ELIMINAR' THEN
            -- Eliminar receta
            DELETE FROM Receta WHERE COD_Receta = p_cod_receta;
            
            -- Confirmar eliminación
            SELECT CONCAT('Receta ', p_cod_receta, ' eliminada') AS Resultado;

        ELSE
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Acción no válida. Opciones: INSERTAR, ACTUALIZAR, BUSCAR, ELIMINAR';
    END CASE;

    COMMIT;
END//
DELIMITER ;

CALL GestionarReceta(
    'INSERTAR', 
    NULL,         -- No se usa para INSERTAR
    5,           -- Cantidad usada
    101,        -- Código del producto
    201,        -- Código del insumo
    NULL,       -- No se usa para INSERTAR
    NULL        -- No se usa para INSERTAR
);

CALL GestionarReceta(
    'ACTUALIZAR', 
    1,          -- Código de la receta a actualizar
    10,        -- Nueva cantidad
    NULL,      -- No se usa para ACTUALIZAR
    NULL,      -- No se usa para ACTUALIZAR
    102,      -- Nuevo código de producto
    202       -- Nuevo código de insumo
);



CALL GestionarReceta('INSERTAR', 8011, 15, 1001, 2001, NULL, NULL);

CALL GestionarReceta('ACTUALIZAR', 8001, 200, NULL, NULL, 1002, 2003);

-- todas las recetas
CALL GestionarReceta('BUSCAR', NULL, NULL, NULL, NULL, NULL, NULL);

-- recetas con producto específico
CALL GestionarReceta('BUSCAR', NULL, NULL, 1001, NULL, NULL, NULL);

-- receta específica con detalle completo 
CALL GestionarReceta('BUSCAR', 8003, NULL, NULL, NULL, NULL, NULL);


CALL GestionarReceta('ELIMINAR', 8002, NULL, NULL, NULL, NULL, NULL);
select * from receta;


-- VALENTINA consultas --

delimiter //
-- Tabla Cliente -- 
-- procedimiento para comprobar si un cliente ya está registrado
create procedure checkcliente(in cedula int)
begin
    select 
        case 
            when exists (select * from cliente where cc_cliente = cedula) 
            then 'el cliente ya existe' 
            else 'el cliente no existe' 
        end as mensaje;
end //

-- procedimiento para obtener clientes y fecha de factura
create procedure getclientesconfactura()
begin
    select 
        c.nombre_cliente as nombre_cliente, 
        f.fecha_factura as fecha_factura 
    from 
        cliente as c
    inner join 
        factura as f on c.id_cliente = f.id_clientefk;
end //
-- Tabla Factura --
-- procedimiento para obtener la suma total de facturaciones
create procedure totalfacturacion()
begin
    select 
        sum(total_venta) as total_facturacion 
    from 
        factura;
end //

-- procedimiento para obtener el promedio de ventas
create procedure promedioventas()
begin
    select 
        case 
            when avg(total_venta) > 1000000 
            then 'las ventas han sido muy altas' 
            else 'las ventas han sido moderadas' 
        end as mensaje
    from 
        factura;
end //
-- Tabla Producto --
-- procedimiento para obtener productos que superan un rango de precio
create procedure productosporprecio()
begin
    select 
        nombre_producto as nombre_producto, 
        precio_producto as precio_producto 
    from 
        producto 
    where 
        precio_producto > 10000;
end //

-- procedimiento para obtener el precio promedio de los productos
create procedure preciopromedioproductos()
begin
    select 
        case 
            when avg(precio_producto) > 50000 
            then 'los productos son caros' 
            else 'los productos son accesibles' 
        end as mensaje 
    from 
        producto;
end //

delimiter ;

CALL checkcliente(123456789);  -- Reemplaza con una cédula de prueba

CALL getclientesconfactura();

CALL totalfacturacion();

CALL promedioventas();

CALL productosporprecio();

CALL preciopromedioproductos();



-- ESTEBAN consultas y triggers
CALL RegistrarCompraActualizarInventario(
3015, -- p_ID_ProveedorFK (ID del proveedor)
5020, -- p_COD_InsumoFK2 (Código del insumo)
'Bolsa plástica ', -- p_nombre_Insumo_Comprado (Nombre del insumo)
500, -- p_cantidad_Insumo_Compra (Cantidad comprada)
'2024-10-27' -- p_fecha_Compra_Insumo (Fecha de la compra)
);






-- TRIGGER --
DELIMITER $$
CREATE TRIGGER calcular_salario_neto_update
BEFORE UPDATE ON Nomina
FOR EACH ROW
BEGIN
    SET NEW.salario_Neto = NEW.salario_Bruto + NEW.bonificaciones - NEW.descuentos;
END$$
DELIMITER ;
-- TRIGGER --
DELIMITER $$
CREATE TRIGGER actualizar_estado_insumo
BEFORE UPDATE ON inventario_Insumo
FOR EACH ROW
BEGIN
    IF NEW.fecha_Vencimiento_Insumo <= DATE_ADD(CURDATE(), INTERVAL 30 DAY) THEN
        SET NEW.estado_Insumo = 'Próximo a vencer';
    END IF;
END$$
DELIMITER ;

-- Consulta recurrente para obtener el historial completo de compras para un insumo específico:
SELECT
c.fecha_Compra_Insumo,
c.cantidad_Insumo_Compra,
c.nombre_Insumo_Comprado,
ii.cantidad_Insumo,
ii.estado_Insumo
FROM
Compra c
JOIN
inventario_Insumo ii ON c.COD_InsumoFK2 = ii.COD_InsumoFK2
WHERE
c.COD_InsumoFK2 = ("5001"); -- Ejemplo con Harina de trigo,  COD_Insumo = 5001.

-- Consulta recurrente para obtener un informe de insumos próximos a vencer:
SELECT
c.fecha_Compra_Insumo,
c.cantidad_Insumo_Compra,
c.nombre_Insumo_Comprado,
ii.cantidad_Insumo,
ii.estado_Insumo
FROM
Compra c
JOIN
inventario_Insumo ii ON c.COD_InsumoFK2 = ii.COD_InsumoFK2
WHERE
c.COD_InsumoFK2 = ("5003"); -- Ejemplo con producto Pollo. COD_Insumo = 5003. 

-- Consulta Recurrente para identificar la compra de un Insumo específico a un Proveedor específico.
SELECT
i.nombre_Insumo,
SUM(c.cantidad_Insumo_Compra) AS total_comprado,
p.nombre_Proveedor
FROM
Insumo i
JOIN
Compra c ON i.COD_Insumo = c.COD_InsumoFK2
JOIN 
Proveedor p ON c.ID_ProveedorFK = p.ID_Proveedor 
WHERE
i.nombre_Insumo = 'Carne de Cerdo' AND c.ID_ProveedorFK = 3002 -- Ejemplo con Insumo = Carne de Cerdo y Proveedor = Carnes El Rey.
GROUP BY
i.nombre_Insumo, p.nombre_Proveedor;

-- Consulta recurrente para obtener un resumen del inventario actual.
SELECT
i.nombre_Insumo,
ii.cantidad_Insumo,
ii.estado_Insumo
FROM
Insumo i
JOIN
inventario_Insumo ii ON i.COD_Insumo = ii.COD_InsumoFK2;




-- Procedimiento almacenado para registrar compras de insumos a proveedores, en caso de que el insumo no exista, se abre la posibilidad de hacer el registro de este nuevo insumo.
DELIMITER $$
CREATE PROCEDURE RegistrarCompraActualizarInventario (
    IN p_ID_ProveedorFK INT,
    IN p_COD_InsumoFK2 INT,
    IN p_nombre_Insumo_Comprado VARCHAR(100),
    IN p_cantidad_Insumo_Compra INT,
    IN p_fecha_Compra_Insumo DATE
)
BEGIN
    -- Insertar la compra
    INSERT INTO Compra (ID_ProveedorFK, COD_InsumoFK2, nombre_Insumo_Comprado, cantidad_Insumo_Compra, fecha_Compra_Insumo)
    VALUES (p_ID_ProveedorFK, p_COD_InsumoFK2, p_nombre_Insumo_Comprado, p_cantidad_Insumo_Compra, p_fecha_Compra_Insumo);


    -- Actualizar el inventario o crear un nuevo registro si no existe
    IF EXISTS (SELECT 1 FROM inventario_Insumo WHERE COD_InsumoFK2 = p_COD_InsumoFK2) THEN
        UPDATE inventario_Insumo
        SET cantidad_Insumo = cantidad_Insumo + p_cantidad_Insumo_Compra
        WHERE COD_InsumoFK2 = p_COD_InsumoFK2;
    ELSE
        INSERT INTO inventario_Insumo (COD_InsumoFK2, nombre_Insumo_Comprado, cantidad_Insumo, fecha_Ingreso_Insumo, estado_Insumo)
        VALUES (p_COD_InsumoFK2, p_nombre_Insumo_Comprado, p_cantidad_Insumo_Compra, p_fecha_Compra_Insumo, 'Vigente');
    END IF;
END$$
DELIMITER ;



-- Procedimiento Almacenado para introducir una nueva receta.
DELIMITER $$
CREATE PROCEDURE nuevaReceta (
    IN p_cantidad_Usada INT,
    IN p_COD_ProductoFK2 INT,
    IN p_COD_InsumoFK INT
)
BEGIN
    insert into Receta(cantidad_Usada, COD_ProductoFK2, COD_InsumoFK) values(p_cantidad_Usada, p_COD_ProductoFK2, p_COD_InsumoFK);
END$$
DELIMITER ;

-- GABY consultas --

-- calcular el salario neto promedio de los empleados agrupado por su cargo.
DELIMITER //

CREATE PROCEDURE SalarioNetoPromedioPorCargo()
BEGIN
    SELECT 
        e.cargo_Empleado AS Cargo,
        AVG(n.salario_Neto) AS Salario_Neto_Promedio
    FROM Empleado e
    JOIN Nomina n ON e.ID_Empleado = n.ID_EmpleadoFK2
    GROUP BY e.cargo_Empleado;
END //

DELIMITER ;
CALL SalarioNetoPromedioPorCargo(); 



-- Obtener empleados con salario neto superior a un valor específico
DELIMITER //

CREATE PROCEDURE EmpleadosConSalarioSuperior(IN salario_minimo INT)
BEGIN
    SELECT 
        e.nombre_Empleado,
        e.cargo_Empleado,
        n.salario_Neto
    FROM Empleado e
    JOIN Nomina n ON e.ID_Empleado = n.ID_EmpleadoFK2
    WHERE n.salario_Neto > salario_minimo;
END //

DELIMITER ;

CALL EmpleadosConSalarioSuperior(1500000); -- Empleados con salario neto superior a 1,500,000



-- Obtener la nomina de un empleado
select * from empleado;

DELIMITER //

CREATE PROCEDURE ObtenerNominaEmpleado(IN empleado_id INT)
BEGIN
    SELECT 
        n.fecha_Pago,
        n.mes_Pago,
        n.año_Pago,
        n.salario_Bruto,
        n.bonificaciones,
        n.descuentos,
        n.salario_Neto
    FROM Nomina n
    WHERE n.ID_EmpleadoFK2 = empleado_id;
END //

DELIMITER ;

CALL ObtenerNominaEmpleado(2001); -- Obtiene la nómina del empleado con ID 2001



-- Obtener el salario neto total pagado por mes, pero solo para aquellos meses donde el salario neto total sea superior a 5,000,000.
SELECT 
    n.mes_Pago AS Mes,
    SUM(n.salario_Neto) AS Salario_Neto_Total
FROM Nomina n
GROUP BY n.mes_Pago
HAVING SUM(n.salario_Neto) < 5000000;

-- Crear el Trigger para calcular automáticamente el salario neto

DELIMITER $$

CREATE TRIGGER calcular_salario_neto
BEFORE INSERT ON Nomina
FOR EACH ROW
BEGIN
    SET NEW.salario_Neto = NEW.salario_Bruto + NEW.bonificaciones - NEW.descuentos;
END $$

DELIMITER ;

SHOW TRIGGERS FROM TamalitosDonJuanito WHERE `Trigger` = 'calcular_salario_neto';


DELIMITER $$

CREATE TRIGGER validar_descuentos
BEFORE INSERT ON Nomina
FOR EACH ROW
BEGIN
    IF NEW.descuentos > NEW.salario_Bruto THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Los descuentos no pueden ser mayores que el salario bruto';
    END IF;
END $$

DELIMITER ;

SHOW TRIGGERS FROM tamalitosdonjuanito WHERE `Trigger` = 'validar_descuentos';

-- Registrar nómina y actualizar salario neto del empleado
START TRANSACTION;
BEGIN;

-- Insertar una nueva nómina para 1 empleado con ID_Empleado = 2002
INSERT INTO Nomina (
    fecha_Pago,
    mes_Pago,
    año_Pago,
    salario_Bruto,
    bonificaciones,
    descuentos,
    salario_Neto,
    ID_EmpleadoFK2
)
VALUES (
    '2023-12-01',
    'Diciembre',
    2023,
    2000000,
    100000,
    50000,
    2050000,
    2002
);

-- Confirmar la transacción si todo está bien
COMMIT;

-- Mensaje de confirmación
SELECT 'Transacción completada con éxito.' AS Mensaje;

-- Verificar el registro insertado
SELECT * FROM Nomina WHERE ID_EmpleadoFK2 = 2002;

select
    Cliente.nombre_Cliente as Cliente,
    Producto.nombre_Producto as Producto,
    Empleado.nombre_Empleado as Vendedor,
    Receta.COD_Receta as Codigo_Receta
from Factura
join Cliente on Factura.ID_ClienteFK = Cliente.ID_Cliente
join Producto on Factura.COD_ProductoFK = Producto.COD_Producto
join Empleado on Factura.ID_EmpleadoFK = Empleado.ID_Empleado
join Receta on Producto.COD_Producto = Receta.COD_ProductoFK2;


select * from Nomina where ID_EmpleadoFK2 = 2002;

select
    Cliente.nombre_Cliente as Nombre_Cliente,
    Producto.nombre_Producto as Producto_Comprado,
    Receta.COD_Receta as Codigo_Receta,
    Empleado.nombre_Empleado as Vendedor
from Factura
join Cliente on Factura.ID_ClienteFK = Cliente.ID_Cliente
join Empleado on Factura.ID_EmpleadoFK = Empleado.ID_Empleado
join Producto on Factura.COD_ProductoFK = Producto.COD_Producto
join Receta on Producto.COD_Producto = Receta.COD_ProductoFK2
where Cliente.ID_Cliente = 1002; 

select * from cliente;
