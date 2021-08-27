extends Node2D




func attackEffect() -> void:
	var GrassEffect: = load("res://Effects/GrassEffect.tscn")
	var grassEffect = GrassEffect.instance()
	var world = get_tree().current_scene
	world.add_child(grassEffect)
	grassEffect.global_position = global_position
	queue_free()
	 

func _on_Hitbox_area_entered(area: Area2D) -> void:
	attackEffect()
