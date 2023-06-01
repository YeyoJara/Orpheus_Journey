extends Sprite2D

@onready var Afrodita_Ani_Play = $Afrodita_Ani_Play
@onready var Zona_Detectar = $Zona_Detectar
@onready var Transicion = $Transicion_Suave/Transicion
@onready var Transicion_Panel = $Transicion_Suave/Panel
@onready var Adagio_Amor = $Adagio_Amor

@export var Contador_Puertas = 0


func _ready():
	
	Afrodita_Ani_Play.play("Inactiva")
	Transicion_Panel.visible = false
	
	
func _process(_delta):
	
	var Orfeo = Zona_Detectar.Individuo
	if Orfeo != null:
		if Globales.Adagio_Amor == true:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiente"), -80)
			Globales.Curar = false
			Afrodita_Ani_Play.play("Detecta_Orfeo")
			if Input.is_action_just_pressed("ui_play"):
				Orfeo_Estadisticas.Contador_Puertas = Contador_Puertas
				Orfeo_Estadisticas.Vida = Orfeo_Estadisticas.Vida_Maxima
				Orfeo_Estadisticas.Reutilizables = Orfeo_Estadisticas.Reutilizables_Maximos
				Guardado.Guardar_Datos()
				Globales.Puerta_Secreta = 0
				Transicion_Panel.visible = true
				Transicion.play("Transicion")
	else:
		Afrodita_Ani_Play.play("Inactiva")
		Adagio_Amor.stop()
		
		
func Recargar_Escena():
	
	get_tree().reload_current_scene()
