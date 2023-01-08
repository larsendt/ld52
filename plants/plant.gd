extends Node2D
class_name Plant

func _ready():
    var count = $AnimatedSprite2D.frames.get_frame_count("default")
    var offset = randi_range(0, count)
    $AnimatedSprite2D.frame += offset
