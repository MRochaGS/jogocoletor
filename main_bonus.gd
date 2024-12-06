extends Node

@export var coin : PackedScene
@export var confetti : PackedScene

var min_positions : Vector2 = Vector2(20, 176)
var max_positions : Vector2 = Vector2(520, 756)
var level : int = 1
var game_over : bool
var health : float = 10000
var healthinimigo : float = 10000
var decrease_health_speed : float = 1500

func _process(delta):
	if health > 0:
		health -= delta * decrease_health_speed
		$UI/HealthBar.value = health
		$UI/InimigoLife.value = healthinimigo
	else:
		$GameOver.show()
		game_over = true

func _ready():
	instantiate_coins()

func level_passed() -> void:
	health = 10000
	level += 1
	$UI/LevelLabel.text = "Level: " + str(level)
	instantiate_coins()
	instantiate_confetti()
	
func instantiate_coins() -> void:
	for i in range(level):
		var coin_instance : Area2D = coin.instantiate()
		var random_x : float = randf_range(min_positions.x, max_positions.x)
		var random_y : float = randf_range(min_positions.y, max_positions.y)
		coin_instance.position = Vector2(random_x, random_y)
		call_deferred("add_child", coin_instance)

func instantiate_confetti() -> void:
	var confetti_instance : CPUParticles2D = confetti.instantiate()
	add_child(confetti_instance)
	confetti_instance.emitting = true;


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		healthinimigo -= 10000
	if healthinimigo == 0:
		get_tree().quit()
