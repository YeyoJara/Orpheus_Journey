extends CanvasLayer


var Escena = "res://Archivos/Mundo/Carontes/Zona/Zona_Carontes.tscn"
@onready var Transicion_Panel = $Panel
@onready var Intro = $Intro


func _ready():
	
	Intro.visible = false
	Transicion_Panel.visible = false

func Cambiar_Escena():
	
	get_tree().change_scene_to_file(Escena)
	
	
func Panel_Visibile():
	
	Transicion_Panel.visible = true
