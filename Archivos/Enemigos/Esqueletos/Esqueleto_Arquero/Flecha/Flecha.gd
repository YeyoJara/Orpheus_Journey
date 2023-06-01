extends CharacterBody2D


@export var Velocidad = 100

@onready var Flecha_Tree = $Flecha_Tree
@onready var Flecha_Estado = Flecha_Tree.get("parameters/playback")
@onready var Colision_Flecha = $Flecha_Colision
@onready var Direccion_Flecha = $Areas/Direccion_Flecha
@onready var Colision_Trayectoria = $Areas/Direccion_Flecha/CollisionShape2D
@onready var Trayectoria_Flecha = $Temporizadores/Trayectoria
@onready var Tiempo_Vida = $Temporizadores/Tiempo_Vida
@onready var Colision = $Temporizadores/Colision


func _ready():
	
	Flecha_Tree.active = true
	Colision_Flecha.disabled = true
	Trayectoria_Flecha.start()
	Tiempo_Vida.start()
	Colision.start()
	
	
func _physics_process(delta):
	
	var Movimiento = move_and_collide(velocity * delta)
	if Movimiento:
		velocity = velocity.bounce(Movimiento.get_normal())
		velocity.x *= 0
		velocity.y *= 0
		
	var Orfeo = Direccion_Flecha.Individuo
	if Orfeo != null:
		var Direccion = (Orfeo.global_position - global_position).normalized()
		var input_vector = (Orfeo.global_position - global_position)
		Flecha_Tree.set("parameters/Flecha/blend_position", input_vector)
		Flecha_Estado.travel("Flecha")
		velocity =  velocity.move_toward(Direccion * Velocidad, Velocidad)
		
	move_and_collide(velocity * delta)
	
	
func _on_caja_golpe_area_entered(_area):
	queue_free()
	
	
func _on_trayectoria_timeout():
	Colision_Trayectoria.disabled = true
	
	
func _on_tiempo_vida_timeout():
	queue_free()


func _on_colision_timeout():
	Colision_Flecha.disabled = false
