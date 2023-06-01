extends Control

var Ventana = true

@onready var Fondo = $CanvasLayer/Fondo

@onready var Boton_Generales = $CanvasLayer/Generales
@onready var Menu_Generales = $CanvasLayer/Menu_Generales
@onready var Multiplicador_Lesion = $CanvasLayer/Menu_Generales/Lesion_Recibida/Multiplicador_Lesion
@onready var Opciones_Idioma = $CanvasLayer/Menu_Generales/Idioma/Idioma

@onready var Menu_Video = $CanvasLayer/Menu_Video
@onready var Opciones_Pantalla = $CanvasLayer/Menu_Video/Modo_Pantalla/Opciones_Pantalla
@onready var Opciones_Resolucion = $CanvasLayer/Menu_Video/Resolucion/Opciones_Resolucion

@onready var Menu_Audio = $CanvasLayer/Menu_Audio
@onready var Sonido_Global = $CanvasLayer/Menu_Audio/Sonido_Global/Sonido_Global
@onready var Musica_Fondo = $CanvasLayer/Menu_Audio/Musica_de_Fondo/Musica_de_Fondo
@onready var Efectos_Sonido = $CanvasLayer/Menu_Audio/Efectos_de_Sonido/Efectos_de_Sonido
@onready var Audio_Canciones = $CanvasLayer/Menu_Audio/Canciones/Canciones
@onready var Musica_Menu_Principal = $CanvasLayer/Menu_Audio/Musica_Menu_Principal/Musica_Menu_Principal

@onready var Controles = $CanvasLayer/Controles
@onready var Menu_Controles = $CanvasLayer/Menu_Controles
@onready var Opciones_Control = $CanvasLayer/Menu_Controles/Opciones_Control
@onready var Boton_Teclado = $CanvasLayer/Menu_Controles/Teclado
@onready var Teclado = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map
@onready var Boton_Aceptar = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Izquierda/Aceptar/Boton_Aceptar
@onready var Boton_Abajo = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Izquierda/Abajo/Boton_Abajo
@onready var Boton_Arriba = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Izquierda/Arriba/Boton_Arriba
@onready var Boton_Derecha = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Izquierda/Derecha/Boton_Derecha
@onready var Boton_Izquierda = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Izquierda/Izquierda/Boton_Izquierda
@onready var Boton_Inventario = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Izquierda/Inventario/Boton_Inventario
@onready var Boton_Cancelar = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Derecha/Cancelar/Boton_Cancelar
@onready var Boton_Tocar = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Derecha/Tocar/Boton_Tocar
@onready var Boton_Atacar = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Derecha/Atacar/Boton_Atacar
@onready var Boton_Disparar = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Derecha/Disparar/Boton_Disparar
@onready var Boton_Esquivar = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Derecha/Esquivar/Boton_Esquivar
@onready var Boton_Pausa = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Grupo_Derecha/Pausa/Boton_Pausa
@onready var Boton_Mando = $CanvasLayer/Menu_Controles/Mando
@onready var Mando = $CanvasLayer/Menu_Controles/Mando/ControlMap

@onready var Aceptar = $CanvasLayer/Aceptar
@onready var Reiniciar = $CanvasLayer/Menu_Controles/Teclado/Teclado_Map/Reiniciar


func _ready():
	
	get_tree().paused = true
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	Boton_Generales.grab_focus()
	
	Fondo.frame = 0
	Menu_Generales.visible = true
	Multiplicador_Lesion.value = 1
	Menu_Video.visible = false
	Menu_Audio.visible = false
	Teclado.visible = true
	Menu_Controles.visible = false
	Mando.visible = false
	Aceptar.visible = true
	Reiniciar.visible = false
	
	Globales.Cambiar_Idioma()
	Multiplicador_Lesion.value = Globales.Multplicador_Lesion
	
	Sonido_Global.value = Globales.Sonido_Global
	Musica_Fondo.value = Globales.Musica_Fondo
	Efectos_Sonido.value = Globales.Efectos_Sonido
	Audio_Canciones.value = Globales.Audio_Canciones
	Musica_Menu_Principal.value = Globales.Musica_Menu_Principal
	
