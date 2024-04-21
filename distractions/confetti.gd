extends Control


var confetti = preload("res://distractions/confetti_pieces.tscn")
var amount = 0


func _ready() -> void:
	amount = random_amount()
	spawn_confetti(amount)


func _process(delta: float) -> void:
	if $Pieces.get_child_count() == 0:
		queue_free()
		get_tree().paused = false


func random_amount():
	randomize()
	var random_amount = int(randf_range(5,10))
	randomize()
	return random_amount


func spawn_confetti(amount):
	for i in range(amount):
		var confetti_instance = confetti.instantiate()
		$Pieces.add_child(confetti_instance)
		confetti_instance.position = Vector2(randf_range(0,1920), randf_range(0,1080))
	
