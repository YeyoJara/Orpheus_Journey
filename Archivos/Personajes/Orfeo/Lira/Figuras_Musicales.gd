extends CharacterBody2D


@export var Velocidad = 50

var Retroceso = Vector2.ZERO


@onready var Caja_Golpe = $Caja_Golpe
@onready var Tiempo_Vida = $Tiempo_Vida
@onready var Camara_Figuras_Musicales = $Camera_Figuras_Musicales


signal Corcheas_Vida


func _ready():
	
	Caja_Golpe.Vector_Retroceso = Vector2.ZERO
	Tiempo_Vida.start()
	
	
func _physics_process(delta):
	
	velocity.x = Input.get_axis("ui_left", "ui_right")
	velocity.y = Input.get_axis("ui_up", "ui_down")
	velocity =  velocity.move_toward(velocity * Velocidad, Velocidad)
		
	var Movimiento = move_and_collide(velocity * delta)
	if Movimiento:
		velocity = velocity.bounce(Movimiento.get_normal())
		Corcheas_Vida.emit()
		
	move_and_slide()
		
	if Input.is_action_just_pressed("ui_shoot"):
		Corcheas_Vida.emit()
		
		
func _on_caja_golpe_area_entered(_area):
	Corcheas_Vida.emit()
	
	
func _on_tiempo_vida_timeout():
	Corcheas_Vida.emit()
	
	
func _on_corcheas_vida():
	Camara_Figuras_Musicales.enabled = false
	queue_free()