func _process(_delta):
	
	if Reiniciar.visible == true:
		Aceptar.visible = false
	else:
		Aceptar.visible = true
		
	if Multiplicador_Lesion.value == 0:
		Orfeo_Estadisticas.Multiplicador_Lesion_Recibida = 0.5
	elif Multiplicador_Lesion.value == 1:
		Orfeo_Estadisticas.Multiplicador_Lesion_Recibida = 1
	elif Multiplicador_Lesion.value == 2:
		Orfeo_Estadisticas.Multiplicador_Lesion_Recibida = 2
		
	Globales.Multplicador_Lesion = Multiplicador_Lesion.value
		
	if Opciones_Pantalla.selected == 2:
		Opciones_Resolucion.select(5)
		get_window().size = Vector2i (1920, 1080)
	elif Opciones_Pantalla.selected == 1:
		Opciones_Resolucion.select(5)
		get_window().size = Vector2i (1920, 1080)
		
	if Opciones_Resolucion.selected == 5 and Ventana == false:
		Opciones_Pantalla.select(1)
		
	if Globales.Idioma == "es":
		Opciones_Idioma.select(0)
	elif Globales.Idioma == "en":
		Opciones_Idioma.select(1)
	elif Globales.Idioma == "fr":
		Opciones_Idioma.select(2)
		
	if Globales.Pantalla == Window.MODE_WINDOWED:
		Opciones_Pantalla.select(0)
	elif Globales.Pantalla == Window.MODE_FULLSCREEN:
		Opciones_Pantalla.select(1)
	elif Globales.Pantalla == Window.MODE_EXCLUSIVE_FULLSCREEN:
		Opciones_Pantalla.select(2)
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = false
		queue_free()
		
	if Menu_Generales.visible == true:
		Multiplicador_Lesion.focus_mode = 2
		Opciones_Idioma.focus_mode = 2
	else:
		Multiplicador_Lesion.focus_mode = 0
		Opciones_Idioma.focus_mode = 0
		
	if Menu_Video.visible == true:
		Opciones_Pantalla.focus_mode = 2
		Opciones_Resolucion.focus_mode = 2
	else:
		Opciones_Pantalla.focus_mode = 0
		Opciones_Resolucion.focus_mode = 0
		
	if Menu_Audio.visible == true:
		Sonido_Global.focus_mode = 2
		Musica_Fondo.focus_mode = 2
		Efectos_Sonido.focus_mode = 2
		Audio_Canciones.focus_mode = 2
		Musica_Menu_Principal.focus_mode = 2
	else:
		Sonido_Global.focus_mode = 0
		Musica_Fondo.focus_mode = 0
		Efectos_Sonido.focus_mode = 0
		Audio_Canciones.focus_mode = 0
		Musica_Menu_Principal.focus_mode = 0
		
	if Menu_Audio.visible == true:
		pass
		
	if Menu_Controles.visible == true:
		if Teclado.visible == true:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			Boton_Teclado.focus_mode = 2
			Boton_Mando.focus_mode = 2
			Boton_Aceptar.focus_mode = 1
			Boton_Abajo.focus_mode = 1
			Boton_Arriba.focus_mode = 1
			Boton_Derecha.focus_mode = 1
			Boton_Izquierda.focus_mode = 1
			Boton_Inventario.focus_mode = 1
			Boton_Cancelar.focus_mode = 1
			Boton_Tocar.focus_mode = 1
			Boton_Atacar.focus_mode = 1
			Boton_Disparar.focus_mode = 1
			Boton_Esquivar.focus_mode = 1
			Boton_Pausa.focus_mode = 1
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			Boton_Aceptar.focus_mode = 0
			Boton_Abajo.focus_mode = 0
			Boton_Arriba.focus_mode = 0
			Boton_Derecha.focus_mode = 0
			Boton_Izquierda.focus_mode = 0
			Boton_Inventario.focus_mode = 0
			Boton_Cancelar.focus_mode = 0
			Boton_Tocar.focus_mode = 0
			Boton_Atacar.focus_mode = 0
			Boton_Disparar.focus_mode = 0
			Boton_Esquivar.focus_mode = 0
			Boton_Pausa.focus_mode = 0
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		Boton_Teclado.focus_mode = 0
		Boton_Mando.focus_mode = 0
		Boton_Aceptar.focus_mode = 0
		Boton_Abajo.focus_mode = 0
		Boton_Arriba.focus_mode = 0
		Boton_Derecha.focus_mode = 0
		Boton_Izquierda.focus_mode = 0
		Boton_Inventario.focus_mode = 0
		Boton_Cancelar.focus_mode = 0
		Boton_Tocar.focus_mode = 0
		Boton_Atacar.focus_mode = 0
		Boton_Disparar.focus_mode = 0
		Boton_Esquivar.focus_mode = 0
		Boton_Pausa.focus_mode = 0
		
func _on_generales_button_down():
	Reiniciar.visible = false
	Fondo.frame = 0
	Menu_Generales.visible = true
	Menu_Video.visible = false
	Menu_Audio.visible = false
	Menu_Controles.visible = false
	
	
