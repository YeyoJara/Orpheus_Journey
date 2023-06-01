extends Control

var Contador = 6

@onready var Pagina_1 = $CanvasLayer/Pagina_1
@onready var Pagina_2 = $CanvasLayer/Pagina_2
@onready var Pagina_3 = $CanvasLayer/Pagina_3
@onready var Pagina_4 = $CanvasLayer/Pagina_4
@onready var Pagina_5 = $CanvasLayer/Pagina_5
@onready var Pagina_6 = $CanvasLayer/Pagina_6
@onready var Pagina_7 = $CanvasLayer/Pagina_7
@onready var Canciones = $CanvasLayer/Pagina_4/Canciones/Canciones
@onready var Tragedia = $CanvasLayer/Pagina_5/Tragedia/Tragedia
@onready var Articulos = $CanvasLayer/Pagina_5/Articulos/Articulos
@onready var Anterior = $CanvasLayer/Anterior
@onready var Siguiente = $CanvasLayer/Siguiente

func _ready():
	
	get_tree().paused = true
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	
	Pagina_1.visible = true
	Pagina_2.visible = false
	Pagina_3.visible = false
	Pagina_4.visible = false
	Pagina_5.visible = false
	Pagina_6.visible = false


func _process(_delta):
	
	if Globales.Idioma == "es":
		Canciones.frame = 0
		Tragedia.frame = 0
		Articulos.frame = 0
	elif Globales.Idioma == "fr":
		Canciones.frame = 1
		Tragedia.frame = 1
		Articulos.frame = 1
	elif Globales.Idioma == "fr":
		Canciones.frame = 2
		Tragedia.frame = 2
		Articulos.frame = 2
		
	Contador = clampi(Contador,0, 7)
	
	if Contador <= 5:
		Anterior.visible = true
	else:
		Anterior.visible = false
		
	if Contador >= 1:
		Siguiente.visible = true
	else:
		Siguiente.visible = false
		
	if Input.is_action_just_pressed("ui_right"):
		Contador -= 1
	elif Input.is_action_just_pressed("ui_left"):
		Contador += 1
	elif Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = false
		queue_free()
		
	if Contador == 6:
		Pagina_1.visible = true
		Pagina_2.visible = false
		Pagina_3.visible = false
		Pagina_4.visible = false
		Pagina_5.visible = false
		Pagina_6.visible = false
		Pagina_7.visible = false
	elif Contador == 5:
		Pagina_1.visible = false
		Pagina_2.visible = true
		Pagina_3.visible = false
		Pagina_4.visible = false
		Pagina_5.visible = false
		Pagina_6.visible = false
		Pagina_7.visible = false
	elif Contador == 4:
		Pagina_1.visible = false
		Pagina_2.visible = false
		Pagina_3.visible = true
		Pagina_4.visible = false
		Pagina_5.visible = false
		Pagina_6.visible = false
		Pagina_7.visible = false
	elif Contador == 3:
		Pagina_1.visible = false
		Pagina_2.visible = false
		Pagina_3.visible = false
		Pagina_4.visible = true
		Pagina_5.visible = false
		Pagina_6.visible = false
		Pagina_7.visible = false
	elif Contador == 2:
		Pagina_1.visible = false
		Pagina_2.visible = false
		Pagina_3.visible = false
		Pagina_4.visible = false
		Pagina_5.visible = true
		Pagina_6.visible = false
		Pagina_7.visible = false
	elif Contador == 1:
		Pagina_1.visible = false
		Pagina_2.visible = false
		Pagina_3.visible = false
		Pagina_4.visible = false
		Pagina_5.visible = false
		Pagina_6.visible = true
		Pagina_7.visible = false
	elif Contador == 0:
		Pagina_1.visible = false
		Pagina_2.visible = false
		Pagina_3.visible = false
		Pagina_4.visible = false
		Pagina_5.visible = false
		Pagina_6.visible = false
		Pagina_7.visible = true
