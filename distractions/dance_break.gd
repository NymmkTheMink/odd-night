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
	
	if Input.is_action_just_pressed("left"):
		if "left" in target.texture.resource_path:
			$Correct.play()
			score += 1
			_set_target_tex()
	elif Input.is_action_just_pressed("right"):
		if "right" in target.texture.resource_path:
			$Correct.play()
			score += 1
			_set_target_tex()
	elif Input.is_action_just_pressed("up"):
		if "up" in target.texture.resource_path:
			$Correct.play()
			score += 1
			_set_target_tex()
	elif Input.is_action_just_pressed("down"):
		if "down" in target.texture.resource_path:
			$Correct.play()
			score += 1
			_set_target_tex()


func _set_target_tex():
	randomize()
	var size = choices.size()
	var random_key = choices.keys()[randi() % size]
	var btn_texture = choices[random_key]
	randomize()
	target.texture = ResourceLoader.load(btn_texture)
