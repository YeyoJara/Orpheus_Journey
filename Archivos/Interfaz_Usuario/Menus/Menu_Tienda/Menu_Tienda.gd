extends Control


var Existe = true

@onready var Tienda = $CanvasLayer/Tienda
@onready var Aria_Hermes = $CanvasLayer/Aria_Hermes
@onready var Aria_Hermes_Precio = $CanvasLayer/Aria_Hermes/Precio
@onready var Adagio_Amor = $CanvasLayer/Adagio_Amor
@onready var Adagio_Armor_Precio = $CanvasLayer/Adagio_Amor/Precio
@onready var Preludio = $CanvasLayer/Preludio
@onready var Prelucio_Precio = $CanvasLayer/Preludio/Precio
@onready var Aletheia = $CanvasLayer/Aletheia
@onready var Aletheia_Precio = $CanvasLayer/Aletheia/Precio


func _ready():
	
	get_tree().paused = true
		
	if Globales.Aria_Hermes == true:
		Aria_Hermes.disabled = true
		Aria_Hermes_Precio.visible = false
		
	if Globales.Adagio_Amor == true:
		Adagio_Amor.disabled = true
		Adagio_Armor_Precio.visible = false
		
	if Globales.Preludio == true:
		Preludio.disabled = true
		Prelucio_Precio.visible = false
		
	if Globales.Aletheia == true:
		Aletheia.disabled = true
		Aletheia_Precio.visible = false
		
	Aria_Hermes.grab_focus()
		
		
func _process(_delta):
	
	if Globales.Aria_Hermes == false:
		Tienda.text = "ἀγορά"
		Adagio_Amor.text = "Παροιμία της Αγάπης"
		Aletheia.text = "ἀλήθεια"
		Aria_Hermes.text = "Ὕμνος τοῦ Ἑρμοῦ"
		Preludio.text = "πρελούδιον"
	
	if Orfeo_Estadisticas.Obolos <= 9:
		Aria_Hermes.disabled = true
		
	if Orfeo_Estadisticas.Obolos <= 14:
		Adagio_Amor.disabled = true
		
	if Orfeo_Estadisticas.Obolos <= 49:
		Preludio.disabled = true
		
	if Orfeo_Estadisticas.Obolos <=24:
		Aletheia.disabled = true
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = false
		queue_free()



func _on_aria_hermes_button_down():
	if Orfeo_Estadisticas.Obolos >= 10:
		Orfeo_Estadisticas.Obolos -= 10
		Globales.Aria_Hermes = true
		Aria_Hermes.disabled = true
		Aria_Hermes_Precio.visible = false
		
		
func _on_adagio_amor_button_down():
	if Orfeo_Estadisticas.Obolos >= 15:
		Orfeo_Estadisticas.Obolos -= 15
		Globales.Adagio_Amor = true
		Adagio_Amor.disabled = true
		Adagio_Armor_Precio.visible = false

func _on_preludio_button_down():
	if Orfeo_Estadisticas.Obolos >= 50:
		Orfeo_Estadisticas.Obolos -= 50
		Globales.Preludio = true
		Preludio.disabled = true
		Prelucio_Precio.visible = false


func _on_aletheia_button_down():
	if Orfeo_Estadisticas.Obolos >= 25:
		Orfeo_Estadisticas.Obolos -= 25
		Globales.Aletheia = true
		Aletheia.disabled = true
		Aletheia_Precio.visible = false
