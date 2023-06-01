extends Control

@onready var Fondo = $CanvasLayer/Fondo
@onready var Descripcion = $CanvasLayer/Descripcion
@onready var Descripcion_Texto = $CanvasLayer/Texto

@onready var Boton_Canciones = $CanvasLayer/Canciones
@onready var Lista_Canciones = $CanvasLayer/Canciones/Lista_Canciones
@onready var Adagio_Amor = $CanvasLayer/Canciones/Lista_Canciones/Adagio_Amor
@onready var Aletheia = $CanvasLayer/Canciones/Lista_Canciones/Aletheia
@onready var Aria_Hermes = $CanvasLayer/Canciones/Lista_Canciones/Aria_Hermes
@onready var Preludio = $CanvasLayer/Canciones/Lista_Canciones/Preludio
@onready var Recuerdo_Euridice = $CanvasLayer/Canciones/Lista_Canciones/Recuerdo_Euridice


@onready var Tragedia = $CanvasLayer/Tragedia
@onready var Lista_Tragedia = $CanvasLayer/Tragedia/Lista_Tragedia
@onready var Carontes = $CanvasLayer/Tragedia/Lista_Tragedia/Carontes
@onready var Apolo_Caliope = $CanvasLayer/Tragedia/Lista_Tragedia/Apolo_Caliope

@onready var Items = $CanvasLayer/Items
@onready var Lista_Items = $CanvasLayer/Items/Lista_Items
@onready var Rama_Dorada = $CanvasLayer/Items/Lista_Items/Rama_Dorada
@onready var Rama_Dorada_Textura = $CanvasLayer/Items/Lista_Items/Rama_Dorada/Rama_Dorada

const Historia = preload("res://Archivos/Interfaz_Usuario/Menus/Menu_Inventario/Tragedia/Tragedia.tscn")

func _ready():
	
	get_tree().paused = true
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	Boton_Canciones.grab_focus()
	
	Fondo.frame = 0
	Lista_Canciones.visible = true
	Descripcion.visible = false
	Lista_Tragedia.visible = false
	Lista_Items.visible = false
	
	if Globales.Aria_Hermes == true:
		Aria_Hermes.text = "CC_3"
	else:
		Aria_Hermes.disabled = true
		
	if Globales.Adagio_Amor == true:
		Adagio_Amor.text = "CC_5"
	else:
		Adagio_Amor.disabled = true
		
	if Globales.Preludio == true:
		Preludio.text = "CC_7"
	else:
		Preludio.disabled = true
		
	if Globales.Aletheia == true:
		Aletheia.text = "CC_9"
	else:
		Aletheia.disabled = true
		
	if Globales.Tragedia_Carontes == true:
		Carontes.text = "PT_1"
	else:
		Carontes.disabled = true
		
	if Globales.Tragedia_Apolo_Caliope == true:
		Apolo_Caliope.text = "PT_3"
	else:
		Apolo_Caliope.disabled = true
		
		
	if Globales.Rama_Dorara == true:
		Rama_Dorada_Textura.visible = true
	else:
		Rama_Dorada_Textura.visible = false
		Rama_Dorada.disabled = true
		
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
		get_tree().paused = false
		
	if Lista_Canciones.visible == true:
		Adagio_Amor.focus_mode = 2
		Aletheia.focus_mode = 2
		Aria_Hermes.focus_mode = 2
		Preludio.focus_mode = 2
		Recuerdo_Euridice.focus_mode = 2
	else:
		Adagio_Amor.focus_mode = 0
		Aletheia.focus_mode = 0
		Aria_Hermes.focus_mode = 0
		Preludio.focus_mode = 0
		Recuerdo_Euridice.focus_mode = 0
		
	if Lista_Tragedia.visible == true:
		Carontes.focus_mode =2
		Apolo_Caliope.focus_mode = 2
	else:
		Carontes.focus_mode = 0
		Apolo_Caliope.focus_mode = 0
		
	if Lista_Items.visible == true:
		Rama_Dorada.focus_mode = 2
	else:
		Rama_Dorada.focus_mode = 0
		
		
func _on_canciones_button_down():
	Descripcion.visible = false
	Descripcion_Texto.visible = false
	Fondo.frame = 0
	Lista_Canciones.visible = true
	Lista_Tragedia.visible = false
	Lista_Items.visible = false
	
	
func _on_adagio_amor_button_down():
	Descripcion.visible = true
	Descripcion_Texto.visible = true
	Descripcion_Texto.text = "CC_6"
	
func _on_aletheia_button_down():
	Descripcion.visible = true
	Descripcion_Texto.visible = true
	Descripcion_Texto.text = "CC_10"
	
	
func _on_aria_hermes_button_down():
	Descripcion.visible = true
	Descripcion_Texto.visible = true
	Descripcion_Texto.text = "CC_4"
	
	
func _on_preludio_button_down():
	Descripcion.visible = true
	Descripcion_Texto.visible = true
	Descripcion_Texto.text = "CC_8"
	
	
func _on_recuerdo_euridice_button_down():
	Descripcion.visible = true
	Descripcion_Texto.visible = true
	Descripcion_Texto.text = "CC_2"
	
	
func _on_tragedia_button_down():
	Descripcion.visible = false
	Descripcion_Texto.visible = false
	Fondo.frame = 1
	Lista_Canciones.visible = false
	Lista_Tragedia.visible = true
	Lista_Items.visible = false


func _on_carontes_button_down():
	Globales.Texto = "PT_2"
	if Globales.Texto == "PT_2":
		var Tragedia_Orfeo = Historia.instantiate()
		get_parent().call_deferred("add_child", Tragedia_Orfeo)
		
		
func _on_apolo_caliope_button_down():
	Globales.Texto = "PT_4"
	if Globales.Texto == "PT_4":
		var Tragedia_Orfeo = Historia.instantiate()
		get_parent().call_deferred("add_child", Tragedia_Orfeo)
	
	
func _on_items_button_down():
	Descripcion.visible = false
	Descripcion_Texto.visible = false
	Fondo.frame = 2
	Lista_Canciones.visible = false
	Lista_Tragedia.visible = false
	Lista_Items.visible = true


func _on_rama_dorada_button_down():
	Descripcion.visible = true
	Descripcion_Texto.visible = true
	Descripcion_Texto.text = "LA_1"
