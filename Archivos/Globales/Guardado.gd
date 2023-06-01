extends Node


var Datos_Juego = {}
const  Clave = "Orfeo_Muere"
const Ruta_Guardado = "savefile.json"

func Guardar_Datos():
	
	Datos_Juego = {
	############################# Orfeo ###############################
	"Escena": get_tree().current_scene.scene_file_path,
	"Contador_Puertas": Orfeo_Estadisticas.Contador_Puertas,
	"Obolos": Orfeo_Estadisticas.Obolos,
	############################ Canciones ############################
	"Adagio_Amor": Globales.Adagio_Amor,
	"Aletheia": Globales.Aletheia,
	"Aria_Hermes": Globales.Aria_Hermes,
	"Preludio": Globales.Preludio,
	############################# Tragedia #############################
	"Tragedia_Carontes": Globales.Tragedia_Carontes,
	"Tragedia_Apolo_Caliope": Globales.Tragedia_Apolo_Caliope,
	############################## Items ###############################
	"Rama_Dorada": Globales.Rama_Dorara,
	############################## Mundo ###############################
	"Flecha_Apolo": Globales.Flecha_Apolo,
	"Dialogo_Sibila": Globales.Dialogo_Sibila,
	"Caronte_Pelea": Globales.Carontes_Pelea,
	"Caronte_Vivo": Globales.Caronte_Vivo,
	"Caronte_Dialogo": Globales.Dialogo_Caronte,
	"Hermes_Dialogo_1": Globales.Dialogo_Hermes_1,
	}
	var json_string = JSON.stringify(Datos_Juego)
	var Archivo = FileAccess.open_encrypted_with_pass(Ruta_Guardado, FileAccess.WRITE, Clave)
	Archivo.store_string(json_string)
	Archivo.close()
	
	
func Cargar_Datos():
	
	if FileAccess.file_exists(Ruta_Guardado):
		var Archivo = FileAccess.open_encrypted_with_pass(Ruta_Guardado, FileAccess.READ, Clave)
		var json_string = Archivo.get_as_text()
		Archivo.close()
		Datos_Juego = JSON.parse_string(json_string)
		################################ Orfeo ###################################
		Orfeo_Estadisticas.Escena = Datos_Juego["Escena"]
		Orfeo_Estadisticas.Contador_Puertas = Datos_Juego["Contador_Puertas"]
		Orfeo_Estadisticas.Obolos_Maximos = Datos_Juego["Obolos"]
		############################### Canciones ##################################
		Globales.Adagio_Amor = Datos_Juego["Adagio_Amor"]
		Globales.Aletheia = Datos_Juego["Aletheia"]
		Globales.Aria_Hermes = Datos_Juego["Aria_Hermes"]
		Globales.Preludio = Datos_Juego["Preludio"]
		################################ Tragedia ###################################
		Globales.Tragedia_Carontes = Datos_Juego["Tragedia_Carontes"]
		Globales.Tragedia_Apolo_Caliope = Datos_Juego["Tragedia_Apolo_Caliope"]
		################################## Items ####################################
		Globales.Rama_Dorara = Datos_Juego["Rama_Dorada"]
		################################## Mundo ####################################
		Globales.Flecha_Apolo = Datos_Juego["Flecha_Apolo"]
		Globales.Dialogo_Sibila = Datos_Juego["Dialogo_Sibila"]
		Globales.Carontes_Pelea = Datos_Juego["Caronte_Pelea"]
		Globales.Caronte_Vivo = Datos_Juego["Caronte_Vivo"]
		Globales.Dialogo_Caronte = Datos_Juego["Caronte_Dialogo"]
		Globales.Dialogo_Hermes_1 = Datos_Juego["Hermes_Dialogo_1"]
		
func Limpiar_Datos():
	
	################################ Orfeo ###################################
	Orfeo_Estadisticas.Contador_Puertas = 0
	Orfeo_Estadisticas.Obolos_Maximos = 0
	Orfeo_Estadisticas.Vida_Maxima = 5
	Orfeo_Estadisticas.Reutilizables_Maximos = 1
	############################### Canciones ##################################
	Globales.Adagio_Amor = false
	Globales.Aletheia = false
	Globales.Aria_Hermes = false
	Globales.Preludio = false
	################################ Tragedia ###################################
	Globales.Tragedia = 0
	Globales.Tragedia_Carontes = false
	Globales.Tragedia_Apolo_Caliope = false
	################################## Items ####################################
	Globales.Rama_Dorara = false
	################################## Mundo ####################################
	Globales.Flecha_Apolo = false
	Globales.Dialogo_Sibila = true
	Globales.Carontes_Pelea = true
	Globales.Caronte_Vivo = true
	Globales.Dialogo_Caronte = true
	Globales.Dialogo_Hermes_1 = true
