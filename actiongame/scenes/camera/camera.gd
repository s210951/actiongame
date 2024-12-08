extends Camera3D

const RAY_LENGTH = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var result = raycast_mouse(event.position)
		var player = get_tree().get_nodes_in_group("Player")[0]
		if "position" in result:
			player._on_move_towards(result.position)
		
	if Input.is_action_pressed("player_attack"):
		var result = raycast_mouse(event.position)
		# TODO: attack

func raycast_mouse(mouse: Vector2) -> Dictionary:
	var from = self.project_ray_origin(mouse)
	var to = from + self.project_ray_normal(mouse) * RAY_LENGTH
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	return  space_state.intersect_ray(query)
