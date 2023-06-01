extends CharacterBody2D

@export var Velocidad = 40
@export var Velocidad_Salto = 0.025
@export var Vida_Maxima = 5


enum {Atacar, Caminar, Disparar, Morir, Saltar, Tocar}

var Combo = 3
var Contador = 1
var Estadisticas = Orfeo_Estadisticas
var Estado = Caminar
var Inactivo = false
var Retroceso = Vector2.ZERO
var Vector_Saltar = Vector2.DOWN

@onready var Orfeo_Tree = $Orfeo_Tree
@onready var Orfeo_Estado = Orfeo_Tree.get("parameters/playback")
@onready var Caja_Lesion = $Areas/Caja_Lesion
@onready var Colision_Lesion = $Areas/Caja_Lesion/CollisionShape2D
@onready var Colision_Golpe = $Areas/Caja_Golpe/CollisionShape2D
@onready var Caja_Golpe = $Areas/Caja_Golpe
@onready var Colision_Suave = $Areas/Colision_Sauve
@onready var Camara_Orfeo = $Camera_Orfeo

@onready var Terminar_Invencibilidad = $Temporizadores/Terminar_Invencibilidad
@onready var Sanar = $Temporizadores/Sanar
@onready var Sanar_Falla = $Temporizadores/Sanar_Falla
@onready var Lesion_Color = $Temporizadores/Color

@onready var Recuerdo_Euridice = $Audios/Canciones/Recuerdo_Euridice
@onready var Recuerdo_Euridice_Falla = $Audios/Canciones/Recuerdo_Euridice_Falla
@onready var Caminar_Hierva = $Audios/Efectos_Sonido/Caminar_Hierva


const Figuras_Musicales = preload("res://Archivos/Personajes/Orfeo/Lira/Figuras_Musicales.tscn")
const Menu_Pausa = preload("res://Archivos/Interfaz_Usuario/Menus/Menu_Pausa/Menu_Pausa.tscn")
const Menu_Inventario = preload("res://Archivos/Interfaz_Usuario/Menus/Menu_Inventario/Inventario.tscn")
const Fin_Travesia = preload("res://Archivos/Interfaz_Usuario/Menus/Fin_Juego/Fin_Travesia.tscn")

func _ready():
	
	Globales.Matar_Enemigos = false
	Estadisticas.Sin_Vida.connect(Estado_Morir)
	Orfeo_Tree.active = true
	Colision_Golpe.disabled = true
	Colision_Lesion.disabled = false
	Caja_Golpe.Vector_Retroceso = Vector_Saltar
	
	
func _physics_process(delta):
	
	match  Estado:
		
		Atacar:
			Estado_Atacar()
			
		Caminar:
			Estado_Caminar()
			
		Disparar:
			Estado_Disparar()
			
		Morir:
			Estado_Morir()
			
		Saltar:
			Estado_Saltar()
			
		Tocar:
			Estado_Tocar()
			
	if Input.is_action_just_pressed("ui_start"):
		Pausa()
		
	if Input.is_action_just_pressed("ui_inventory"):
		Inventario()
		
	if Colision_Suave.Colisionando():
		velocity += Colision_Suave.Empujar_Vector() * delta
		
	if velocity == Vector2.ZERO:
		Caminar_Hierva.stop()
		
func Estado_Atacar():
	
	if Combo == 3 && Input.is_action_pressed("ui_attack"):
		Orfeo_Estado.travel("Atacar1")
		
	elif Combo == 2 && Input.is_action_just_pressed("ui_attack"):
		Orfeo_Estado.travel("Atacar2")
		
	elif Combo == 1 && Input.is_action_just_pressed("ui_attack"):
		Orfeo_Estado.travel("Atacar3")
		Combo = Combo -1
		
		
func Cambiar_Atacar():
	
	Combo -= 1
	
	
func Terminar_Atacar():
	
	Combo = 3
	Estado = Caminar
	
	
