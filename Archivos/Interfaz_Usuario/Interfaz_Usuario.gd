extends Control

var Corazones = 5: set = Poner_Corazones, get = Quitar_Corazones
var Corazones_Maximos = 5: set = Poner_Corazones_Maximos, get = Quitar_Corazones_Maximos

var Reutilizables:int = 1: set = Poner_Reutilizables, get = Quitar_Reutilizables
var Reutilizables_Maximos:int = 1: set = Poner_Reutilizables_Maximos, get = Quitar_Reutilizables_Maximos

var Obolos:int = 0: set = Poner_Obolos, get = Quitar_Obolos
var Obolos_Maximos:int = 5: set = Poner_Obolos_Maximos, get = Quitar_Obolos_Maximos

@onready var Corazon_Vacio = $Barra_Vida/Corazon_Vacio
@onready var Corazon_Lleno = $Barra_Vida/Corzon_Lleno
@onready var Silencio_Corchea = $Barra_Reutilizable/Silencio_Corchea
@onready var Corchea = $Barra_Reutilizable/Corchea
@onready var Obolos_Ic = $Obolos
@onready var Contador_Obolos = $Obolos/Contador
@onready var Visualizador_Obolos = $Visualizar_Obolos


func _ready():
	
	self.Corazones_Maximos = Orfeo_Estadisticas.Vida_Maxima
	self.Corazones = Orfeo_Estadisticas.Vida
	Orfeo_Estadisticas.Vida_Cambia.connect(Poner_Corazones)
	Orfeo_Estadisticas.Vida_Maxima_Cambia.connect(Poner_Corazones_Maximos)
	
	self.Reutilizables_Maximos = Orfeo_Estadisticas.Reutilizables_Maximos
	self.Reutilizables = Orfeo_Estadisticas.Reutilizables
	Orfeo_Estadisticas.Reutilizables_Cambian.connect(Poner_Reutilizables)
	Orfeo_Estadisticas.Reutilizables_Maximos_Cambian.connect(Poner_Reutilizables_Maximos)
	
	
	self.Obolos_Maximos = Orfeo_Estadisticas.Obolos_Maximos
	self.Obolos = Orfeo_Estadisticas.Obolos
	Orfeo_Estadisticas.Obolos_Cambian.connect(Poner_Obolos)
	Orfeo_Estadisticas.Obolos_Maximos_Cambian.connect(Poner_Obolos_Maximos)
	
	Visualizador_Obolos.start()
	
	
func _process(_delta):
		
	if Input.is_action_just_pressed("ui_start"):
		Orfeo_Estadisticas.Visualizar_Obolos = true
		Visualizador_Obolos.stop()
#
	if Input.is_action_just_pressed("ui_cancel"):
		Visualizador_Obolos.start()
	
	if Orfeo_Estadisticas.Reutilizables == Orfeo_Estadisticas.Reutilizables_Maximos:
		Silencio_Corchea.visible = false
	else:
		Silencio_Corchea.set_deferred("visible", true)
	
	if Orfeo_Estadisticas.Visualizar_Obolos == true:
		Obolos_Ic.visible = true
	else:
		Obolos_Ic.visible = false
		
		
func Poner_Corazones (value):
	
	Corazones = clampf (value, 0 , Corazones_Maximos)
	if Corazon_Lleno != null:
		Corazon_Lleno.custom_minimum_size.x = Corazones * 16
		
		
func Quitar_Corazones():
	
	return Corazones
	
	
func Poner_Corazones_Maximos(value):
	
	Corazones_Maximos = maxf (value,1)
	self.Corazones = minf ( Corazones, Corazones_Maximos)
	if Corazon_Vacio != null:
		Corazon_Vacio.custom_minimum_size.x = Corazones_Maximos * 16
		
		
func Quitar_Corazones_Maximos():
	
		return Corazones_Maximos
		
		
func Poner_Reutilizables(value):
	Reutilizables = clampi(value, 0, Reutilizables_Maximos)
	if Corchea != null:
		Corchea.custom_minimum_size.x = Reutilizables * 22
		
		
func Quitar_Reutilizables():
	
	return Reutilizables
	
	
func Poner_Reutilizables_Maximos(value):
	
	Reutilizables_Maximos = maxi(value, 1)
	self.Reutilizables = mini (Reutilizables, Reutilizables_Maximos)
	if Silencio_Corchea != null: 
		Silencio_Corchea.custom_minimum_size.x = Reutilizables_Maximos * 22

		
func Quitar_Reutilizables_Maximos():
	
	return Reutilizables_Maximos
		
		
func Poner_Obolos(value):
	Obolos = clampi(value, 0, Obolos_Maximos)
	if Contador_Obolos != null:
		Contador_Obolos.text = "" + str(Obolos)
	
	
func Quitar_Obolos():
	
	return Obolos
	
	
func Poner_Obolos_Maximos(value):
	
	Obolos_Maximos = maxi(value,99999)
	
	
func Quitar_Obolos_Maximos():
	
	return Obolos_Maximos

func _on_visualizar_obolos_timeout():
	Orfeo_Estadisticas.Visualizar_Obolos = false
