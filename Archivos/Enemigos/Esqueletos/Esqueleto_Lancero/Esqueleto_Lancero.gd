extends CharacterBody2D




@export var Empuje: float = 2
@export var Friccion = 200
@export var Velocidad = 10

@onready var Esqueleto_Tree = $Esqueleto_Lancero_Tree
@onready var Esqueleto_Estado = Esqueleto_Tree.get ("parameters/playback")
@onready var Estadisticas = $Estadisticas

enum {Atacar, Despertar, Devenir, Iniciar, Inactivo, Perseguir, Transicionar}

var Contador = 1
var Estado = Iniciar
var Medidor = 1
var Retroceso = Vector2.ZERO

@onready var Caja_Golpe = $Areas/Caja_Golpe/CollisionShape2D
@onready var Caja_Lesion = $Areas/Caja_Lesion
@onready var Colision_Suave = $Areas/Colision_Sauve
@onready var Zona_Atacar = $Areas/Zona_Atacar
@onready var Zona_Detectar_Orfeo = $Areas/Zona_Detectar
@onready var Colision_Lesion = $Areas/Caja_Lesion/CollisionShape2D

const Esqueleto_Muerto = preload("res://Archivos/Enemigos/Esqueletos/Esqueleto_Muerto/Esqueleto_Muerto.tscn")


func _ready():
	
	Esqueleto_Tree.active = true
	Caja_Golpe.disabled = true
	Colision_Lesion.disabled = true
	
	
func _physics_process(delta):
	
	if Globales.Matar_Enemigos == true:
		Estadisticas.Vida = 0
	
	velocity = Retroceso
	Retroceso = Retroceso.move_toward(Vector2.ZERO, Friccion * delta)
	
	match  Estado:
		Atacar:
			Estado_Atacar()
			Colision_Lesion.disabled = false
			
		Despertar:
			Esqueleto_Estado.travel ("Despertar")
			
		Devenir:
			Esqueleto_Estado.travel("Devenir")
			
		Iniciar:
			var Orfeo = Zona_Detectar_Orfeo.Individuo
			if Orfeo != null:
				Estado = Despertar
			
		Inactivo:
			Esqueleto_Estado.travel("Inactivo")
			Buscar_Orfeo()
			
		Perseguir:
			Estado_Perseguir()
			Colision_Lesion.disabled = false
			
		Transicionar:
			Esqueleto_Estado.travel ("Transicionar")
			Medidor -=1
			
	if Colision_Suave.Colisionando():
		velocity += Colision_Suave.Empujar_Vector() * delta
		
	move_and_slide()
	
	if Zona_Detectar_Orfeo.Individuo != null and Contador ==1:
		Estado = Despertar
		
	if Zona_Detectar_Orfeo.Individuo != null and Contador ==0:
		Estado = Perseguir
		
	if Zona_Atacar.Individuo != null and Medidor == 1:
		Estado = Transicionar
		
	if Zona_Atacar.Individuo != null and Medidor == 0:
		Estado = Atacar
		
		
func Estado_Atacar():
	
	var Orfeo = Zona_Atacar.Individuo
	if Orfeo != null:
		var input_vector = (Orfeo.global_position - global_position)
		Esqueleto_Tree.set("parameters/Atacar/blend_position", input_vector)
		Esqueleto_Estado.travel ("Atacar")
		velocity.x = move_toward(velocity.x, 0, Velocidad * 0)
		velocity.y = move_toward(velocity.y, 0, Velocidad * 0)
		
		
func Estado_Despertat():
	
	Estado = Perseguir
	Contador -= 1
	
	
func Estado_Inactivo():
	
	Estado = Inactivo
	
	
func Estado_Perseguir():
	
	var Orfeo = Zona_Detectar_Orfeo.Individuo
	if Orfeo != null:
		var Direccion = (Orfeo.global_position - global_position).normalized()
		var input_vector = (Orfeo.global_position - global_position)
		Esqueleto_Tree.set("parameters/Caminar/blend_position", input_vector)
		Esqueleto_Tree.set("parameters/Transicionar/blend_position", input_vector)
		Esqueleto_Estado.travel ("Caminar")
		velocity=  velocity.move_toward(Direccion * Velocidad, Velocidad)
	else :
		Estado = Devenir
		
		
func Estado_Transicionar():
	
	Estado = Atacar
		
		
func Buscar_Orfeo():
	
	if Zona_Detectar_Orfeo.Individuo:
		Estado = Perseguir
		
		
func _on_caja_lesion_area_entered(area):
	Estadisticas.Vida -= area.Golpe
	Retroceso = area.Vector_Retroceso * Empuje
	Caja_Lesion.Crear_Astillas()


func _on_estadisticas_sin_vida():
	Globales.Salir_Arena -= 1
	var Muerto_Esqueleto = Esqueleto_Muerto.instantiate()
	get_parent().call_deferred("add_child",Muerto_Esqueleto)
	Muerto_Esqueleto.position = position
	queue_free()


func _on_zona_detectar_orfeo_body_exited(_body):
	Contador = 1


func _on_zona_atacar_body_exited(_body):
	Medidor = 1
