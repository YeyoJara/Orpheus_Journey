extends Sprite2D


@onready var Sibila_Ani_Play = $Sibila_Ani_Play
@onready var Zona_Detectar = $Zona_Detectar
@onready var Rama_Dorada = $Rama_Dorada
@onready var Fondo = $Panel
@onready var No_Existe = $No_Existe

var Dialogos = preload ("res://Archivos/Interfaz_Usuario/Dialogos/Dialogos.tscn")



func _ready():
	
	
	Sibila_Ani_Play.play("Inactiva")
	Rama_Dorada.visible = false
	Fondo.visible = false
	
func _process(_delta):
	
	if Globales.Rama_Dorara == true and Globales.Rama_Dorada_Item == false:
		Rama_Dorada.visible = true
		Fondo.visible = true
	else:
		Rama_Dorada.visible = false
		Fondo.visible = false
		
		
	var Orfeo = Zona_Detectar.Individuo
	if Orfeo != null:
		if Globales.Dialogo_Sibila == true:
			self.process_mode = Node.PROCESS_MODE_ALWAYS
			var Dialogo = Dialogos.instantiate()
			Dialogo.Personaje = "NP_1"
			Dialogo.Dialogo_1 = "DS_1"
			Dialogo.Dialogo_2 = "DS_2"
			Dialogo.Contador = 1
			call_deferred("add_child", Dialogo)
			Sibila_Ani_Play.play("Detecta_Orfeo")
			Globales.Dialogo_Sibila = false
			Globales.Rama_Dorara = true
			
	else:
		Sibila_Ani_Play.play("Inactiva")
		self.process_mode = Node.PROCESS_MODE_INHERIT
