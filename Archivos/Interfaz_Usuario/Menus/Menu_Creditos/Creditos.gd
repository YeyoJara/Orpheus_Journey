extends CanvasLayer

var Menu_Inicio = false
var Creditos_Finales = false

@onready var Creditos = $Creditos
@onready var Agradecimientos = $Agradecimientos
@onready var Creditos_Ani_Play = $Creditos_Ani_Play
@onready var Fondo_Negro = $Fondo_Negro


func _ready():
	
	get_tree().paused = true
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Menu_Inicio == true:
			get_tree().paused = false
			queue_free()
		else:
			get_tree().paused = false
			get_tree().change_scene_to_file("res://Archivos/Interfaz_Usuario/Menus/Menu_Principal/Menu_Inicio.tscn")
			queue_free()
			
	if Creditos_Finales == true:
		Creditos_Ani_Play.play("Agradecimiento")
		Fondo_Negro.visible = true
	else:
		Creditos.visible = true
		Agradecimientos.visible = false
		Fondo_Negro.visible = false
		
		
func Menu_Principal():
	get_tree().change_scene_to_file("res://Archivos/Interfaz_Usuario/Menus/Menu_Principal/Menu_Inicio.tscn")
	queue_free()

