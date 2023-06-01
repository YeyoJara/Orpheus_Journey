extends Node2D

var Enemigos_Minimos: int = 0
var Enemigos_Maximos: int = 5
var Probabilidades: Array = [0,100]

@export var Area_Aparicion: Rect2

var Enemigo_1 = preload("res://Archivos/Enemigos/Esqueletos/Esqueleto_Arquero/Esqueleto_Arquero.tscn")
var Enemigo_2 = preload("res://Archivos/Enemigos/Esqueletos/Esqueleto_Lancero/Esqueleto_Lancero.tscn")
var Enemigo_3 = preload("res://Archivos/Enemigos/Esqueletos/Esqueleto_Medio/Esqueleto_Medio.tscn")


func _ready():
	
	Globales.Salir_Arena += 3
	
	var Numero_Enemigos = Asignar_Probabilidades(Probabilidades) + Enemigos_Minimos
	for i in range(Numero_Enemigos):
		var Enemigos_1 = Enemigo_1.instantiate()
		call_deferred("add_child", Enemigos_1)
		Enemigos_1.position = Vector2(randf_range(Area_Aparicion.position.x, Area_Aparicion.position.x + Area_Aparicion.size.x),randf_range(Area_Aparicion.position.y, Area_Aparicion.position.y + Area_Aparicion.size.y))
		var Enemigos_2 = Enemigo_2.instantiate()
		call_deferred("add_child", Enemigos_2)
		Enemigos_2.position = Vector2(randf_range(Area_Aparicion.position.x, Area_Aparicion.position.x + Area_Aparicion.size.x),randf_range(Area_Aparicion.position.y, Area_Aparicion.position.y + Area_Aparicion.size.y))
		var Enemigos_3 = Enemigo_3.instantiate()
		call_deferred("add_child", Enemigos_3)
		Enemigos_3.position = Vector2(randf_range(Area_Aparicion.position.x, Area_Aparicion.position.x + Area_Aparicion.size.x),randf_range(Area_Aparicion.position.y, Area_Aparicion.position.y + Area_Aparicion.size.y))
		
		
func Asignar_Probabilidades(Posibilidades):
	
	var Posibilidad_Total = 0
	for Posibilidad in Posibilidades:
		Posibilidad_Total += Posibilidad
	var Valor_Aleatorio = randi_range(0, Posibilidad_Total)
	var Crear_Posibilidades = 0
	for i in range(Posibilidades.size()):
		Crear_Posibilidades += Probabilidades[i]
		if Valor_Aleatorio < Crear_Posibilidades:
			return i
	return Probabilidades.size() - 1
