from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

# Configuración de la conexión a la base de datos
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Espectre21",
    database="yuseph"
)

@app.route('/register_player', methods=['POST'])
def register_player():
    data = request.json
    cursor = db.cursor()
    
    # Agregar un jugador
    query = "INSERT INTO players (username, score) VALUES (%s, %s)"
    values = (data['username'], 0)
    
    try:
        cursor.execute(query, values)
        db.commit()
        return jsonify({"message": "Player registered"}), 200
    except Exception as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500

@app.route('/get_score', methods=['POST'])
def get_score():
    data = request.json
    cursor = db.cursor(dictionary=True)
    
    query = "SELECT score FROM players WHERE username = %s"
    cursor.execute(query, (data['username'],))
    result = cursor.fetchone()
    
    if result:
        return jsonify(result), 200
    return jsonify({"error": "Player not found"}), 404

if __name__ == '__main__':
    app.run(debug=True)