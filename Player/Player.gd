extends KinematicBody2D

enum {
	MOVE,
	ROLE,
	ATTACK
}

export var speed: = Vector2(300.0, 300.0)
var _velocity: = Vector2.ZERO
var state: = MOVE

onready var player_anim : AnimationPlayer = $AnimationPlayer
onready var animation_tree: AnimationTree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _ready() -> void:
	animation_tree.active = true
	
func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			move_state()
		ROLE:
			pass
		ATTACK:
			attack_state()




func move_state() -> void:
	var direction : = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	
	if direction != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", direction)
		animation_tree.set("parameters/Run/blend_position", direction)
		animation_tree.set("parameters/Attack/blend_position", direction)
		animation_state.travel("Run")
	else:
		animation_state.travel("Idle")
	_velocity = move_and_slide(_velocity)
	if Input.is_action_just_pressed("Attack"):
		state = ATTACK

func attack_state() -> void:
	_velocity = Vector2.ZERO
	animation_state.travel("Attack")
	


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var out : = linear_velocity
	out.x = speed.x * direction.x
	out.y = speed.y * direction.y
	return out
	
func attack_animation_finnished() -> void:
	state = MOVE

