extends Node

var tcp_connection: StreamPeerTCP
var status: int = 0

var connected = false

var packets = {
	"MESSAGE": 0x04
}

var messages = {
	"LIST_LOBBIES": 0x03
}

var PACKET_END = 0xAA

func connect_to_server(host: String, port: int) -> bool:
	tcp_connection = StreamPeerTCP.new()
	
	status = tcp_connection.STATUS_NONE
	
	var error = tcp_connection.connect_to_host(host, port)

	if error != OK:
		print(error)
		
		tcp_connection = null
		
		return false
	
	print("Connecting to ", host, ":", port)
	
	return true
	
func send_list_lobbies() -> void:
	var message = PackedByteArray([packets["MESSAGE"], messages["LIST_LOBBIES"], PACKET_END])
	
	var error = tcp_connection.put_data(message)

	if error != OK:
		print("Error: ", error_string(error))

func get_list_lobbies() -> void:
	pass

func status_logger() -> void:
	pass

func _process(delta: float) -> void:
	tcp_connection.poll()
	var new_status: int = tcp_connection.get_status()

	if (status != new_status):
		status = new_status
		
		if (status == tcp_connection.STATUS_CONNECTED):
			print("Connected!")
			
			connected = true
			
		if (status == tcp_connection.STATUS_CONNECTING):
			print("Connecting...")
			
		if (status == tcp_connection.STATUS_ERROR):
			print("Error!")
	
	if not connected:
		return
	
	var available_bytes: int = tcp_connection.get_available_bytes()
	
	if available_bytes > 0:
		var data: Array = tcp_connection.get_partial_data(available_bytes)
		var error = data[0]
		var bytes = data[1]
		
		if (error != OK):
			
			return
		
		print(bytes)
