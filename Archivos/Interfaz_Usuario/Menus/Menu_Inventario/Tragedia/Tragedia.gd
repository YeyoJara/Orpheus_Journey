extends CanvasLayer


@onready var Tragedia_Ani_Play = $Tragedia_Ani_Play
@onready var Tragedia_Orfeo = $Tragedia_Orfeo

var Texto = Globales.Texto

func _ready():
	
	get_tree().paused = true
	self.process_mode =Node.PROCESS_MODE_ALWAYS
	
	Tragedia_Ani_Play.play("Abrir")
	Tragedia_Orfeo.text = Texto	
	
	
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		Tragedia_Ani_Play.play("Cerrar")
		get_tree().paused = false
		
		
func Cerrar():
	queue_free()
