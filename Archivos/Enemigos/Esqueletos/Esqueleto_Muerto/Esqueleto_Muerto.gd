extends StaticBody2D


@onready var Estadisticas = get_node("Estadisticas")
@onready var Caja_Lesion = $Caja_Lesion

const Efecto_Esqueleto = preload("res://Archivos/Efectos/Efecto_Esqueleto.tscn")
const Obolos = preload("res://Archivos/Interfaz_Usuario/Recogibles/Obolo/Generacion_Obolos.tscn")


func Crear_Efecto_Esqueleto():
	
	var Esqueleto_Efecto = Efecto_Esqueleto.instantiate()
	get_parent().add_child(Esqueleto_Efecto)
	Esqueleto_Efecto.global_position = global_position	
	
	
func _on_caja_lesion_area_entered(_area):
	
	Caja_Lesion.Crear_Astillas()
	Estadisticas.Vida -= 1
	if Estadisticas.Vida <= 0:
		var Obolo = Obolos.instantiate()
		get_parent().call_deferred("add_child", Obolo)
		Obolo.position = position
		Crear_Efecto_Esqueleto()
		queue_free()
