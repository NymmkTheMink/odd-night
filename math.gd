extends Control


@onready var option_1 = get_node("Option1")
@onready var option_2 = get_node("Option2")
@onready var option_3 = get_node("Option3")
@onready var option_4 = get_node("Option4")

var dance_break = preload("res://distractions/dance_break.tscn")
var confetti = preload("res://distractions/confetti.tscn")

var numbers = {
	"number1": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_1.png",
	"number2": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_2.png",
	"number3": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_3.png",
	"number4": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_4.png",
	"number5": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_5.png",
	"number6": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_6.png",
	"number7": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_7.png",
	"number8": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_8.png",
	"number9": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_9.png",
}

var odd_numbers = {
	"number1": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_1.png",
	"number3": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_3.png",
	"number5": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_5.png",
	"number7": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_7.png",
	"number9": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_9.png",
}

var even_numbers = {
	"number2": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_2.png",
	"number4": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_4.png",
	"number6": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_6.png",
	"number8": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_8.png",
}

var distractions = [dance_break, confetti]

var score = 0


func _ready():
	set_option_value(option_1,option_2,option_3,option_4)
	wait_time_randomizer()
	
	get_tree().paused = true


func _process(delta: float):
	$ProgressBar.value = score
	$TimeleftBar.value = $Timer.time_left
	if score == 50:
		$Win.visible = true
		get_tree().paused = true
	


func get_random_even_texture():
	randomize()
	var size = even_numbers.size()
	var random_key = even_numbers.keys()[randi() % size]
	var texture = even_numbers[random_key]
	randomize()
	return texture

func get_random_odd_texture():
	randomize()
	var size = odd_numbers.size()
	var random_key = odd_numbers.keys()[randi() % size]
	var texture = odd_numbers[random_key]
	randomize()
	return texture


func set_option_value(option1, option2, option3, option4):
	# Initialize texture variables
	var textures = [null, null, null, null]

	# Randomize and choose a random index for the odd texture
	randomize()
	var odd_index = randi() % textures.size()

	# Assign a random odd texture to the chosen index
	textures[odd_index] = get_random_odd_texture()

	# Create a list of available even textures
	var available_even_textures = even_numbers.values()

	# Assign random even textures to the remaining indices
	for i in range(textures.size()):
		if textures[i] == null:
			randomize()
			var even_index = randi() % available_even_textures.size()
			textures[i] = available_even_textures[even_index]
			available_even_textures.remove_at(even_index)

	# Assign the textures to the options
	option1.texture_normal = ResourceLoader.load(textures[0])
	option2.texture_normal = ResourceLoader.load(textures[1])
	option3.texture_normal = ResourceLoader.load(textures[2])
	option4.texture_normal = ResourceLoader.load(textures[3])



func get_option_value(option):
	var value
	
	if "1" in option:
		value = 1
	elif "2" in option:
		value = 2
	elif "3" in option:
		value = 3
	elif "4" in option:
		value = 4
	elif "5" in option:
		value = 5
	elif "6" in option:
		value = 6
	elif "7" in option:
		value = 7
	elif "8" in option:
		value = 8
	else:
		value = 9
	
	return value


func _on_option_1_pressed() -> void:
	var option_1_tex = option_1.get_texture_normal().resource_path 
	if get_option_value(option_1_tex) % 2 == 1:
		$Correct.play()
		score += 1
	else:
		score -= 1
		
	set_option_value(option_1,option_2,option_3,option_4)


func _on_option_2_pressed() -> void:
	var option_2_tex = option_2.get_texture_normal().resource_path 
	
	if get_option_value(option_2_tex) % 2 == 1:
		$Correct.play()
		score += 1
	else:
		score -= 1
	
	set_option_value(option_1,option_2,option_3,option_4)

func _on_option_3_pressed() -> void:
	var option_3_tex = option_3.get_texture_normal().resource_path 
	
	if get_option_value(option_3_tex) % 2 == 1:
		$Correct.play()
		score += 1
	else:
		score -= 1
	
	set_option_value(option_1,option_2,option_3,option_4)


func _on_option_4_pressed() -> void:
	var option_4_tex = option_4.get_texture_normal().resource_path 
	
	if get_option_value(option_4_tex) % 2 == 1:
		$Correct.play()
		score += 1
	else:
		score -= 1
	
	set_option_value(option_1,option_2,option_3,option_4)


func wait_time_randomizer():
	randomize()
	var random_time = int(randf_range(10,30))
	randomize()
	$DistractionTimer.wait_time = random_time



func _on_distraction_timer_timeout() -> void:
	randomize()
	var size = distractions.size()
	var random_distraction = distractions[randi() % size]
	var distranction_instance = random_distraction.instantiate()
	$Distraction.add_child(distranction_instance)
	randomize()
	
	get_tree().paused = true
	wait_time_randomizer()


func _on_start_pressed() -> void:
	$Start.visible = false
	$Timer.start()
	get_tree().paused = false


func _on_replay_pressed() -> void:
	get_tree().reload_current_scene()


func _on_timer_timeout() -> void:
	$Lose.visible = true
	get_tree().paused = true
