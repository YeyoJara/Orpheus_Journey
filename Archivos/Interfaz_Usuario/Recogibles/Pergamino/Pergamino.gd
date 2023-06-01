extends AnimatedSprite2D


@onready var Colision = $Area2D/CollisionShape2D
@onready var Zona_Detectar = $Zona_Detectar
@onready var Activar_Area = $Activar_Area
@onready var Aletheia = $Aletehia

@export var Contador = 1


@export var Texto = "PT_2"

const Tragedia = preload("res://Archivos/Interfaz_Usuario/Menus/Menu_Inventario/Tragedia/Tragedia.tscn")

func _ready():
	
	Colision.disabled = true
	self.visible = false
	
func _process(_delta):
	
	if Globales.Aletheia == true:
		var Orfeo = Zona_Detectar.Individuo
		if Orfeo != null:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiente"), -80)
			Globales.Curar = false
			if Input.is_action_just_pressed("ui_play"):
				Activar_Area.start()
				self.visible = true
				Aletheia.play()
	else:
		self.visible = false

func _on_area_2d_body_entered(_body):
	Globales.Tragedia = Contador
	Globales.Texto = Texto
	if Globales.Texto == Texto:
		var Tragedia_Orfeo = Tragedia.instantiate()
		get_parent().call_deferred("add_child", Tragedia_Orfeo)

func _on_activar_area_timeout():
	Colision.disabled = false
