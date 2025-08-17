extends Node3D
class_name GameController

@onready var env: WorldEnvironment = $WorldEnvironment
@onready var ui_dialog: Label = $CanvasLayer/Dialog
@onready var ui_mission: Label = $CanvasLayer/Mission

var mission_index := 0
var missions := [
    {"text":"Recolecta 3 manzanas.", "count":3},
    {"text":"Entrega 2 troncos al granjero.", "count":2},
    {"text":"Atrapa la gallina perdida.", "count":1},
    {"text":"Trae 1 zorro... que no respire.", "count":1},
    {"text":"La campana debe sonar bajo la luna.", "count":1},
]

var collected := 0
var dark := false

func _ready():
    add_to_group("Game")
    _show("Granjero","Bienvenido al festival. Habla con los aldeanos (Enter).")
    _update_mission_text()

func _update_mission_text():
    if mission_index < missions.size():
        ui_mission.text = "Misión: %s  (%d/%d)" % [missions[mission_index]["text"], collected, missions[mission_index]["count"]]
    else:
        ui_mission.text = "Misión: —"

func _show(speaker:String, text:String):
    ui_dialog.text = "%s: %s" % [speaker, text]

func add_progress(n:=1):
    collected += n
    _update_mission_text()
    var need = missions[mission_index]["count"]
    if collected >= need:
        mission_index += 1
        collected = 0
        if mission_index == 3 and not dark:
            _go_dark()
        elif mission_index >= missions.size():
            _ending()
        else:
            _show("Granjero","Bien. %s" % missions[mission_index]["text"])
            _update_mission_text()

func _go_dark():
    dark = true
    _show("???","Sebastián... ¿por qué sigues jugando?")
    var e := env.environment
    e.background_color = Color(0.05,0.02,0.06)
    e.ambient_light_color = Color(0.1,0.0,0.1)
    e.fog_enabled = true
    e.fog_density = 0.02
    e.fog_aerial_perspective = 0.6
    ui_mission.add_theme_color_override("font_color", Color(1,0.2,0.2))
    ui_dialog.add_theme_color_override("font_color", Color(1,0.3,0.3))

func _ending():
    _show("Granjero","El festival se completó. No hay escapatoria.")
    get_tree().create_timer(3.0).timeout.connect(func():
        get_tree().change_scene_to_file("res://scenes/Ending.tscn")
    )