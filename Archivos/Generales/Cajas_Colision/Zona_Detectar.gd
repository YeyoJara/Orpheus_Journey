extends Area2D


var Individuo = null


func Puede_Ver_Orfeo():
	
	return Individuo != null
	
	
func _on_body_entered(body):
	Individuo = body
	
	
func _on_body_exited(_body):
	Individuo = null
