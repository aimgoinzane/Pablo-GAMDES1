extends Node

@export var mob_scene: PackedScene
var score

func _ready():
	pass

func game_over():
	$EnemyTimer.stop()
	$ScoreTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("The Zombies are Coming")
	get_tree().call_group("mobs", "queue_free")

func _on_enemy_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	
	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 500.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


func _on_start_timer_timeout() -> void:
	$EnemyTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout() -> void:
	score += 10
	$HUD.update_score(score)
