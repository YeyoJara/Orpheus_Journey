extends CharacterBody2D



@export var Empuje: float = 2.5
@export var Friccion = 200
@export var Velocidad = 20

enum  {Inactivo, Perseguir}

var Estado = Inactivo
var Retroceso = Vector2.ZERO

@onready var Esqueleto_Tree = $Esqueleto_Tree
@onready var Esqueleto_Estado = Esqueleto_Tree.get ("parameters/playback")
@onready var Estadisticas = $Estadisticas
@onready var Colision_Suave = $Areas/Coliision_Sauve
@onready var Caja_Lesion = $Areas/Caja_Lesion
@onready var Zona_Detectar_Orfeo = $Areas/Zona_Detectar
@onready var Colision_Lesion = $Areas/Caja_Lesion/CollisionShape2D
@onready var Lesion_Color = $Temporizadores/Color


const Esqueleto_Muerto = preload("res://Archivos/Enemigos/Esqueletos/Esqueleto_Muerto/Esqueleto_Muerto.tscn")


func _ready():
	
	Esqueleto_Tree.active = true
	Colision_Lesion.disabled = true
	
func _physics_process(delta):
	
	if Globales.Matar_Enemigos == true:
		Estadisticas.Vida = 0
	
	velocity = Retroceso
	Retroceso = Retroceso.move_toward(Vector2.ZERO, Friccion * delta)
	
	match  Estado:
		
		Inactivo:
			Esqueleto_Estado.travel("Inactivo")
			velocity.x = move_toward(velocity.x, 0, Velocidad * 0)
			velocity.y = move_toward(velocity.y, 0, Velocidad * 0)
			Buscar_Orfeo()
			
		Perseguir:
			Colision_Lesion.disabled = false
			var Orfeo = Zona_Detectar_Orfeo.Individuo
			if Orfeo != null:
				var Direccion = (Orfeo.global_position - global_position).normalized()
				var input_vector = (Orfeo.global_position - global_position)
				Esqueleto_Tree.set("parameters/Arrastrar/blend_position", input_vector)
				Esqueleto_Estado.travel("Arrastrar")
				velocity=  velocity.move_toward(Direccion * Velocidad, Velocidad)
			else:
				Estado = Inactivo
				
	if Colision_Suave.Colisionando():
		velocity += Colision_Suave.Empujar_Vector() * delta
		
	move_and_slide()
	
		
func Buscar_Orfeo():
	
	if Zona_Detectar_Orfeo.Puede_Ver_Orfeo():
		Estado = Perseguir
		
		
func _on_caja_lesion_area_entered(area):
	Estadisticas.Vida -= area.Golpe
	Retroceso = area.Vector_Retroceso * Empuje
	Caja_Lesion.Crear_Astillas()
	
func _on_estadisticas_sin_vida():
	Globales.Salir_Arena -= 1
	
	var Muerto_Esqueleto = Esqueleto_Muerto.instantiate()
	get_parent().call_deferred("add_child", Muerto_Esqueleto)
	Muerto_Esqueleto.position = position
	queue_free()

