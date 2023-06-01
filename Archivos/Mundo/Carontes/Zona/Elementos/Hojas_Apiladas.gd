extends Sprite2D


const Efecto_Hojas_Apliadas = preload("res://Archivos/Efectos/Efecto_Hojas_Apiladas.tscn")


func Liberar_Hojas():
	
	var Hojas_Efecto = Efecto_Hojas_Apliadas.instantiate()
	get_parent().add_child(Hojas_Efecto)
	Hojas_Efecto.global_position = global_position
	
	
func _on_caja_lesion_area_entered(_area):
	Liberar_Hojas()
	queue_free()
