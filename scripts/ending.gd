extends Control

func _ready():
    $Label.text = "HARVEST FESTIVAL COMPLETO\nNo puedes cambiar tu destino."
    $Button.text = "Repetir final"

func _on_Button_pressed():
    get_tree().change_scene_to_file("res://scenes/Ending.tscn")