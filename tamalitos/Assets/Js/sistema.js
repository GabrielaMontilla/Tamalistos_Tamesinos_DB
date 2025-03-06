// Función para manejar el cambio entre pestañas
document.addEventListener('DOMContentLoaded', function() {
    // Manejo de pestañas
    const tabButtons = document.querySelectorAll('.tab-button');
    const tabContents = document.querySelectorAll('.tab-content');

    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            const tabId = this.getAttribute('data-tab');
            
            // Desactivar todas las pestañas
            tabButtons.forEach(btn => btn.classList.remove('active'));
            tabContents.forEach(content => content.classList.remove('active'));
            
            // Activar la pestaña seleccionada
            this.classList.add('active');
            document.getElementById(tabId).classList.add('active');
        });
    });

    // Inicializar datos del localStorage o crear arrays vacíos si no existen
    if (!localStorage.getItem('clientes')) localStorage.setItem('clientes', JSON.stringify([]));
    if (!localStorage.getItem('productos')) localStorage.setItem('productos', JSON.stringify([]));
    if (!localStorage.getItem('ventas')) localStorage.setItem('ventas', JSON.stringify([]));
    if (!localStorage.getItem('facturasVenta')) localStorage.setItem('facturasVenta', JSON.stringify([]));
    if (!localStorage.getItem('empleados')) localStorage.setItem('empleados', JSON.stringify([]));
    if (!localStorage.getItem('nominas')) localStorage.setItem('nominas', JSON.stringify([]));
    if (!localStorage.getItem('recetas')) localStorage.setItem('recetas', JSON.stringify([]));
    if (!localStorage.getItem('insumos')) localStorage.setItem('insumos', JSON.stringify([]));
    if (!localStorage.getItem('inventarios')) localStorage.setItem('inventarios', JSON.stringify([]));
    if (!localStorage.getItem('compras')) localStorage.setItem('compras', JSON.stringify([]));
    if (!localStorage.getItem('proveedores')) localStorage.setItem('proveedores', JSON.stringify([]));

    // Cargar los datos existentes en las tablas
    cargarTablas();

    // Manejo de formularios
    setupFormulario('clienteForm', 'clientes', 'tablaClientes');
    setupFormulario('productoForm', 'productos', 'tablaProductos');
    setupFormulario('ventaForm', 'ventas', 'tablaVentas');
    setupFormulario('empleadoForm', 'empleados', 'tablaEmpleados');
    setupFormulario('nominaForm', 'nominas', 'tablaNominas');
    setupFormulario('recetaForm', 'recetas', 'tablaRecetas');
    setupFormulario('insumoForm', 'insumos', 'tablaInsumos');
    setupFormulario('inventarioForm', 'inventarios', 'tablaInventarios');
    setupFormulario('compraForm', 'compras', 'tablaCompras');
    setupFormulario('proveedorForm', 'proveedores', 'tablaProveedores');

    // Configuración especial para la factura de venta
    setupFacturaVenta();

    // Configurar cálculo automático de salario neto
    setupCalculoSalarioNeto();
});

// Función para cargar datos en todas las tablas
function cargarTablas() {
    cargarTabla('clientes', 'tablaClientes', ['idCliente', 'ccCliente', 'nombreCliente', 'telefonoCliente', 'direccionCliente']);
    cargarTabla('productos', 'tablaProductos', ['codProducto', 'nombreProducto', 'descripcionProducto', 'precioProducto']);
    cargarTabla('ventas', 'tablaVentas', ['codVenta', 'estadoCuenta', 'idClienteVenta', 'codProductoVenta', 'idEmpleadoVenta']);
    cargarTabla('facturasVenta', 'tablaFacturasVenta', ['codFacturaVenta', 'idClienteFactura', 'codProductoFactura', 'idEmpleadoFactura', 'metodoPago', 'fechaFactura', 'totalVenta']);
    cargarTabla('empleados', 'tablaEmpleados', ['idEmpleado', 'ccEmpleado', 'nombreEmpleado', 'direccionEmpleado', 'telefonoEmpleado', 'cargoEmpleado']);
    cargarTabla('nominas', 'tablaNominas', ['idEmpleadoNomina', 'ccEmpleadoNomina', 'mesPago', 'anoPago', 'salarioBruto', 'descuentos', 'bonificaciones', 'salarioNeto', 'fechaPago']);
    cargarTabla('recetas', 'tablaRecetas', ['codReceta', 'codigoProducto', 'codInsumoReceta', 'nombreInsumoUtilizado', 'cantidadUsada']);
    cargarTabla('insumos', 'tablaInsumos', ['codInsumo', 'fechaVencimiento', 'nombreInsumo', 'descripcionInsumo', 'cantidadInsumo']);
    cargarTabla('inventarios', 'tablaInventarios', ['codInventario', 'codInsumoInventario', 'nombreInsumoComprado', 'cantidadInventario', 'fechaIngreso', 'estadoInsumo', 'fechaVencimientoInventario']);
    cargarTabla('compras', 'tablaCompras', ['codCompra', 'idProveedor', 'codConsumo', 'fechaCompra', 'nombreInsumoCompradoCompra', 'cantidadInsumoCompra']);
    cargarTabla('proveedores', 'tablaProveedores', ['idProveedorProveedor', 'nitProveedor', 'nombreProveedor', 'direccionProveedor', 'telefonoProveedor']);
}

