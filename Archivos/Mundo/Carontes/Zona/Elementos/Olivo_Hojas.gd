extends Sprite2D


@onready var Hojas_Cayendo = $Hojas_Olivo_Cayendo
@onready var Hojas_Sonido = $Hojas_Cayendo


func _ready():
	
	Hojas_Cayendo.visible = false
	
	
func _on_liberar_hojas_derecha_area_entered(_area):
	Hojas_Cayendo.visible = true
	Hojas_Cayendo.flip_h = false
	Hojas_Sonido.play()
	Hojas_Cayendo.play("Animacion")
	
	
func _on_liberar_hojas_izquierda_area_entered(_area):
	Hojas_Cayendo.visible = true
	Hojas_Cayendo.flip_h = true
	Hojas_Cayendo.play("Animacion")
	Hojas_Sonido.play()
