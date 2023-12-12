extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_forward()

func move_forward():
	get_tree().create_tween().tween_property(self,"position:x", (get_viewport().size.x/5)*4,1)