func Estado_Caminar():

	velocity.x = Input.get_axis("ui_left", "ui_right")
	velocity.y = Input.get_axis("ui_up", "ui_down") 
	velocity = velocity.normalized() * Velocidad
	
	if velocity != Vector2.ZERO:
		Vector_Saltar = velocity
		Caja_Golpe.Vector_Retroceso = velocity
		Orfeo_Tree.set("parameters/Atacar1/blend_position", velocity)
		Orfeo_Tree.set("parameters/Atacar2/blend_position", velocity)
		Orfeo_Tree.set("parameters/Atacar3/blend_position", velocity)
		Orfeo_Tree.set("parameters/Caminar/blend_position", velocity)
		Orfeo_Tree.set("parameters/Inactivo/blend_position", velocity)
		Orfeo_Tree.set("parameters/Morir/blend_position", velocity)
		Orfeo_Tree.set("parameters/Saltar/blend_position", velocity)
		Orfeo_Estado.travel("Caminar")
	else:
		Orfeo_Estado.travel ("Inactivo")
		velocity.x = move_toward(velocity.x, 0, Velocidad)
		velocity.y = move_toward(velocity.y, 0, Velocidad)
		
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_attack"):
		Estado = Atacar
		
	if Input.is_action_just_pressed("ui_shoot"):
		Estado = Disparar
	
	if Input.is_action_just_pressed("ui_jump"):
		Estado = Saltar
		
	if Input.is_action_just_pressed("ui_play"):
		Estado = Tocar
		
	if Estadisticas.Vida <= 0:
		Estado = Morir
		
		
func Estado_Disparar():
	
	
	if Input.is_action_pressed("ui_shoot") and Contador ==1:
		var Corcheas = Figuras_Musicales.instantiate()
		get_parent().add_child(Corcheas)
		Corcheas.global_position = global_position
		Corcheas.Corcheas_Vida.connect(Terminar_Disparar)
		Orfeo_Estado.travel ("Inactivo")
		Contador -= 1
		Camara_Orfeo.enabled = false
	elif Input.is_action_just_pressed("ui_shoot")and Contador ==0:
		Estado = Caminar
		Contador = 1
		Camara_Orfeo.enabled = true
	elif Camara_Orfeo.enabled == true:
		Estado = Caminar
	
func Terminar_Disparar():
	Camara_Orfeo.enabled = true
	Contador = 1
	
	
func Inventario():
	var Inventarios = Menu_Inventario.instantiate()
	get_parent().call_deferred("add_child", Inventarios)
	Inventarios.global_position = global_position
	
	
func Estado_Morir ():
	
	if Estadisticas.Vida <= 0:
		Orfeo_Estado.travel("Morir")
		
		
func Morir_Menu():
	
	var Fin_Juego = Fin_Travesia.instantiate()
	get_parent().add_child(Fin_Juego)
	Fin_Juego.global_position = global_position
	
	
func Estado_Saltar():
	
	Colision_Lesion.disabled = true
	Terminar_Invencibilidad.start()
	velocity = Vector_Saltar * Velocidad * Velocidad_Salto
	Orfeo_Estado.travel("Saltar")
	move_and_slide()
	
	
func Estado_Tocar():
	
	Estadisticas.Reutilizables = clampi(Estadisticas.Reutilizables, 0, Estadisticas.Reutilizables_Maximos)
	Orfeo_Estado.travel("Inactivo")
	
	if Globales.Curar == true:
		if Input.is_action_pressed("ui_play"):
			if Estadisticas.Reutilizables != 0:
				Recuerdo_Euridice.play()
				Sanar.start()
			else: 
				Recuerdo_Euridice_Falla.play()
				Sanar_Falla.start()
	else: 
		Estado = Caminar
		
		
func Terminar_Saltar():
	
	velocity = velocity
	Estado = Caminar
	
	
func Pausa():
	var Pausar = Menu_Pausa.instantiate()
	get_parent().add_child(Pausar)
	Pausar.global_position = global_position
	
	
	
func _on_caja_lesion_area_entered(area):
	Estadisticas.Vida -= area.Golpe * Estadisticas.Multiplicador_Lesion_Recibida
	Caja_Lesion.Comenzar_Invencibilidad (1.5)
	Caja_Lesion.Crear_Astillas()
	self.modulate = "red"
	Lesion_Color.start()


func _on_terminar_invencibilidad_timeout():
	Colision_Lesion.disabled = false


func _on_sanar_timeout():
	Estado = Caminar
	Estadisticas.Vida += 3
	Estadisticas.Reutilizables -= 1
	Sanar.stop()
	
	
func _on_sanar_falla_timeout():
	Estado = Caminar
	
	
func _on_verificar_timeout():
	Globales.Curar = true
	
	
func _on_color_timeout():
	self.modulate = "white"
