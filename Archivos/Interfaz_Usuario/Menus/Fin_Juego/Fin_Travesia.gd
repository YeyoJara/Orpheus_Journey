extends Control

@onready var Boton_Continuar = $CanvasLayer/Continuar
@onready var Boton_Menu_Principal = $CanvasLayer/Menu_Principal
@onready var Transicion_Suave = $Transicion_Suave
@onready var Transicion = $Transicion_Suave/Transicion

func _ready():
	
	Boton_Menu_Principal.visible = true
	
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
	if FileAccess.file_exists("savefile.json"):
		Boton_Continuar.visible = true
		Boton_Continuar.grab_focus()
	else:
		Boton_Continuar.visible = false
		Boton_Menu_Principal.grab_focus()
		
		
func _on_continuar_button_down():
	Guardado.Cargar_Datos()
	Orfeo_Estadisticas.Asignar_Valores()
	Transicion_Suave.Escena = Orfeo_Estadisticas.Escena
	Transicion.play("Transicion")
	get_tree().paused = false

func _on_menu_principal_button_down():
	get_tree().change_scene_to_file("res://Archivos/Interfaz_Usuario/Menus/Menu_Principal/Menu_Inicio.tscn")
	get_tree().paused = false
	queue_free()
