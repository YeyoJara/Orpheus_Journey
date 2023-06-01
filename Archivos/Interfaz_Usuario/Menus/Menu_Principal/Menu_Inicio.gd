extends Control


@onready var Menu_Inicio_Ani_Play = $Menu_Inicio_Ani_play
@onready var Menu_Principal = $Menu_Principal
@onready var Boton_Continuar = $Menu_Principal/Continuar
@onready var Transicion_Suave = $Transicion_Suave
@onready var Transicion = $Transicion_Suave/Transicion
@onready var Partir = $Menu_Principal/Partir
@onready var Salir = $Menu_Principal/Salir
@onready var LEuridice = $LEuridice

const Menu_Opciones = preload("res://Archivos/Interfaz_Usuario/Menus/Menu_Opciones/Menu_Opciones.tscn")
const  Manual = preload("res://Archivos/Interfaz_Usuario/Manual/Manual.tscn")
const  Menu_Creditos = preload("res://Archivos/Interfaz_Usuario/Menus/Menu_Creditos/Creditos.tscn")


func _ready():
	
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	
	Transicion_Suave.visible = true
	Transicion_Suave.Transicion_Panel.visible = false
	
	var Opciones = Menu_Opciones.instantiate()
	get_parent().call_deferred("add_child", Opciones)
	Opciones.queue_free()
	Menu_Inicio_Ani_Play.play("Aviso_Inicio")
	Menu_Principal.visible = false
	
	Partir.grab_focus()
	
	
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
			Partir.grab_focus()
			
			
func Iniciar_Primavera():
	
	Menu_Inicio_Ani_Play.play("Primavera")
	LEuridice.play()
	
	
func Iniciar_Transicion():
	
	Menu_Inicio_Ani_Play.play("Transicion")
	
	
func Iniciar_Otoño():
	
	Menu_Inicio_Ani_Play.play("Otoño")
	
	
func Botones_Visibles():


	Menu_Principal.visible = true
	if FileAccess.file_exists("savefile.json"):
		Boton_Continuar.visible = true
	else:
		Boton_Continuar.visible = false
	
	
func _on_continuar_button_down():
	Guardado.Cargar_Datos()
	Orfeo_Estadisticas.Asignar_Valores()
	Transicion_Suave.Escena = Orfeo_Estadisticas.Escena
	Transicion.play("Transicion")
	get_tree().paused = false
	
func _on_partir_button_down():
	Guardado.Limpiar_Datos()
	Orfeo_Estadisticas.Asignar_Valores()
	Transicion_Suave.Escena = "res://Archivos/Mundo/Carontes/Zona/Zona_Carontes.tscn"
	Transicion.play("Historia_Inicial")
	get_tree().paused = false
	
	
func _on_opciones_button_down():
	var Opciones = Menu_Opciones.instantiate()
	call_deferred("add_child", Opciones)
	Opciones.get_node("CanvasLayer").visible = true
		
		
func _on_manual_button_down():
	var Manuales = Manual.instantiate()
	get_parent().call_deferred("add_child", Manuales)
	
	
func _on_creditos_button_down():
	var Creditos = Menu_Creditos.instantiate()
	Creditos.Menu_Inicio = true
	get_parent().call_deferred("add_child", Creditos)
	
	
func _on_salir_button_down():
	get_tree().quit()


func _on_timer_timeout():
	Partir.grab_focus()
