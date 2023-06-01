extends AnimatedSprite2D

var color = "bcbcbc"

func _ready():
	
	self.modulate = color
	animation_finished.connect(Terminar_Animacion)
	frame = 0
	play("Animacion")


func Terminar_Animacion():

	queue_free()
