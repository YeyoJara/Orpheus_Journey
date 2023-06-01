extends Control


@export var Posicion = Vector2()

@onready var Etiqueta = $Texto


func _process(delta):
	
	self.global_position = Posicion