// Función para cargar datos en una tabla específica
function cargarTabla(storageKey, tableId, campos) {
    const datos = JSON.parse(localStorage.getItem(storageKey)) || [];
    const tabla = document.getElementById(tableId).querySelector('tbody');
    tabla.innerHTML = '';

    datos.forEach(item => {
        const row = document.createElement('tr');
        
        campos.forEach(campo => {
            const cell = document.createElement('td');
            cell.textContent = item[campo];
            row.appendChild(cell);
        });

        // Agregar botones de editar y eliminar
        const actionsCell = document.createElement('td');
        
        // Botón editar
        const editBtn = document.createElement('button');
        editBtn.textContent = 'Editar';
        editBtn.className = 'btn btn-edit';
        editBtn.onclick = function() {
            editarRegistro(storageKey, item, campos);
        };
        actionsCell.appendChild(editBtn);
        
        // Botón eliminar
        const deleteBtn = document.createElement('button');
        deleteBtn.textContent = 'Eliminar';
        deleteBtn.className = 'btn btn-delete';
        deleteBtn.onclick = function() {
            eliminarRegistro(storageKey, item, campos[0]);
        };
        actionsCell.appendChild(deleteBtn);
        
        row.appendChild(actionsCell);
        tabla.appendChild(row);
    });
}

// Función para configurar el manejo de formularios
function setupFormulario(formId, storageKey, tableId) {
    const formulario = document.getElementById(formId);
    
    formulario.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Obtener los valores del formulario sin validaciones
        const formData = {};
        Array.from(formulario.elements).forEach(input => {
            if (input.id && input.id !== '' && input.type !== 'submit' && input.type !== 'reset') {
                formData[input.id] = input.value;
            }
        });
        
        // Obtener datos existentes
        let datos = JSON.parse(localStorage.getItem(storageKey)) || [];
        
        // Verificar si es una edición o un nuevo registro
        const idField = Object.keys(formData)[0]; // Asumimos que el primer campo es el ID
        const existingIndex = datos.findIndex(item => item[idField] == formData[idField]);
        
        if (existingIndex >= 0) {
            // Actualizar registro existente
            datos[existingIndex] = formData;
        } else {
            // Agregar nuevo registro
            datos.push(formData);
        }
        
        // Guardar en localStorage
        localStorage.setItem(storageKey, JSON.stringify(datos));
        
        // Recargar la tabla
        const campos = Object.keys(formData);
        cargarTabla(storageKey, tableId, campos);
        
        // Limpiar el formulario
        formulario.reset();
        
        alert('Registro guardado correctamente');
    });
}

// Función para editar un registro
function editarRegistro(storageKey, item, campos) {
    // Obtener el ID del formulario basado en el storageKey
    const formId = getFormIdFromStorageKey(storageKey);
    const formulario = document.getElementById(formId);
    
    // Rellenar el formulario con los datos del registro
    campos.forEach(campo => {
        const input = document.getElementById(campo);
        if (input) {
            input.value = item[campo];
        }
    });
    
    // Desplazarse al formulario
    formulario.scrollIntoView({behavior: 'smooth'});
}

