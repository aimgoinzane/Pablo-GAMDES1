extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng:= RandomNumberGenerator.new()
	var rand_scale_factor := randf_range(0.26, 0.50)
	var path: String = "res://Assets/Sprites/zombie" + str(rng.randi_range(1,2)) + ".png"
	$Sprite2D.texture = load(path)
	var num_scale = Vector2(rand_scale_factor, rand_scale_factor)
	$Sprite2D.scale = num_scale
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
