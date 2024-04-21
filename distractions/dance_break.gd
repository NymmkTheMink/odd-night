extends Control

@onready var target = get_node("Target")

var score = 0
var target_score

var choices = {
	"left": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_arrow_left.png",
	"right": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_arrow_right.png",
	"up": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_arrow_up.png",
	"down": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_arrow_down.png",
}


func _ready() -> void:
	target_score = random_target_score()
	print(target_score)


func random_target_score():
	randomize()
	var random_score = int(randf_range(5,10))
	randomize()
	return random_score


func _process(delta: float) -> void:
	if score == target_score:
		queue_free()
		get_tree().paused = false


func _set_target_tex():
	randomize()
	var size = choices.size()
	var random_key = choices.keys()[randi() % size]
	var btn_texture = choices[random_key]
	randomize()
	target.texture = ResourceLoader.load(btn_texture)


func _on_left_pressed() -> void:
	if "left" in target.texture.resource_path:
		score += 1
	_set_target_tex()


func _on_up_pressed() -> void:
	if "up" in target.texture.resource_path:
		score += 1
	_set_target_tex()


func _on_down_pressed() -> void:
	if "down" in target.texture.resource_path:
		score += 1
	_set_target_tex()


func _on_right_pressed() -> void:
	if "right" in target.texture.resource_path:
		score += 1
	_set_target_tex()


