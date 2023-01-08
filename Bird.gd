extends AnimatedSprite2D

func _ready():
    var frame_count = self.frames.get_frame_count("default")
    var frame_offset = randi() % frame_count
    self.frame += frame_offset