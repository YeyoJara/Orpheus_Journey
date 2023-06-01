extends Area2D


func Colisionando ():
	
	var Areas = get_overlapping_areas()
	return Areas.size() > 0
	
	
func Empujar_Vector ():
	
	var Areas = get_overlapping_areas()
	var Empujar = Vector2.ZERO
	if Colisionando():
		var Zona = Areas [0]
		Empujar = Zona.global_position.direction_to(global_position)
		Empujar = Empujar.normalized()
	return Empujar