// Función para eliminar un registro
function eliminarRegistro(storageKey, item, idField) {
    if (confirm('¿Está seguro de eliminar este registro?')) {
        // Obtener datos existentes
        let datos = JSON.parse(localStorage.getItem(storageKey)) || [];
        
        // Filtrar el registro a eliminar
        datos = datos.filter(registro => registro[idField] != item[idField]);
        
        // Guardar en localStorage
        localStorage.setItem(storageKey, JSON.stringify(datos));
        
        // Recargar la tabla
        const tableId = getTableIdFromStorageKey(storageKey);
        const campos = Object.keys(datos[0] || {});
        cargarTabla(storageKey, tableId, campos);
        
        alert('Registro eliminado correctamente');
    }
}

// Mapeo de storageKey a formId
function getFormIdFromStorageKey(storageKey) {
    const mapping = {
        'clientes': 'clienteForm',
        'productos': 'productoForm',
        'ventas': 'ventaForm',
        'facturasVenta': 'facturaVentaForm',
        'empleados': 'empleadoForm',
        'nominas': 'nominaForm',
        'recetas': 'recetaForm',
        'insumos': 'insumoForm',
        'inventarios': 'inventarioForm',
        'compras': 'compraForm',
        'proveedores': 'proveedorForm'
    };
    return mapping[storageKey] || '';
}

// Mapeo de storageKey a tableId
function getTableIdFromStorageKey(storageKey) {
    const mapping = {
        'clientes': 'tablaClientes',
        'productos': 'tablaProductos',
        'ventas': 'tablaVentas',
        'facturasVenta': 'tablaFacturasVenta',
        'empleados': 'tablaEmpleados',
        'nominas': 'tablaNominas',
        'recetas': 'tablaRecetas',
        'insumos': 'tablaInsumos',
        'inventarios': 'tablaInventarios',
        'compras': 'tablaCompras',
        'proveedores': 'tablaProveedores'
    };
    return mapping[storageKey] || '';
}

