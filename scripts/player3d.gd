extends CharacterBody3D

@export var speed := 5.0
@export var jump_velocity := 6.0
var gravity := ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
    var input_dir = Vector2(
        Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
        Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    )
    var dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    if not is_on_floor():
        velocity.y -= gravity * delta
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity
    velocity.x = dir.x * speed
    velocity.z = dir.z * speed
    move_and_slide()