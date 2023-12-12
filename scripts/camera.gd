extends Camera3D

var Camera_Tween
var Follow_Tween

var Camera_Zoom
@export var Max_Zoom: int = 20
@export var Min_Zoom: int = 5
@export var Zoom_Increment: int = 1
@export var Follow_Target: Node3D
@export var Offset: float = 1.5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Camera_Zoom = position.y
	rotation.x = deg_to_rad(-90)+atan(Offset/position.y)

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_in"):
		Camera_Zoom = max(Camera_Zoom-Zoom_Increment,Min_Zoom)
		Zoom_Tweem(Camera_Zoom)
	if event.is_action_pressed("scroll_out"):
		Camera_Zoom = min(Camera_Zoom+Zoom_Increment, Max_Zoom)
		Zoom_Tweem(Camera_Zoom)

func _process(_delta: float) -> void:
	if Follow_Target:
		if Follow_Tween:
			Follow_Tween.kill()
			
		Follow_Tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		Follow_Tween.tween_property(self,"position:x",Follow_Target.get_position().x,.5)
		Follow_Tween.parallel().tween_property(self,"position:z",Follow_Target.get_position().z+Offset,.5)

func Zoom_Tweem(zoom: int)->void:
	if Camera_Tween:
		Camera_Tween.kill()
	
	Camera_Tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	Camera_Tween.tween_property(self,"position:y",zoom,1)
	Camera_Tween.parallel().tween_property(self,"rotation:x",deg_to_rad(-90)+atan(Offset/position.y),1)

