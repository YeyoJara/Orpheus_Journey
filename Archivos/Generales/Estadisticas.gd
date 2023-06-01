extends Node


var Contador_Puertas = 0
var Escena 
var Multiplicador_Lesion_Recibida = 1
var Visualizar_Obolos = true

@export var Vida_Maxima: float = 5: set = Poner_Vida_Maxima, get = Quitar_Vida_Maxima
var Vida: float = Vida_Maxima: set = Poner_Vida, get = Quitar_Vida

var Reutilizables_Maximos:int = 1: set = Poner_Reutilizables_Maximos, get = Quitar_Reutilizables_Maximos
var Reutilizables:int = Reutilizables_Maximos: set = Poner_Reutilizables, get = Quitar_Reutilizables

var Obolos_Maximos:int = 0: set = Poner_Obolos_Maximos, get = Quitar_Obolos_Maximos
var Obolos:int = Obolos_Maximos: set = Poner_Obolos, get = Quitar_Obolos


signal Sin_Vida
signal Vida_Cambia (value)
signal Vida_Maxima_Cambia (value)
signal Reutilizables_Cambian(value)
signal Reutilizables_Maximos_Cambian(value)
signal  Obolos_Cambian (value)
signal  Obolos_Maximos_Cambian(value)
	
	
func _ready():
	
	self.Vida = Vida_Maxima
	self.Reutilizables = Reutilizables_Maximos
	
	
func Poner_Vida_Maxima(value):
	
	Vida_Maxima = value
	self.Vida = minf (Vida, Vida_Maxima)
	Vida_Maxima_Cambia.emit(Vida_Maxima)
	
	
func Quitar_Vida_Maxima ():
	
	return Vida_Maxima
	
	
func  Poner_Vida(value):
	
	Vida = value
	Vida_Cambia.emit(Vida)
	if Vida <=0:
		Sin_Vida.emit()
		
		
func Quitar_Vida():
	
	return Vida
	
	
func Poner_Reutilizables_Maximos(value):
	
	Reutilizables_Maximos = value
	self.Reutilizables = mini (Reutilizables, Reutilizables_Maximos)
	Reutilizables_Maximos_Cambian.emit(Reutilizables_Maximos)
	
func Quitar_Reutilizables_Maximos():
	
	return Reutilizables_Maximos
	
	
func Poner_Reutilizables(value):
	
	Reutilizables = value
	Reutilizables_Cambian.emit(Reutilizables)
	
	
func Quitar_Reutilizables():
	
	return Reutilizables
	
	
func Poner_Obolos_Maximos(value):
	
	Obolos_Maximos = value
	self.Obolos = mini(Obolos, Obolos_Maximos)
	Obolos_Maximos_Cambian.emit(Obolos_Maximos)
	
	
func Quitar_Obolos_Maximos():
	
	return Obolos_Maximos
	
	
func Poner_Obolos(value):
	
	Obolos = value
	Obolos_Cambian.emit(Obolos)
	
	
func Quitar_Obolos():
	
	return Obolos
	
	
func Asignar_Valores():
	self.Obolos = Obolos_Maximos
	self.Vida = Vida_Maxima
	self.Reutilizables = Reutilizables_Maximos
