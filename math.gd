extends Control


@onready var option_1 = get_node("%Option1")
@onready var option_2 = get_node("%Option2")
@onready var option_3 = get_node("%Option3")
@onready var option_4 = get_node("%Option4")
@onready var option_5 = get_node("%Option5")


var dance_break = preload("res://distractions/dance_break.tscn")
var confetti = preload("res://distractions/confetti.tscn")

var odd_numbers = {
	"number1": preload("uid://cqenbfvfk6yhf"),
	"number3": preload("uid://ckd33ijkpndg6"),
	"number5": preload("uid://cd2klcchfohas"),
	"number7": preload("uid://c5gi13mp7co44"),
	"number9": preload("uid://dabk1qcff5k22"),
}

var even_numbers = {
	"number2": preload("uid://bo6o5eynogvqb"),
	"number4": preload("uid://rothdfhdpum7"),
	"number6": preload("uid://bbqxixxvmebg2"),
	"number8": preload("uid://bul0e33asvmmf"),
}

var distractions = [dance_break, confetti]

var score = 0


func _ready():
	set_option_value(option_1,option_2,option_3,option_4, option_5)
	wait_time_randomizer()
	
	get_tree().paused = true


func _process(delta: float):
	$%ProgressBar.value = score
	$%TimeleftBar.value = $%Timer.time_left
	if score == 25:
		$%Win.visible = true
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


func set_option_value(option1, option2, option3, option4, option5):
	# Initialize texture variables
	var textures = [null, null, null, null, null]

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
	option1.texture_normal = textures[0]
	option2.texture_normal = textures[1]
	option3.texture_normal = textures[2]
	option4.texture_normal = textures[3]
	option5.texture_normal = textures[4]




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
		$%Correct.play()
		score += 1
	else:
		score -= 1
		
	set_option_value(option_1,option_2,option_3,option_4,option_5)


func _on_option_2_pressed() -> void:
	var option_2_tex = option_2.get_texture_normal().resource_path 
	
	if get_option_value(option_2_tex) % 2 == 1:
		$%Correct.play()
		score += 1
	else:
		score -= 1
	
	set_option_value(option_1,option_2,option_3,option_4,option_5)

func _on_option_3_pressed() -> void:
	var option_3_tex = option_3.get_texture_normal().resource_path 
	
	if get_option_value(option_3_tex) % 2 == 1:
		$%Correct.play()
		score += 1
	else:
		score -= 1
	
	set_option_value(option_1,option_2,option_3,option_4,option_5)


func _on_option_4_pressed() -> void:
	var option_4_tex = option_4.get_texture_normal().resource_path 
	
	if get_option_value(option_4_tex) % 2 == 1:
		$%Correct.play()
		score += 1
	else:
		if score > 0:
			score -= 1
	
	set_option_value(option_1,option_2,option_3,option_4,option_5)


func _on_option_5_pressed() -> void:
	var option_5_tex = option_5.get_texture_normal().resource_path 
	
	if get_option_value(option_5_tex) % 2 == 1:
		$%Correct.play()
		score += 1
	else:
		if score > 0:
			score -= 1
	
	set_option_value(option_1,option_2,option_3,option_4,option_5)

func wait_time_randomizer():
	randomize()
	var random_time = int(randf_range(5,15))
	randomize()
	$%DistractionTimer.wait_time = random_time



func _on_distraction_timer_timeout() -> void:
	randomize()
	var size = distractions.size()
	var random_distraction = distractions[randi() % size]
	var distranction_instance = random_distraction.instantiate()
	$%Distraction.add_child(distranction_instance)
	randomize()
	
	get_tree().paused = true
	wait_time_randomizer()


func _on_start_pressed() -> void:
	$%Start.visible = false
	$%Timer.start()
	get_tree().paused = false


func _on_replay_pressed() -> void:
	get_tree().reload_current_scene()


func _on_timer_timeout() -> void:
	$%Lose.visible = true
	get_tree().paused = true
