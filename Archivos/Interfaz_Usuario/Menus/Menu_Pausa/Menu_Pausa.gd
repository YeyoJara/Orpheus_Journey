extends Control

var Pausa = false

@onready var Boton_Continuar = $CanvasLayer/Continuar 

const Menu_Opciones = preload("res://Archivos/Interfaz_Usuario/Menus/Menu_Opciones/Menu_Opciones.tscn")
const Menu_Inventario = preload("res://Archivos/Interfaz_Usuario/Menus/Menu_Inventario/Inventario.tscn")
const Libro_Manual = preload("res://Archivos/Interfaz_Usuario/Manual/Manual.tscn")

	
	
func _ready():
	
	get_tree().paused = true
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	Boton_Continuar.grab_focus()
	
func _process(_delta): 
	
	get_tree().paused = true
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	
	if Pausa == false:
		Boton_Continuar.grab_focus()
		Pausa = true
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = false
		queue_free()
		
		
func _on_continuar_button_down():
	get_tree().paused = false
	queue_free()


func _on_inventario_button_down():
	var Inventario = Menu_Inventario.instantiate()
	get_parent().call_deferred("add_child", Inventario)
	Inventario.global_position = global_position
	self.process_mode = Node.PROCESS_MODE_INHERIT
	Pausa = false
	
	
func _on_opciones_button_down():
	var Opciones = Menu_Opciones.instantiate()
	get_parent().call_deferred("add_child", Opciones)
	Opciones.global_position = global_position
	self.process_mode = Node.PROCESS_MODE_INHERIT
	Pausa = false
	
	
func _on_manual_button_down():
	var Manual = Libro_Manual.instantiate()
	get_parent().call_deferred("add_child", Manual)
	Manual.global_position = global_position
	self.process_mode = Node.PROCESS_MODE_INHERIT
	Pausa = false
	
	
func _on_menu_principal_button_down():
	get_tree().change_scene_to_file("res://Archivos/Interfaz_Usuario/Menus/Menu_Principal/Menu_Inicio.tscn")
	get_tree().paused = false
	queue_free()
	
	
func _on_salir_button_down():
	get_tree().quit()
