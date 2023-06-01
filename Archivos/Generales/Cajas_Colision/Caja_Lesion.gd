extends Area2D

@export var Astillas: bool = false
@export var color = "bcbcbc"

var Invencible = false: set = Poner_Invencible, get = Quitar_Invencibilidad

@onready var Temporizador = $Timer
@onready var Colision = $CollisionShape2D

const Lira_Golpe = preload("res://Archivos/Efectos/Efecto_Lesion.tscn")

signal Comenzar_Invencible
signal Terminar_Invencible


func Poner_Invencible(value):
	
	Invencible = value
	if Invencible == true:
		Comenzar_Invencible.emit()
	else:
		Terminar_Invencible.emit()
		

func Quitar_Invencibilidad():
	
	return Invencible
	
	
func Comenzar_Invencibilidad (_duration):
	
	self.Invencible = true
	Temporizador.start()
	
func Crear_Astillas():
	if Astillas == true:
		var Efecto_Astillas = Lira_Golpe.instantiate()
		Efecto_Astillas.color = color
		get_parent().add_child(Efecto_Astillas)
		Efecto_Astillas.position = position
	
func _on_timer_timeout():
	self.Invencible = false
	
	
func _on_comenzar_invencible():
	set_deferred("monitoring", false)
	
	
func _on_terminar_invencible():
	monitoring = true
