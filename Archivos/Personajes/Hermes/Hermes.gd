extends Sprite2D


@onready var Hermes_Ani_Play = $Hermes_Ani_Play
@onready var Zona_Detectar = $Zona_Detectar
@onready var Pentagrama = $Pentagrama
@onready var Aria_Hermes = $Aria_Hermes

@export var Dialogo_1 = "DH_1"

var Comprar = false

const Tienda = preload("res://Archivos/Interfaz_Usuario/Menus/Menu_Tienda/Menu_Tienda.tscn")
const Dialogos = preload("res://Archivos/Interfaz_Usuario/Dialogos/Dialogos.tscn")

func _ready():
	
	Hermes_Ani_Play.play("Inactivo")
	Pentagrama.visible = false
	
	
func _process(_delta):
	
	var Orfeo = Zona_Detectar.Individuo
	if Orfeo != null:
		Globales.Curar = false
		if Globales.Aria_Hermes == true:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiente"), -80)
			Hermes_Ani_Play.play("DO_Aria_Hermes")
		else:
			Hermes_Ani_Play.play("Detecta_Orfeo")
		if Input.is_action_just_pressed("ui_play"):
			Comprar = true
			self.process_mode = Node.PROCESS_MODE_ALWAYS
			if Globales.Dialogo_Hermes_1 == true:
				var Dialogo = Dialogos.instantiate()
				Dialogo.Personaje = "NP_3"
				Dialogo.Dialogo_1 = Dialogo_1
				call_deferred("add_child", Dialogo)
			else:
				var Dialogo = Dialogos.instantiate()
				Dialogo.Personaje = "NP_3"
				Dialogo.Dialogo_1 = "DH_2"
				call_deferred("add_child", Dialogo)
		if Comprar == true:
			if Input.is_action_just_pressed("ui_cancel"):
				Globales.Dialogo_Hermes_1 = false
				var Menu_Tienda = Tienda.instantiate()
				get_parent().call_deferred("add_child", Menu_Tienda)
				Menu_Tienda.global_position = global_position
				Comprar = false
				self.process_mode = Node.PROCESS_MODE_INHERIT
		if Globales.Aria_Hermes == true:
			Pentagrama.visible = true
		else:
			Pentagrama.visible = false
	else:
		Hermes_Ani_Play.play("Inactivo")
		Pentagrama.visible = false
		Aria_Hermes.stop()
