extends Node2D

var Obolos_Minimos:int = 0
var Obolos_Maximos:int = 3
var Probabilidades: Array = [10,50,30,10]

@export var Area_Aparicion: Rect2 


const  Obolo = preload("res://Archivos/Interfaz_Usuario/Recogibles/Obolo/Obolo.tscn")

func _ready():
	
	var Numero_Obolos = Asignar_Probabilidades(Probabilidades) + Obolos_Minimos
	for i in range(Numero_Obolos):
		var Obolos = Obolo.instantiate()
		add_child(Obolos)
		Obolos.position = Vector2(randf_range(Area_Aparicion.position.x, Area_Aparicion.position.x + Area_Aparicion.size.x),randf_range(Area_Aparicion.position.y, Area_Aparicion.position.y + Area_Aparicion.size.y))
		
		
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
