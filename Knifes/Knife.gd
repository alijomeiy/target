extends Node2D

signal knife_move_started

export var id: int
export var speed: float

var state
var target
var direction
var key_pressed_id

func _ready():
	state = "begin"
	target = get_node("../Target")
	target.connect("arrow_entered", self, "_on_Target_arrow_entered")
	key_pressed_id = "shoot_" + str(id)
	direction = target.global_position - global_position
	direction = direction.normalized()
	
func _process(delta):
	if state == "begin":
		begin()
	elif state == "move":
		move(delta)

func begin():
	if Input.is_action_just_pressed(key_pressed_id):
		state = "move"
		print ("change state to move!")
		emit_signal("knife_move_started")

func move(delta):
	position += direction * speed * delta

func _on_Target_arrow_entered(area):
	if area == $Area2D:
		state = "collide"

func _on_Area2D_area_entered(area):
	print("target:", target.layer, " --- area: ", area.collision_layer)
	if target.layer == area.collision_layer:
		return
	print(area.name)
	print("game over!")
