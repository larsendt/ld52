extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -350.0

@export var fall_trigger_time: float = 0.5
@export var default_extra_jump_frames: float = 8

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var accumulated_fall_time = 0
var extra_jump_frames = default_extra_jump_frames

func _physics_process(delta):
    if is_on_floor():
        accumulated_fall_time = 0
        extra_jump_frames = default_extra_jump_frames
    else:
        velocity.y += gravity * delta
        accumulated_fall_time += delta
        # do this with time instead of frames?
        extra_jump_frames -= 1
        if extra_jump_frames < 0:
            extra_jump_frames = 0

    if Input.is_action_just_pressed("jump") and (is_on_floor() or extra_jump_frames > 0):
        velocity.y = JUMP_VELOCITY

    var direction = Input.get_axis("move_left", "move_right")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    if velocity.length() > 0 and is_on_floor():
        $AnimatedSprite2D.play("walk")
    elif accumulated_fall_time > fall_trigger_time:
        $AnimatedSprite2D.play("fall")
    else:
        $AnimatedSprite2D.play("idle")

    move_and_slide()
