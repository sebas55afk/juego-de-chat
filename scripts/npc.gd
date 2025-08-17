extends Area3D
@export var npc_name := "Aldeano"
@export var contributes := 1
var player_in := false

func _ready():
    $Label3D.text = npc_name
    body_entered.connect(_on_body_entered)
    body_exited.connect(_on_body_exited)

func _process(_d):
    if player_in and Input.is_action_just_pressed("interact"):
        get_tree().get_first_node_in_group("Game").add_progress(contributes)
        get_tree().get_first_node_in_group("Game")._show(npc_name, "Listo.")

func _on_body_entered(b):
    if b.name == "Player":
        player_in = true
        get_tree().get_first_node_in_group("Game")._show(npc_name, "¿Me ayudas? Pulsa Enter.")

func _on_body_exited(b):
    if b.name == "Player":
        player_in = False