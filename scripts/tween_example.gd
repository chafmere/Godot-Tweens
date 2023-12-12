extends Node3D

@onready var icon: Sprite3D = $icon
@onready var camera_3d: Camera3D = $Camera3D

@onready var ship: Node3D = $ship



var Icon_Tween

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_intersetion = Get_Camera_Collision()
		
		if not mouse_intersetion.is_empty():
			if Icon_Tween:
				Icon_Tween.kill()
			Icon_Tween = get_tree().create_tween()
			Icon_Tween.tween_property(icon,"position",mouse_intersetion.position,.01)

		
	if event.is_action_pressed("left_click"):
		var mouse_intersection = Get_Camera_Collision()
		if not mouse_intersection.is_empty():
			Move_Ship(mouse_intersection.position)
		
func Move_Ship(pos: Vector3)->void:
	var ship_tween = get_tree().create_tween()
	var direction = ship.global_position.direction_to(pos)
	var angle = atan2(direction.x, direction.z)
	
	ship_tween.tween_property(ship,"scale",Vector3(1.5,1.5,1.5),.1)
	ship_tween.tween_property(ship,"scale",Vector3(1,1,1),.1)
	
	ship_tween.set_trans(Tween.TRANS_LINEAR).tween_property(ship,"position", pos,1)
	ship_tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).parallel().tween_method(ship.set_rotation,ship.get_rotation(),Vector3(0,angle,0),.3)


func Get_Camera_Collision()->Dictionary:
	var mouse_position = get_viewport().get_mouse_position()
	var ray_origin = camera_3d.project_ray_origin(mouse_position)
	var ray_end = ray_origin + camera_3d.project_ray_normal(mouse_position)*100
	
	var new_intersection = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var intersection = get_world_3d().direct_space_state.intersect_ray(new_intersection)
	
	return intersection
