extends Sprite2D

var Romper = false

@onready var Antorcha_Ani_Play = $Antorcha_Ani_Play
@onready var Zona_Detectar = $Zona_Detectar
@export var Detectar_Orfeo = false


func _ready():

	if Detectar_Orfeo == true: 
		Antorcha_Ani_Play.play("Anrocha_Apagada")
	elif Detectar_Orfeo == false:
		Antorcha_Ani_Play.play("Antorcha")
		
		
func _process(_delta):
	
	if Detectar_Orfeo == true:
		var Orfeo = Zona_Detectar.Individuo
		if Orfeo != null and Romper == false:
			Antorcha_Ani_Play.play("Antorcha")
			
		if Orfeo == null and Romper == false:
			Antorcha_Ani_Play.play("Anrocha_Apagada")
	
func Liberar():
	
	queue_free()
	
	
func _on_caja_lesion_area_entered(_area):
	Romper = true
	Antorcha_Ani_Play.play("Romperse")
