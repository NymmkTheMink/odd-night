extends Control

var target = 1
var score = 0
var target_score

var active_target_color = Color(0,1,0,1)
var inactive_target_color = Color(1,1,1,0.5)

@onready var target_1 = %Target1
@onready var target_2 = %Target2
@onready var target_3 = %Target3
@onready var target_4 = %Target4

var choices = {
	"left": 3,
	"right": 4,
	"up": 2,
	"down": 1,
}


func _ready() -> void:
	target_score = random_target_score()
	_set_target()


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
		if target == 3:
			$Correct.play()
			score += 1
			target_3.modulate = inactive_target_color
			_set_target()
	elif Input.is_action_just_pressed("right"):
		if target == 4:
			$Correct.play()
			score += 1
			target_4.modulate = inactive_target_color
			_set_target()
	elif Input.is_action_just_pressed("up"):
		if target == 2:
			$Correct.play()
			score += 1
			target_2.modulate = inactive_target_color
			_set_target()
	elif Input.is_action_just_pressed("down"):
		if target == 1:
			$Correct.play()
			score += 1
			target_1.modulate = inactive_target_color
			_set_target()


func _set_target():
	randomize()
	var size = choices.size()
	var random_key = choices.keys()[randi() % size]
	var target_number = choices[random_key]
	randomize()
	
	match target_number:
		1:
			target_1.modulate = active_target_color
		2:
			target_2.modulate = active_target_color
		3:
			target_3.modulate = active_target_color
		4:
			target_4.modulate = active_target_color
	target = target_number
