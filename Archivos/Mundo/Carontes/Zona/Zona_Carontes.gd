extends Node2D


@onready var Orfeo = $Elementos/Orfeo
@onready var Zona_Secreta = $Tiles/Pasto_Tierra_Camino
@onready var Particulas_Secretas = $Limite/Acceso_Silbila_Cumas/Zona_Secreta
@onready var Pergamino = $Elementos/Pergamino
@onready var Colision_Pergamino = $Elementos/Pergamino/Pergamino/Zona_Detectar/CollisionShape2D
@onready var Colision_Tragedia = $Elementos/Pergamino/Pergamino/Area2D/CollisionShape2D
@onready var Transicion_Suave = $Transicion_Suave
@onready var Transicion = $Transicion_Suave/Transicion
@onready var Cancion = $Felice_io_me_nandro


func _ready():
	
	
	Transicion.play("Iniciar_Escena")
	Globales.Puerta_Secreta = 0
	
############################ Guardado ###############################
	if Orfeo_Estadisticas.Contador_Puertas == -1:
		Orfeo.position.x = -830
		Orfeo.position.y = -70
########################## Cambio Escena #############################
	if Orfeo_Estadisticas.Contador_Puertas == 0:
		Orfeo.position.x = 600
		Orfeo.position.y = 300
	elif Orfeo_Estadisticas.Contador_Puertas == 1:
		Orfeo.position.x = -350
		Orfeo.position.y = 300
	elif Orfeo_Estadisticas.Contador_Puertas == 2:
		Orfeo.position.x = 0
		Orfeo.position.y = -450
		
		
func _process(_delta):
	
	if Globales.Puerta_Secreta == 2:
		Zona_Secreta.set_layer_enabled(4, false)
		Particulas_Secretas.visible = true
	else:
		Zona_Secreta.set_layer_enabled(4, true)
		Particulas_Secretas.visible = false
		
	if Globales.Tragedia_Carontes == true:
		Pergamino.visible = false
		Colision_Pergamino.disabled = true
		Colision_Tragedia.disabled = true
		
		
func _on_acceso_arena_body_entered(_body):
	Transicion_Suave.Escena = "res://Archivos/Mundo/Carontes/Arena/Arena_Carontes.tscn"
	Transicion.play("Transicion")


func _on_acceso_sibila_cumas_body_entered(_body):
	Transicion_Suave.Escena = "res://Archivos/Mundo/Zona_Sibila_Cumas/Zona_Sibila_Cumas.tscn"
	Transicion.play("Transicion")


func _on_musica_timeout():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiente"), Globales.Musica_Fondo)
