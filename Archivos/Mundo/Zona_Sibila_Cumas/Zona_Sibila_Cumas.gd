extends Node2D


var Cinematica = true

@onready var Orfeo = $Elementos/Orfeo
@onready var Orfeo_Ani_Play = $Elementos/Orfeo/Orfeo_Ani_Player
@onready var Orfeo_Tree = $Elementos/Orfeo/Orfeo_Tree
@onready var Bordes = $Bordes
@onready var Flecha_Ani_Play = $Elementos/Flecha/Flecha_Ani_Player
@onready var Bordes_Ani_Play = $Bordes/Bordes_Ani_Play
@onready var Zona_Derectar = $Zona_Detectar
@onready var Colision_Detectat = $Zona_Detectar/CollisionShape2D
@onready var Techo_Templo_Apolo = $Elementos/Tempolo_Apolo/Techo_Templo_Apolo
@onready var Detectar_Orfeo_Techo = $Elementos/Tempolo_Apolo/Zona_Detectar
@onready var Pergamino = $Elementos/Flecha/Pergamino
@onready var Colision_Pergamino = $Elementos/Flecha/Pergamino/Zona_Detectar/CollisionShape2D
@onready var Colision_Tragedia = $Elementos/Flecha/Pergamino/Area2D/CollisionShape2D
@onready var Transicion_Suave = $Transicion_Suave
@onready var Transicion = $Transicion_Suave/Transicion

	
func _ready():
	Transicion.play("Iniciar_Escena")
	Cinematica = true
	Bordes.visible = false
	Colision_Pergamino.disabled = true
	
	
func _process(_delta):
		
	if Globales.Flecha_Apolo == false:
		var Orfeo_Detectar = Zona_Derectar.Individuo
		if Orfeo_Detectar != null:
			var Interpolacion = Orfeo.create_tween()
			Interpolacion.tween_property(Orfeo,"current_position", null ,0)
			Interpolacion.tween_property(Orfeo,"position", Vector2(15,300), 4)
			Bordes.visible = true
			Orfeo_Tree.active = false
			Orfeo_Ani_Play.play("Caminar_Abajo")
			Colision_Detectat.disabled = true
			Bordes_Ani_Play.play("Abrir")
			if Globales.Flecha_Apolo == false:
				Flecha_Ani_Play.play("Flecha")
			
	else:
		Flecha_Ani_Play.play("Flecha_Enterrada")
		
	if Orfeo.position.y >= 290:
		var Interpolacion = Orfeo.create_tween()
		Interpolacion.stop()
		if Cinematica == true:
			Orfeo_Tree.active = true
			Orfeo_Ani_Play.stop(true)
			Bordes_Ani_Play.play("Cerrar")
			Cinematica = false
			Colision_Pergamino.disabled = false
			
			
	var Orfeo_Techo = Detectar_Orfeo_Techo.Individuo
	if Orfeo_Techo != null:
		Techo_Templo_Apolo.visible = false
	else:
		Techo_Templo_Apolo.visible = true
		
	if Globales.Tragedia_Apolo_Caliope == true:
		Pergamino.visible = false
		Colision_Pergamino.disabled = true
		Colision_Tragedia.disabled = true
		
		
func Persistencia_Flecha():
	
	Globales.Flecha_Apolo = true
	
func _on_zona_detectar_body_entered(_body):
	Transicion_Suave.Escena = "res://Archivos/Mundo/Carontes/Zona/Zona_Carontes.tscn"
	Transicion.play("Transicion")
	Orfeo_Estadisticas.Contador_Puertas = 1


func _on_musica_timeout():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambiente"), Globales.Musica_Fondo)
