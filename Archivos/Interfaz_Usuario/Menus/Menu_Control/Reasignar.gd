extends Button

var Evento_Teclado = InputEventKey.new()
var Evento_Mando = InputEventJoypadButton.new()
var Evento_Analogo = InputEventJoypadMotion.new()

@export var Accion: String = "ui_shoot"
@export var Entrada_Teclado = KEY_I
@export var Entrada_Mando = JOY_BUTTON_Y
@export var Entrada_Analogo = JOY_AXIS_TRIGGER_LEFT
@export var Direccion_Analogo = 0


func _ready():
	
	Evento_Teclado.keycode = Entrada_Teclado
	
	Evento_Mando.button_index = Entrada_Mando
	InputMap.action_add_event(Accion, Evento_Mando)
	
	Evento_Analogo.axis = Entrada_Analogo
	Evento_Analogo.axis_value = Direccion_Analogo
	InputMap.action_add_event(Accion, Evento_Analogo)
	
	assert(InputMap.has_action(Accion))
	set_process_unhandled_key_input(false)
	Mostrar_Tecla_Actual()
	
	
func _toggled(Boton_Precionado):
	
	set_process_unhandled_key_input(Boton_Precionado)
	if Boton_Precionado:
		text = "..."
		release_focus()
	else:
		Mostrar_Tecla_Actual()
		
		
func _unhandled_key_input(event):
	
	Reasignar_Accion(event)
	button_pressed = false
	
	
func Reasignar_Accion(event):
	
	InputMap.action_erase_events(Accion)
	InputMap.action_add_event(Accion, event)
	InputMap.action_add_event(Accion, Evento_Mando)
	InputMap.action_add_event(Accion, Evento_Analogo)
	Persistencia_Entrada.Mapas_Entrada[Accion] = event
	Persistencia_Entrada.Guardar_Mapa_Entrada()
	text = "%s" % event.as_text()
	
	
func Mostrar_Tecla_Actual():
	
	var Tecla_Actual = InputMap.action_get_events(Accion)[0].as_text()
	text = "%s" % Tecla_Actual
	
	
func Reiniciar_Valores_Entrada():
	
	InputMap.action_erase_events(Accion)
	InputMap.action_add_event(Accion, Evento_Teclado)
	InputMap.action_add_event(Accion, Evento_Mando)
	InputMap.action_add_event(Accion, Evento_Analogo)
	Persistencia_Entrada.Mapas_Entrada[Accion] = Evento_Teclado
	Persistencia_Entrada.Guardar_Mapa_Entrada()
	Mostrar_Tecla_Actual()
