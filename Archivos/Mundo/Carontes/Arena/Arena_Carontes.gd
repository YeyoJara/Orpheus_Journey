extends Node2D

var Mundo_2 = false

@onready var Arena_Ani_Play = $Arena_Ani_Play
@onready var Colision_Detectar = $Area2D/Zona_Detectar/CollisionShape2D
@onready var Acceso = $Colisiones/Limites/Acceso
@onready var Transicion_Suave = $Transicion_Suave
@onready var Transicion = $Transicion_Suave/Transicion
@onready var Bordes = $Bordes
@onready var Bordes_Ani_Play = $Bordes/Bordes_Ani_Play
@onready var Fuego = $Fuego
@onready var Rio = $Colisiones/Limites/Arriba
@onready var Cueva = $Colisiones/Cueva/CollisionPolygon2D
@onready var Pantalla_Negra = $Pantalla_Negra
@onready var Pantall_Negra_Ani_Play = $Pantalla_Negra/Pantalla_Negra
@onready var Barca = $Elementos/Barca/Barca
@onready var Tapa = $Elementos/Barca/Tapa
@onready var Rampa = $Elementos/Barca/Rampa
@onready var Creditos_Temporizador = $Creditos

@onready var Carontes = $Elementos/Carontes
@onready var Caronte_Ani_Play = $Elementos/Carontes/Caronte_Ani_Play
@onready var Caronte_Rama_Dorada = $Elementos/Carontes/Rama_Dorada
@onready var Caronte_Pentagrama = $Elementos/Carontes/Pentagrama

@onready var Orfeo = $Elementos/Orfeo
@onready var Orfeo_Ani_Play = $Elementos/Orfeo/Orfeo_Ani_Player

const  Menu_Creditos = preload("res://Archivos/Interfaz_Usuario/Menus/Menu_Creditos/Creditos.tscn")


func _ready():
	
	Transicion.play("Iniciar_Escena")
	Arena_Ani_Play.play("Nubes_Yeyo")
	Tapa.visible = false
	Bordes.visible = false
	Fuego.visible = false
	Pantalla_Negra.visible = false
	
	Orfeo.position = Vector2(145,145)
	Carontes.position = Vector2(107, 85)
	Rampa.position = Vector2(-50,1)
	
	
func _process(_delta):
	
	
	if Globales.Salir_Arena == 0:
		Colision_Detectar.disabled = false
		Acceso.disabled = true
	else:
		Colision_Detectar.disabled = true
		Acceso.disabled = false
		
	if Mundo_2 == false:
		if Globales.Ir_Mundo_2 == true:
			Pantalla_Negra.visible = true
			Pantall_Negra_Ani_Play.play("Oscuro")
			Orfeo_Ani_Play.play("Inactivo")
			Caronte_Ani_Play.play("Inactivo")
			Mundo_2 = true
		
		
func Nubes ():
	
	Arena_Ani_Play.play("Nubes")
	
	
func Cinematica():
	Globales.Matar_Enemigos = true
	Creditos_Temporizador.start()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiente"), -80)
	Bordes.visible = true
	Rio.disabled = true
	Cueva.disabled = true
	Fuego.visible = true
	Tapa.visible = true
	Orfeo.Velocidad = 0
	var Bote = Barca.create_tween()
	Bote.tween_property(Barca, "position", Vector2(-50,0), 0)
	Bote.tween_property(Barca, "position", Vector2(75,-11), 8)
	var Lateral = Barca.create_tween()
	Lateral.tween_property(Tapa, "position", Vector2(-50,0), 0)
	Lateral.tween_property(Tapa, "position", Vector2(75,-11), 8)
	var Caronte = Carontes.create_tween()
	Caronte.tween_property(Carontes, "position", Vector2(124, 70), 0)
	Caronte.tween_property(Carontes, "position", Vector2(248,60), 8)
	var Orfeos = Orfeo.create_tween()
	Orfeos.tween_property(Orfeo, "position", Vector2(80,70), 0)
	Orfeos.tween_property(Orfeo, "position", Vector2(204,60), 8)
	var Vela = Fuego.create_tween()
	Vela.tween_property(Fuego, "position", Vector2(138, 62), 0)
	Vela.tween_property(Fuego, "position", Vector2(262, 52), 8)
	Bordes_Ani_Play.play("Abrir")
	if Globales.Rama_Dorara == false:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiente"), Globales.Musica_Fondo)
	
	
func _on_zona_detectar_body_entered(_body):
	Transicion_Suave.Escena = "res://Archivos/Mundo/Carontes/Zona/Zona_Carontes.tscn"
	Transicion.play("Transicion")
	Orfeo_Estadisticas.Contador_Puertas = 2


func _on_creditos_timeout():
	Bordes.visible = false
	var Creditos = Menu_Creditos.instantiate()
	Creditos.Creditos_Finales = true
	get_parent().call_deferred("add_child", Creditos)
