from flask import Flask, jsonify, request, render_template
import mysql.connector

app = Flask(__name__, static_folder="static")

# 🔹 Función para conectar a MySQL
def conectar_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="123456",
        database="tamalitosdonjuanito",
        autocommit=True  # 🔹 Agregamos autocommit para evitar problemas con los cambios
    )

# 🔹 Ruta para servir index.html
@app.route('/')
def home():
    return render_template("main.html") 

@app.route('/sesion')
def sesion():
    return render_template('sesion.html')

@app.route('/sistema')
def sistema():
    return render_template('sistema.html')

# 🔹 Ruta para obtener datos de la tabla procurador
@app.route('/empleados', methods=['GET'])
def obtener_empleados():
    db = conectar_db()  # 🔹 Crea una nueva conexión
    cursor = db.cursor(dictionary=True)

    try:
        cursor.execute("SELECT * FROM Empleado")
        datos = cursor.fetchall()
        return jsonify(datos) if datos else jsonify({"mensaje": "No hay datos en la tabla procurador"})
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)})
    finally:
        cursor.close()
        db.close()

# 🔹 Ruta para obtener datos de la tabla cliente
@app.route('/clientes', methods=['GET'])
def obtener_clientes():
    db = conectar_db()  # 🔹 Crea una nueva conexión
    cursor = db.cursor(dictionary=True)

    try:
        cursor.execute("SELECT * FROM Cliente")
        datos = cursor.fetchall()
        return jsonify(datos) if datos else jsonify({"mensaje": "No hay datos en la tabla cliente"})
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)})
    finally:
        cursor.close()
        db.close()

# 🔹 Ruta para agregar un procurador
@app.route('/empleados', methods=['POST'])
def agregar_empleado():
    db = conectar_db()  # 🔹 Crea una nueva conexión
    cursor = db.cursor()

    try:
        data = request.json
        sql = "INSERT INTO Empleado (Cc_Empleado, nombre_Empleado, direccion_Empleado, telefono_Empleado, cargo_Empleado) VALUES (%s, %s, %s, %s, %s)"
        valores = (data["dni"], data["nombre"], data["direccion"], data["telefono"], data["cargo"])
        cursor.execute(sql, valores)
        db.commit()
        return jsonify({"mensaje": "Empleado agregado correctamente"})
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)})
    finally:
        cursor.close()
        db.close()

# 🔹 Ruta para agregar un cliente
@app.route('/clientes', methods=['POST'])
def agregar_cliente():
    db = conectar_db()  # 🔹 Crea una nueva conexión
    cursor = db.cursor()

    try:
        data = request.json
        sql = "INSERT INTO Cliente (Cc_Cliente, nombre_Cliente, telefono_Cliente, direccion_Delivery) VALUES (%s, %s, %s, %s)"
        valores = (data["dni"], data["nombre"], data["telefono"], data["direccion"])
        cursor.execute(sql, valores)
        db.commit()
        return jsonify({"mensaje": "Cliente agregado correctamente"})
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)})
    finally:
        cursor.close()
        db.close()

# Ruta para eliminar Cliente
@app.route('/clientes/<int:id_cliente>', methods=['DELETE'])
def eliminar_cliente(id_cliente):
    db = conectar_db()
    cursor = db.cursor()

    try:
        # 🔹 Verificar si el cliente existe antes de eliminar
        cursor.execute("SELECT * FROM Cliente WHERE ID_Cliente = %s", (id_cliente,))
        cliente = cursor.fetchone()

        if not cliente:
            return jsonify({"mensaje": "Cliente no encontrado"}), 404

        # 🔹 Intentar eliminar al cliente
        cursor.execute("DELETE FROM Cliente WHERE ID_Cliente = %s", (id_cliente,))
        db.commit()

        return jsonify({"mensaje": "Cliente eliminado correctamente"}), 200

    except mysql.connector.Error as err:
        db.rollback()  # 🔹 Revertir cambios en caso de error
        return jsonify({"error": str(err)}), 500

    finally:
        cursor.close()
        db.close()


# 🔹 Ejecutar la aplicación
if __name__ == '__main__':
    app.run(debug=True)
