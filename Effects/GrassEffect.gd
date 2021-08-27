extends Node2D

onready var animation: = $GrassEffectAnimation

func _ready() -> void:
	animation.frame = 0
	animation.play("AttackEffect")

func _on_GrassEffectAnimation_animation_finished() -> void:
	queue_free()
