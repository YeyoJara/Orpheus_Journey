extends Control

var Personaje:String
var Dialogo_1:String
var Dialogo_2:String
var Contador = 0
var Numerador = 0

@onready var Nombre = $CanvasLayer/Nombre
@onready var Texto = $CanvasLayer/Texto
@onready var Siguiente = $CanvasLayer/Siguiente
@onready var Rama_Dorada = $CanvasLayer/Rama_Dorada
@onready var No_Rama_Dorada = $CanvasLayer/No_Rama_Dorada

func _ready():
	
	get_tree().paused = true
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	Nombre.text = Personaje
	Texto.text = Dialogo_1
	
	if Dialogo_1 == "DC_4":
		Rama_Dorada.disabled = false
		Rama_Dorada.visible = true
		No_Rama_Dorada.disabled = false
		No_Rama_Dorada.visible = true
		No_Rama_Dorada.grab_focus()
	else:
		Rama_Dorada.disabled = true
		Rama_Dorada.visible = false
		No_Rama_Dorada.disabled = true
		No_Rama_Dorada.visible = false
		
		
func _process(_delta):
	
	if Contador == 0:
		Siguiente.visible = false
	else:
		Siguiente.visible = true
		
	if Input.is_action_just_pressed("ui_cancel"):
		Globales.Rama_Dorada_Item = true
		get_tree().paused = false
		queue_free()
## Cada siguiente cambia el texto y resta i valor del contador, para tener posibilidade de ##
## dialogos ilimitadas #######################################################################
	if Input.is_action_just_pressed("ui_right"):
		if Contador != 0:
			Numerador += 1
			if Numerador == 1:
				Texto.text = Dialogo_2
				Contador -= 1
				
############################## Cinematica_Ir_Mundo_2 #########################################
	if Dialogo_1 == "DC_3":
		Globales.Ir_Mundo_2 = true
	
	
func _on_rama_dorada_button_down():
	Texto.text = Dialogo_2
	Rama_Dorada.disabled = true
	Rama_Dorada.visible = false
	No_Rama_Dorada.disabled = true
	No_Rama_Dorada.visible = false
	Globales.Rama_Dorara = false
	Globales.Dialogo_Caronte = false
	Globales.Ir_Mundo_2 = true
	
	
func _on_no_rama_dorada_button_down():
	get_tree().paused = false
	queue_free()
