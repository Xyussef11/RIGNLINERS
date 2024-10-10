extends Node

var server_url = "http://localhost:5000"  # Cambia a la URL de tu servidor si está en otro host

# Registra a un nuevo jugador en la base de datos
func register_player(username):
    var http = HTTPRequest.new()
    add_child(http)
    http.connect("request_completed", self, "_on_request_completed")
    
    var request_data = {
        "username": username
    }
    
    var error = http.request(server_url + "/register_player", [], true, HTTPClient.METHOD_POST, to_json(request_data))
    if error != OK:
        print("Error enviando la solicitud: ", error)

# Obtiene la puntuación de un jugador
func get_player_score(username):
    var http = HTTPRequest.new()
    add_child(http)
    http.connect("request_completed", self, "_on_request_completed")
    
    var request_data = {
        "username": username
    }
    
    var error = http.request(server_url + "/get_score", [], true, HTTPClient.METHOD_POST, to_json(request_data))
    if error != OK:
        print("Error enviando la solicitud: ", error)

# Manejador para cuando se completa la solicitud HTTP
func _on_request_completed(result, response_code, headers, body):
    var json = parse_json(body.get_string_from_utf8())
    if response_code == 200:
        print("Respuesta recibida:", json)
    else:
        print("Error en la solicitud:", response_code, json)