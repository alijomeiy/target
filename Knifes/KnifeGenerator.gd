extends Node2D

var knife_scene
var parent

func _ready():
	knife_scene = preload("res://Knifes/Knife.tscn")
	parent = get_parent()
	instantiate_knife()

func instantiate_knife():
	var knife_instance = knife_scene.instance()
	parent.call_deferred("add_child", knife_instance)
	knife_instance.global_position = global_position

func _on_Target_arrow_entered(area):
	instantiate_knife()
