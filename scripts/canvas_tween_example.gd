extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.mouse_entered.connect(scale_button.bind(child))
		child.mouse_exited.connect(return_scale_button.bind(child))
		child.pivot_offset = (child.size)/2

func scale_button(button)->void:
	var scale_tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	scale_tween.tween_property(button,"scale",Vector2(1.1,1.1),.1)


func return_scale_button(button)->void:
	var scale_tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	scale_tween.tween_property(button,"scale",Vector2(1,1),.1)
