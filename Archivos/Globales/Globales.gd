extends Node
#############################################################################################################
################################################### Generales ###############################################
#############################################################################################################

var Matar_Enemigos = false
var Curar = true

#############################################################################################################
################################################### Canciones ###############################################
#############################################################################################################

var Adagio_Amor = false
var Aletheia = false
var Aria_Hermes = false
var Preludio = false

#############################################################################################################
################################################### Tragedia  ###############################################
#############################################################################################################

var Tragedia = 0
var Tragedia_Carontes = false
var Tragedia_Apolo_Caliope = false
var Texto:String

############################################################################################################
#################################################### Items  ################################################
#############################################################################################################

var Rama_Dorara = false

#############################################################################################################
################################################ Valores de Escena ##########################################
#############################################################################################################

########## Zona Carontes ##########
var Puerta_Secreta = 0
var Flecha_Apolo = false
var Dialogo_Sibila = true
var Rama_Dorada_Item = false
var Carontes_Pelea = true
var Caronte_Vivo = true
var Salir_Arena = 0
var Dialogo_Caronte = true
var Dialogo_Hermes_1 = true
var Ir_Mundo_2 = false

#############################################################################################################
################################################### Preferencias #############################################
#############################################################################################################

var Configuracion = ConfigFile.new()
############## Generales ###############
var Idioma = "en"
var Multplicador_Lesion = 1
##############  Video    ################
var Pantalla = Window.MODE_WINDOWED
var Resolucion = Vector2i (1280, 720)
############### Audio ###################
var Sonido_Global = 0
var Musica_Fondo = -14
var Efectos_Sonido = -6
var Audio_Canciones = -10
var Musica_Menu_Principal = 0


func _ready():
	
	Cambiar_Idioma()
	Cambiar_Pantalla()
	Cambiar_Resolucion()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
func _process(_delta):
	
	Salir_Arena = clamp(Salir_Arena,0,10)
	
	if Tragedia == 1:
		Tragedia_Carontes = true
	elif Tragedia == 2:
		Tragedia_Apolo_Caliope = true
	
	
func Cambiar_Idioma():
	
	TranslationServer.set_locale(Idioma)
	
	
func Cambiar_Pantalla(): 
	
	get_window().mode = Pantalla
	
	
func Cambiar_Resolucion():
	
	get_window().size = Resolucion
	
