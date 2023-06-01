extends CharacterBody2D


@export var Friccion = 200
@export var Velocidad = 10

@onready var Caronte_Ani_Play = $Caronte_Ani_Play
@onready var Fuego = $Fuego
@onready var Lanzar_Fuego = $Lanzar_Fuego
@onready var Caronte_Tree = $Caronte_Tree
@onready var Caronte_Estado = Caronte_Tree.get("parameters/playback")
@onready var Estadisticas = $Estadisticas
@onready var Invocacion = $Temporizadores/Invocar

enum {Atacar, Caer, Inactivo, Invocar, Lanzar, Perseguir}

var Estado = Atacar
var Combo = 2
var Fase_1 = false
var Fase_2 = false
var Obolos = true

@onready var Colision_Golpe = $Areas/Caja_Golpe/CollisionShape2D
@onready var Colision_Fuego = $Areas/Caja_Golpe_Fuego/CollisionShape2D
@onready var Caja_Lesion = $Areas/Caja_Lesion
@onready var Colision_Lesion = $Areas/Caja_Lesion/CollisionShape2D
@onready var Zona_Atacar = $Areas/Zona_Atacar
@onready var Colision_Zona_Atacar = $Areas/Zona_Atacar/CollisionShape2D
@onready var Zona_Detectar = $Areas/Zona_Detectar
@onready var Colision_Zona_Detectar = $Areas/Zona_Detectar/CollisionShape2D
@onready var Zona_Lanzar_Fuego = $Areas/Zona_Lanzar_Fuego
@onready var Zona_Detectar_Musica = $Areas/Zona_Detectar_Musica
@onready var Colision_Musica = $Areas/Zona_Detectar_Musica/CollisionShape2D
@onready var Zona_Detectar_Rama_Dorada = $Areas/Zona_Detectar_Rama_Dorada
@onready var Colision_Rama_Dorada = $Areas/Zona_Detectar_Rama_Dorada/CollisionShape2D
@onready var Rama_Dorada = $Rama_Dorada
@onready var Pentagrama = $Pentagrama
@onready var Preludio = $Audios/Canciones/Preludio
@onready var Lanzar_Fuego_Sonido = $Audios/Efectos/Lanzar_Fuego
@onready var Inherit = $Temporizadores/Inherit

const Esqueleto = preload("res://Archivos/Personajes/Jefes/Carontes/Generacion_Esqueletos.tscn")
const Dialogos = preload("res://Archivos/Interfaz_Usuario/Dialogos/Dialogos.tscn")
const Generacion_Obolos = preload("res://Archivos/Interfaz_Usuario/Recogibles/Obolo/Generacion_Obolos.tscn")


func _ready():
	
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	
	Inherit.start()
	
	if Globales.Caronte_Vivo == true:
		if Globales.Dialogo_Caronte == true:
			var Dialogo = Dialogos.instantiate()
			Dialogo.Personaje = "NP_2"
			Dialogo.Dialogo_1 = "DC_1"
			Dialogo.Dialogo_2 = "DC_2"
			Dialogo.Contador = 1
			get_parent().call_deferred("add_child", Dialogo)
	
	if Globales.Caronte_Vivo == true:
		Globales.Salir_Arena += 1
	
	Fuego.emitting = false
	
	Caronte_Tree.active = true
	Colision_Golpe.disabled = true
	
	if Globales.Carontes_Pelea == false:
		if Globales.Caronte_Vivo == true:
			Caronte_Ani_Play.play("Inactivo")
		else:
			Caronte_Ani_Play.play("Arrodillar")
			
	Rama_Dorada.visible = false
	Pentagrama.visible = false
			
