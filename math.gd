extends Control


@onready var option_1 = get_node("Option1")
@onready var option_2 = get_node("Option2")
@onready var option_3 = get_node("Option3")
@onready var option_4 = get_node("Option4")

var dance_break = preload("res://distractions/dance_break.tscn")
var confetti = preload("res://distractions/confetti.tscn")

var numbers = {
	"number0": "res://assets/kenney_input-prompts/Keyboard & Mouse/Default/keyboard_0.png",
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

var distractions = [dance_break, confetti]

var score = 0


func _ready():
	set_option_value(option_1,option_2,option_3,option_4)
	


func _process(delta: float):
	if score == 50:
		get_tree().change_scene_to_file("res://distractions/ending.tscn")


func get_random_texture():
	randomize()
	var size = numbers.size()
	var random_key = numbers.keys()[randi() % size]
	var texture = numbers[random_key]
	randomize()
	return texture

func set_option_value(option1,option2,option3,option4):
	var texture_1 = get_random_texture()
	var texture_2 = get_random_texture()
	var texture_3 = get_random_texture()
	var texture_4 = get_random_texture()
	
	if texture_1 == texture_2 or texture_1 == texture_3 or texture_1 == texture_4:
		texture_1 = get_random_texture()
	if texture_2 == texture_1 or texture_2 == texture_3 or texture_2 == texture_4:
		texture_1 = get_random_texture()
	if texture_3 == texture_2 or texture_3 == texture_1 or texture_3 == texture_4:
		texture_1 = get_random_texture()
	if texture_4 == texture_1 or texture_4 == texture_2 or texture_4 == texture_3:
		texture_1 = get_random_texture()
	
	option1.texture_normal = ResourceLoader.load(texture_1)
	option2.texture_normal = ResourceLoader.load(texture_2)
	option3.texture_normal = ResourceLoader.load(texture_3)
	option4.texture_normal = ResourceLoader.load(texture_4)


func get_option_value(option):
	var value
	
	if "0" in option:
		value = 0
	elif "1" in option:
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
		score += 1
	else:
		score -= 1
		
	set_option_value(option_1,option_2,option_3,option_4)


func _on_option_2_pressed() -> void:
	var option_2_tex = option_2.get_texture_normal().resource_path 
	
	if get_option_value(option_2_tex) % 2 == 1:
		score += 1
	else:
		score -= 1
	
	set_option_value(option_1,option_2,option_3,option_4)

func _on_option_3_pressed() -> void:
	var option_3_tex = option_3.get_texture_normal().resource_path 
	
	if get_option_value(option_3_tex) % 2 == 1:
		score += 1
	else:
		score -= 1
	
	set_option_value(option_1,option_2,option_3,option_4)


func _on_option_4_pressed() -> void:
	var option_4_tex = option_4.get_texture_normal().resource_path 
	
	if get_option_value(option_4_tex) % 2 == 1:
		score += 1
	else:
		score -= 1
	
	set_option_value(option_1,option_2,option_3,option_4)


func wait_time_randomizer():
	randomize()
	var random_time = int(randf_range(15,45))
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
