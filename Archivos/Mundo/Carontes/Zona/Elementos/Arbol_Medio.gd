extends StaticBody2D


@onready var Arbol_Medio = $Arbol_Medio
@onready var Arbol_Medio_Ani_Play = $Arbol_Medio_Ani_Play
@onready var Colision = $CollisionShape2D
@onready var Zona_Detectar = $Zona_Detectar
@onready var Colision_Detectar = $Zona_Detectar/CollisionShape2D
@onready var Antorcha = $Antorcha
@onready var Antorcha_Ani_Play = $Antorcha/Antorcha_Ani_Play
@onready var Colision_Antorcha  = $Antorcha/Caja_Lesion/CollisionShape2D
@onready var Colision_Area = $Caja_Lesion/CollisionShape2D
@onready var Aletheia = $Aletheia


func _ready():
	
		Arbol_Medio.visible = true
		Arbol_Medio_Ani_Play.play("Arbol_Medio")
		Colision.disabled = false
		Colision_Detectar.disabled = false
		Antorcha.visible = false
		Antorcha_Ani_Play.play("Anrocha_Apagada")
		Colision_Antorcha.disabled = true
		Colision_Area.disabled = true


func _process(_delta):
	
	var Orfeo = Zona_Detectar.Individuo
	if Orfeo != null:
		Globales.Curar = false
		if Globales.Aletheia == true:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiente"), -80)
			if Input.is_action_just_pressed("ui_play"):
				Aletheia.play()
				Arbol_Medio_Ani_Play.play("Desaparecer")
				Colision.disabled = true
				Colision_Detectar.disabled = true
				Colision_Area.disabled = false
func _on_caja_lesion_area_entered(_area):
	
	Antorcha_Ani_Play.play("Antorcha")
	Globales.Puerta_Secreta += 1
	