func _process(_delta):
	
	if Estado != Lanzar:
		Lanzar_Fuego_Sonido.stop()
	
	if Globales.Caronte_Vivo == false:
		Fuego.emitting = false
		Colision_Lesion.disabled = true
	
	if Estado == Inactivo:
		Fuego.emitting = true
		Fuego.visible = true
	else:
		Fuego.emitting = false
		Fuego.visible = false
	
	if Estado == Lanzar:
		Lanzar_Fuego.emitting = true
		Colision_Fuego.disabled = false
	else:
		Lanzar_Fuego.emitting = false
		Colision_Fuego.disabled = true
		
	if Estado != Atacar:
		Colision_Golpe.disabled = true
		
	if Globales.Carontes_Pelea == true:
		if Estadisticas.Vida <= 8:
			Fase_1 = false
			Fase_2 = true
		else: 
			Fase_1 = true
			Fase_2 = false
			
		match Estado:
			Atacar:
				Estado_Atacar()
				velocity *= 0
				
			Caer:
				Estado_Caer()
				velocity *= 0
				
			Inactivo:
				Estado_Inactivo()
				velocity *= 0
				
			Invocar:
				velocity *= 0
				
			Lanzar:
				Estado_Lanzar()
				velocity *= 0
				
			Perseguir:
				Estado_Perseguir()
		
		move_and_slide()
		
		if Fase_1 == true:
			if Zona_Lanzar_Fuego.Individuo != null:
				Estado = Lanzar
			else:
				Estado = Inactivo
				
		if Fase_2 == true:
			
			if Zona_Detectar.Individuo != null:
				Estado = Perseguir
				
			if Zona_Atacar.Individuo != null:
				Estado = Atacar
				
	if Globales.Caronte_Vivo == false:
		var Orfeo = Zona_Detectar_Musica.Individuo
		if Globales.Preludio == true:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiente"), -80)
			if Orfeo != null:
				Globales.Curar = false
				Pentagrama.visible = true
				if Input.is_action_just_pressed("ui_play"):
					if Globales.Dialogo_Caronte == true:
						var Dialogo = Dialogos.instantiate()
						self.process_mode = Node.PROCESS_MODE_ALWAYS
						Dialogo.Personaje = "NP_2"
						Dialogo.Dialogo_1 = "DC_3"
						get_parent().call_deferred("add_child", Dialogo)
						Globales.Dialogo_Caronte = false
						Preludio.play()
			else:
				Pentagrama.visible = false
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiente"), Globales.Musica_Fondo)
				
	if Globales.Caronte_Vivo == false:
		var Orfeo = Zona_Detectar_Rama_Dorada.Individuo
		if Globales.Rama_Dorara == true:
			if Orfeo != null:
				Globales.Curar = false
				Rama_Dorada.visible = true
				Pentagrama.visible = false
				Colision_Musica.disabled = true
				if Input.is_action_just_pressed("ui_play"):
					if Globales.Dialogo_Caronte == true:
						var Dialogo = Dialogos.instantiate()
						self.process_mode = Node.PROCESS_MODE_ALWAYS
						Dialogo.Personaje = "NP_2"
						Dialogo.Dialogo_1 = "DC_4"
						Dialogo.Dialogo_2 = "DC_5"
						get_parent().call_deferred("add_child", Dialogo)
			else:
				Colision_Musica.disabled = false
				Rama_Dorada.visible = false

	if Globales.Dialogo_Caronte == false:
		Colision_Musica.disabled = false
		
	if Globales.Ir_Mundo_2 == true:
		Colision_Rama_Dorada.disabled = true
		Colision_Musica.disabled = true
		Rama_Dorada.visible = false
		Pentagrama.visible = false
		
		
func Estado_Atacar():
	
	var Orfeo = Zona_Atacar.Individuo
	if Orfeo != null:
		if Combo == 2:
			Caronte_Estado.travel("Atacar1")
	
		if Combo == 1:
			Caronte_Estado.travel("Atacar2")
		
		
func Cambiar_Atacar():
	
	Combo -= 1
	
func Terminar_Atacar():
	
	Combo = 2
	Estado = Perseguir
	
	
func Estado_Caer():
	
		Caronte_Estado.travel("Caer")
		Colision_Zona_Atacar.disabled = true
		Colision_Zona_Detectar.disabled = true
		Invocacion.stop()
		if Obolos == true:
			var Obolo = Generacion_Obolos.instantiate()
			get_parent().call_deferred("add_child", Obolo)
			Obolo.global_position = global_position
			Obolo.Obolos_Minimos = 50
			Obolo.Obolos_Minimos = 50
			Obolo.Probabilidades = [100]
		
		
func Caer_Permanente():
	Globales.Carontes_Pelea = false
		
		
func Estado_Inactivo():
	
	Caronte_Estado.travel("Inactivo")
	
	
func Estado_Invocar():
	
	if Fase_2 == true:
		Estado = Invocar
		Colision_Zona_Detectar.disabled = true
		Colision_Zona_Atacar.disabled = true
		Caronte_Estado.travel("Invocar")
	
	
func Terminar_Invocar():
	
	var Esqueletos = Esqueleto.instantiate()
	get_parent().add_child(Esqueletos)
	Esqueletos.global_position = global_position
	Colision_Zona_Detectar.disabled = false
	Estado = Perseguir
	Colision_Zona_Atacar.disabled = false
	
	
func Estado_Lanzar():
	
	Caronte_Estado.travel("Lanzar")
	
	
func Estado_Perseguir():
	
	var Orfeo = Zona_Detectar.Individuo
	if Orfeo != null:
		var Direccion = (Orfeo.global_position - global_position).normalized()
		var input_vector = (Orfeo.global_position - global_position)
		Caronte_Tree.set("parameters/Atacar1/blend_position", input_vector)
		Caronte_Tree.set("parameters/Atacar2/blend_position", input_vector)
		Caronte_Tree.set("parameters/Caer/blend_position", input_vector)
		Caronte_Tree.set("parameters/Caminar/blend_position", input_vector)
		Caronte_Tree.set("parameters/Invocar/blend_position", input_vector)
		Caronte_Estado.travel("Caminar")
		velocity=  velocity.move_toward(Direccion * Velocidad, Velocidad)
		
		
func _on_invocar_timeout():
	if Fase_2 == true:
		Estado_Invocar()
		
		
func _on_estadisticas_sin_vida():
	Globales.Salir_Arena -= 1
	Estado = Caer
	Globales.Caronte_Vivo = false
	
	
func _on_caja_lesion_area_entered(area):
	Estadisticas.Vida -= area.Golpe
	
	
func _on_inherit_timeout():
	self.process_mode = Node.PROCESS_MODE_INHERIT
