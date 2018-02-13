extends Node2D

# Variaveis
var direcao = Vector2(1, 1)
var velocidade = Vector2(650, 5) * global.enemy_speed_multiplier/5
var entrando = true
var margem = 375

func _ready():
	randomize()
	set_physics_process(true)
	velocidade += global.dificuldade_em_vetor*5
	velocidade.x = min(abs(velocidade.x), 500) * sign(velocidade.x)
	velocidade.y = min(velocidade.y, 15)*(sign(randi()%2 - 0.5))
	
func _physics_process(delta):
	for node in get_children():
		if node.is_in_group('enemy'):
			if node.fade_in:
				if node.get_node('Sprite').modulate.a <= 1.1:
					node.get_node('Sprite').modulate.a += 0.05
				else:
					node.fade_in = false
	
	if self.global_position.x >= margem and self.global_position.x <= OS.window_size.x - margem:
		entrando = false
		direcao.x *= -1
	
	global_translate(direcao * velocidade * delta)
	if get_child_count() <= 1:
		queue_free()
	pass


func _on_checker_body_entered( body ):
	if body.is_in_group('boundary'):
		if entrando:
			pass
#			entrando = false
		else:
			direcao *= Vector2(-1, 1)
	if body.is_in_group('killer_boundary'):
		self.queue_free()
	pass # replace with function body
