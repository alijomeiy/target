extends Node2D

signal arrow_entered(area)

var added_list
var other_knife
var layer

func _ready():
	added_list = Array()
	other_knife = $OthersKnife
	layer = $PhysicArea.collision_layer

func _process(delta):
	rotation_degrees += 1

func _on_PhysicArea_area_entered(area):
	if area in added_list: 
		return
	emit_signal("arrow_entered", area)
	added_list.append(area)
	call_deferred("change_parent", area)
	
func change_parent(area):
	var area_parent = area.get_parent()
	var pos = area_parent.global_position
	var rot = area_parent.global_rotation
	var main_parent = area_parent.get_parent()
	main_parent.remove_child(area_parent)
	other_knife.add_child(area_parent)
	area_parent.global_position = pos
	area_parent.global_rotation = rot
