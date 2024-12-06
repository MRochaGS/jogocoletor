extends Area2D

var speed = -1000
var player_in_collision = false  # Variável de controle

func _on_animation_player_animation_finished(_anim_name : String):
	# Esta função ainda não está sendo usada, mas você pode implementar ações aqui
	pass

func _on_area_entered(area):
	if area.is_in_group("Player"):
		$AnimationPlayer.play("SwordCollected")
		$CollisionShape2D.call_deferred("set_disabled", true)
		player_in_collision = true  # Marca que o jogador entrou na colisão

func _physics_process(delta):
	if player_in_collision:  # Só permite o movimento após o jogador entrar na colisão
		position.y += speed * delta
