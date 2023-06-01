extends CharacterBody2D


var Velocidad = 10

@export var Sombra = true
@export var Temporizador = true

@onready var Obolo = $Obolo
@onready var Sombra_Ani = $Sombra
@onready var Colision = $Area2D/CollisionShape2D
@onready var Tiempo_Vida = $Tiempo_Vida
@onready var Zona_Detectar = $Zona_Detectar

func _ready():
	
	Obolo.play("Animacion")
	
	if Sombra == true:
		Sombra_Ani.play("Animation")
		Sombra_Ani.visible = true
		Colision.disabled = false
	else:
		Sombra_Ani.visible = false
		Colision.disabled = true
		
	if Temporizador == true:
		Tiempo_Vida.start()
		
		
func _process(_delta):
	var Orfeo = Zona_Detectar.Individuo
	if Orfeo != null:
		var Direccion = (Orfeo.global_position - global_position).normalized()
		velocity = velocity.move_toward(Direccion * Velocidad, Velocidad)
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	
func _on_area_2d_body_entered(_body):
	Orfeo_Estadisticas.Obolos += 1
	Orfeo_Estadisticas.Visualizar_Obolos = true
	queue_free()
	
	
func _on_tiempo_vida_timeout():
	queue_free()