// Configuración específica para la factura de venta
function setupFacturaVenta() {
    const facturasForm = document.getElementById('facturaVentaForm');
    
    // Arreglo para almacenar los productos agregados a la factura
    let productosFactura = [];
    
    // Manejar el botón de agregar producto
    const btnAgregarProducto = document.getElementById('agregarProducto');
    btnAgregarProducto.addEventListener('click', function() {
        const producto = document.getElementById('producto').value;
        const cantidad = parseInt(document.getElementById('cantidad').value) || 0;
        const precioUnitario = parseFloat(document.getElementById('precioUnitario').value) || 0;
        
        // Permitir ingresar productos sin validaciones estrictas
        const total = cantidad * precioUnitario;
        
        // Agregar producto a la lista
        productosFactura.push({
            producto,
            cantidad,
            precioUnitario,
            total
        });
        
        // Actualizar la tabla de productos
        actualizarTablaProductosFactura();
        
        // Calcular el total de la factura
        calcularTotalFactura();
        
        // Limpiar los campos
        document.getElementById('producto').value = '';
        document.getElementById('cantidad').value = '';
        document.getElementById('precioUnitario').value = '';
    });
    
    // Manejar el envío del formulario de factura
    facturasForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Obtener los valores del formulario
        const formData = {};
        Array.from(facturasForm.elements).forEach(input => {
            if (input.id && input.id !== '' && input.type !== 'submit' && input.type !== 'reset' && input.type !== 'button') {
                formData[input.id] = input.value;
            }
        });
        
        // Añadir la lista de productos a la factura
        formData.productos = productosFactura;
        
        // Registrar cada producto en el inventario de productos
        registrarProductosComprados(productosFactura);
        
        // Obtener datos existentes
        let facturas = JSON.parse(localStorage.getItem('facturasVenta')) || [];
        
        // Verificar si es una edición o un nuevo registro
        const existingIndex = facturas.findIndex(item => item.codFacturaVenta == formData.codFacturaVenta);
        
        if (existingIndex >= 0) {
            // Actualizar registro existente
            facturas[existingIndex] = formData;
        } else {
            // Agregar nuevo registro
            facturas.push(formData);
        }
        
        // Guardar en localStorage
        localStorage.setItem('facturasVenta', JSON.stringify(facturas));
        
        // Recargar la tabla de facturas de venta mostrando el total
        cargarTabla('facturasVenta', 'tablaFacturasVenta', ['codFacturaVenta', 'idClienteFactura', 'codProductoFactura', 'idEmpleadoFactura', 'metodoPago', 'fechaFactura', 'totalVenta']);
        
        // Limpiar el formulario y los productos
        facturasForm.reset();
        productosFactura = [];
        document.getElementById('productosTable').querySelector('tbody').innerHTML = '';
        
        alert('Factura guardada correctamente');
    });
    
    // Función para registrar los productos comprados en la tabla de productos
    function registrarProductosComprados(productos) {
        const productosRegistrados = JSON.parse(localStorage.getItem('productos')) || [];
        
        productos.forEach(producto => {
            // Verificar si el producto ya existe por su nombre
            const existeProducto = productosRegistrados.findIndex(p => p.nombreProducto === producto.producto);
            
            if (existeProducto >= 0) {
                // Actualizar producto existente
                productosRegistrados[existeProducto].precioProducto = producto.precioUnitario;
            } else {
                // Crear nuevo producto
                const nuevoProducto = {
                    codProducto: generarCodigoUnico(),
                    nombreProducto: producto.producto,
                    descripcionProducto: '',
                    precioProducto: producto.precioUnitario
                };
                productosRegistrados.push(nuevoProducto);
            }
        });
        
        // Guardar productos actualizados
        localStorage.setItem('productos', JSON.stringify(productosRegistrados));
        
        // Recargar tabla de productos
        cargarTabla('productos', 'tablaProductos', ['codProducto', 'nombreProducto', 'descripcionProducto', 'precioProducto']);
    }
    
    // Función para generar un código único
    function generarCodigoUnico() {
        return 'PROD-' + Math.floor(Math.random() * 10000);
    }
    
    // Función para actualizar la tabla de productos de la factura
    function actualizarTablaProductosFactura() {
        const tablaProductos = document.getElementById('productosTable').querySelector('tbody');
        tablaProductos.innerHTML = '';
        
        productosFactura.forEach((item, index) => {
            const row = document.createElement('tr');
            
            // Agregar celdas con los datos del producto
            const cellProducto = document.createElement('td');
            cellProducto.textContent = item.producto;
            row.appendChild(cellProducto);
            
            const cellCantidad = document.createElement('td');
            cellCantidad.textContent = item.cantidad;
            row.appendChild(cellCantidad);
            
            const cellPrecio = document.createElement('td');
            cellPrecio.textContent = `$${item.precioUnitario.toLocaleString()}`;
            row.appendChild(cellPrecio);
            
            const cellTotal = document.createElement('td');
            cellTotal.textContent = `$${item.total.toLocaleString()}`;
            row.appendChild(cellTotal);
            
            // Agregar botón para eliminar el producto
            const cellAccion = document.createElement('td');
            const btnEliminar = document.createElement('button');
            btnEliminar.textContent = 'Eliminar';
            btnEliminar.className = 'btn btn-delete';
            btnEliminar.onclick = function() {
                productosFactura.splice(index, 1);
                actualizarTablaProductosFactura();
                calcularTotalFactura();
            };
            cellAccion.appendChild(btnEliminar);
            row.appendChild(cellAccion);
            
            tablaProductos.appendChild(row);
        });
    }
    
    // Función para calcular el total de la factura
    function calcularTotalFactura() {
        const total = productosFactura.reduce((sum, item) => sum + item.total, 0);
        document.getElementById('totalVenta').value = total;
        
        // Eliminamos la actualización del campo cantidadFactura que era redundante
    }
}

// Configurar cálculo automático de salario neto
function setupCalculoSalarioNeto() {
    const salarioBruto = document.getElementById('salarioBruto');
    const descuentos = document.getElementById('descuentos');
    const bonificaciones = document.getElementById('bonificaciones');
    const salarioNeto = document.getElementById('salarioNeto');
    
    function calcularSalarioNeto() {
        const bruto = parseFloat(salarioBruto.value) || 0;
        const desc = parseFloat(descuentos.value) || 0;
        const bonif = parseFloat(bonificaciones.value) || 0;
        
        const neto = bruto - desc + bonif;
        salarioNeto.value = neto;
    }
    
    salarioBruto.addEventListener('input', calcularSalarioNeto);
    descuentos.addEventListener('input', calcularSalarioNeto);
    bonificaciones.addEventListener('input', calcularSalarioNeto);
}