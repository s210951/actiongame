extends CharacterBody3D

var movement_speed: float = 10.0
var movement_delta: float
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

signal move_towards(position: Vector3)

func _on_move_towards(position: Vector3) -> void:
	navigation_agent.set_target_position(position)
	print("Distance: " + str(navigation_agent.distance_to_target()))

func _process(delta: float) -> void:
	movement_delta = movement_speed * delta
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity = global_position.direction_to(next_path_position) * movement_delta
	global_position = global_position.move_toward(global_position + new_velocity, movement_delta)