func _on_idioma_item_selected(index):
	var Idioma = index
	
	if Idioma == 0:
		Globales.Idioma = "es"
		Globales.Cambiar_Idioma()
	elif  Idioma == 1:
		Globales.Idioma = "en"
		Globales.Cambiar_Idioma()
	elif Idioma == 2:
		Globales.Idioma = "fr"
		Globales.Cambiar_Idioma()
	
	
func _on_video_button_down():
	Reiniciar.visible = false
	Fondo.frame = 1
	Menu_Generales.visible = false
	Menu_Video.visible = true
	Menu_Audio.visible = false
	Menu_Controles.visible = false
	
	
func _on_opciones_pantalla_item_selected(index):
	var Modo_Patalla = index

	if Modo_Patalla == 0:
		Globales.Pantalla = Window.MODE_WINDOWED
		Globales.Cambiar_Pantalla()
		Ventana = true
	if Modo_Patalla == 1:
		Globales.Pantalla = Window.MODE_FULLSCREEN
		Globales.Cambiar_Pantalla()
	if Modo_Patalla == 2:
		Globales.Pantalla = Window.MODE_EXCLUSIVE_FULLSCREEN
		Globales.Cambiar_Pantalla()
	
	
func _on_opciones_resolucion_item_selected(index):
	var Resolucion_Actual = index
	
	if Resolucion_Actual == 0:
		Globales.Resolucion = Vector2i (320, 180)
		Globales.Cambiar_Resolucion()
	if Resolucion_Actual == 1:
		Globales.Resolucion = Vector2i (640, 360)
		Globales.Cambiar_Resolucion()
	if Resolucion_Actual == 2:
		Globales.Resolucion = Vector2i (960, 540)
		Globales.Cambiar_Resolucion()
	if Resolucion_Actual == 3:
		Globales.Resolucion = Vector2i (1280, 720)
		Globales.Cambiar_Resolucion()
	if Resolucion_Actual == 4:
		Globales.Resolucion = Vector2i (1600, 900)
		Globales.Cambiar_Resolucion()
	if Resolucion_Actual == 5:
		Globales.Pantalla = Window.MODE_FULLSCREEN
		Globales.Cambiar_Pantalla()
		Opciones_Pantalla.select(1)
		Ventana = false
		
		
func _on_audio_button_down():
	Reiniciar.visible = false
	Fondo.frame = 2
	Menu_Generales.visible = false
	Menu_Video.visible = false
	Menu_Audio.visible = true
	Menu_Controles.visible = false
	
	
func _on_sonido_global_value_changed(value):
	Globales.Sonido_Global = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	
	
func _on_musica_de_fondo_value_changed(value):
	Globales.Musica_Fondo = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiente"), value)
	
	
func _on_efectos_de_sonido_value_changed(value):
	Globales.Efectos_Sonido = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Efectos"), value)
	
	
func _on_canciones_value_changed(value):
	Globales.Audio_Canciones = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Canciones"), value)
	
	
func _on_musica_menu_principal_value_changed(value):
	Globales.Musica_Menu_Principal = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Inicio"), value)
	
	
func _on_controles_button_down():
	Reiniciar.visible = true
	Fondo.frame = 3
	Menu_Generales.visible = false
	Menu_Video.visible = false
	Menu_Audio.visible = false
	Menu_Controles.visible = true
	Opciones_Control.frame = 0
	Teclado.visible = true
	Mando.visible = false
	
	
func _on_teclado_button_down():
	Opciones_Control.frame = 0
	Teclado.visible = true
	Mando.visible = false


func _on_mando_button_down():
	Opciones_Control.frame = 1
	Teclado.visible = false
	Mando.visible = true


func _on_reiniciar_button_down():
	Boton_Aceptar.Reiniciar_Valores_Entrada()
	Boton_Abajo.Reiniciar_Valores_Entrada()
	Boton_Arriba.Reiniciar_Valores_Entrada()
	Boton_Derecha.Reiniciar_Valores_Entrada()
	Boton_Izquierda.Reiniciar_Valores_Entrada()
	Boton_Inventario.Reiniciar_Valores_Entrada()
	Boton_Cancelar.Reiniciar_Valores_Entrada()
	Boton_Tocar.Reiniciar_Valores_Entrada()
	Boton_Atacar.Reiniciar_Valores_Entrada()
	Boton_Disparar.Reiniciar_Valores_Entrada()
	Boton_Esquivar.Reiniciar_Valores_Entrada()
	Boton_Pausa.Reiniciar_Valores_Entrada()
	
	
func _on_aceptar_button_down():
	Preferencias.Guardar_Configuracion()
