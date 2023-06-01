extends Node


var Mapas_Entrada: Dictionary

const  Ruta_Mapa_Entrada = "keymaps.dat"


func _ready() -> void:
	
	Crear_Mapas_Entrada()
	
	
func Crear_Mapas_Entrada() -> void:
	
	for accion in InputMap.get_actions():
		if InputMap.action_get_events(accion).size() != 0:
			Mapas_Entrada[accion] = InputMap.action_get_events(accion)[0]
	Cargar_Mapas_Entrada()
	
	
func Cargar_Mapas_Entrada() -> void:
	
	if not FileAccess.file_exists(Ruta_Mapa_Entrada):
		Guardar_Mapa_Entrada()
		return
	var Archivo = FileAccess.open(Ruta_Mapa_Entrada, FileAccess.READ)
	var Mapa_Entrada_Temporal = Archivo.get_var(true) as Dictionary
	Archivo.close()
	for accion in  Mapas_Entrada.keys():
		if Mapa_Entrada_Temporal.has(accion):
			Mapas_Entrada[accion] = Mapa_Entrada_Temporal[accion]
			InputMap.action_erase_events(accion)
			InputMap.action_add_event(accion, Mapas_Entrada[accion])
	
	
func Guardar_Mapa_Entrada() -> void:
	
	var Archivo := FileAccess.open(Ruta_Mapa_Entrada, FileAccess.WRITE)
	Archivo.store_var(Mapas_Entrada, true)
	Archivo.close()
