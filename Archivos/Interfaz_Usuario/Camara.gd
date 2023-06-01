extends Camera2D


@onready var Abajo_Derecha = $Abajo_Derecha
@onready var Arriba_Izquierda = $Arriba_Izquierda
var Contador = 1


func _ready():
	
	limit_bottom = Abajo_Derecha.position.y
	limit_right = Abajo_Derecha.position.x
	limit_top = Arriba_Izquierda.position.y
	limit_left = Arriba_Izquierda.position.x
