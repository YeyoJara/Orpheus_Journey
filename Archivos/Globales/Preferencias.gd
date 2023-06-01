extends Node


var Configuracion = ConfigFile.new()
var error = Configuracion.load(Ruta_Configuracion)

const  Ruta_Configuracion = "config.cfg"


func _ready():
	
	if error != OK:
		Guardar_Configuracion()
	else:
		Cargar_Configuracion()
		
		
func Guardar_Configuracion():
	Configuracion.set_value("Generales", "Multiplicacion_Lesion", Globales.Multplicador_Lesion)
	Configuracion.set_value("Generales", "Idioma", Globales.Idioma)
	Configuracion.set_value("Video", "Pantalla", Globales.Pantalla)
	Configuracion.set_value("Video", "Resolucion", Globales.Resolucion)
	Configuracion.set_value("Audio", "Sonido_Global", Globales.Sonido_Global)
	Configuracion.set_value("Audio", "Musica_Fondo", Globales.Musica_Fondo)
	Configuracion.set_value("Audio", "Efectos_Sonido", Globales.Efectos_Sonido)
	Configuracion.set_value("Audio", "Audio_Canciones", Globales.Audio_Canciones)
	Configuracion.set_value("Audio", "Musica_Menu_Principal", Globales.Musica_Menu_Principal)
	Configuracion.save(Ruta_Configuracion)
	
func Cargar_Configuracion():
	
	if Configuracion.has_section_key("Generales", "Multiplicacion_Lesion"):
		Globales.Multplicador_Lesion = Configuracion.get_value("Generales", "Multiplicacion_Lesion")
	else :
		Guardar_Configuracion()
		
	if Configuracion.has_section_key("Generales", "Idioma"):
		Globales.Idioma = Configuracion.get_value("Generales", "Idioma")
	else:
		Guardar_Configuracion()
		
	if Configuracion.has_section_key("Video", "Pantalla"):
		Globales.Pantalla = Configuracion.get_value("Video", "Pantalla")
	else:
		Guardar_Configuracion()
		
	if Configuracion.has_section_key("Video", "Resolucion"):
		Globales.Resolucion = Configuracion.get_value("Video", "Resolucion")
	else:
		Guardar_Configuracion()
		
	if Configuracion.has_section_key("Audio", "Sonido_Global"):
		Globales.Sonido_Global = Configuracion.get_value("Audio", "Sonido_Global")
	else:
		Guardar_Configuracion()
		
	if Configuracion.has_section_key("Audio", "Musica_Fondo"):
		Globales.Sonido_Global = Configuracion.get_value("Audio", "Musica_Fondo")
	else:
		Guardar_Configuracion()
		
	if Configuracion.has_section_key("Audio", "Efectos_Sonido"):
		Globales.Sonido_Global = Configuracion.get_value("Audio", "Efectos_Sonido")
	else:
		Guardar_Configuracion()
		
	if Configuracion.has_section_key("Audio", "Audio_Canciones"):
		Globales.Sonido_Global = Configuracion.get_value("Audio", "Audio_Canciones")
	else:
		Guardar_Configuracion()
		
	if Configuracion.has_section_key("Audio", "Musica_Menu_Principal"):
		Globales.Sonido_Global = Configuracion.get_value("Audio", "Musica_Menu_Principal")
	else:
		Guardar_Configuracion()
