extends Node2D

# Variaveis
var direcao = Vector2(1, 1)
var velocidade = Vector2(450, 1) * global.enemy_speed_multiplier/8
var entrando = true
var angulo = 0
var margem = 100
var raio = 0

func _ready():
	randomize()
	set_physics_process(true)
	velocidade += global.dificuldade_em_vetor*2
	velocidade.x = min(abs(velocidade.x), 400) * sign(velocidade.x)
	velocidade.y = 0#min(velocidade.y, 3)
	pass

func _physics_process(delta):
	for node in get_children():
		if node.is_in_group('enemy'):
			if node.fade_in:
				if node.get_node('Sprite').modulate.a <= 1.1:
					node.get_node('Sprite').modulate.a += 0.05
				else:
					node.fade_in = false
	
	if self.global_position.x >= margem and self.global_position.x <= OS.window_size.x - margem and entrando:
		entrando = false
	
	if entrando == false:
		raio += 0.05
#		rotate( (2*PI) * delta * global.dificuldade/6)
		rotate( min((2*PI) * delta * global.dificuldade/6, (2*PI) * delta * 0.5))
		for node in get_children():
			if node.is_in_group('enemy'):
				randomize()
				node.translate( node.position.normalized() * raio * delta)#Vector2(rand_range(0.1, 2.0), rand_range(0.1, 2.0)).normalized() * raio * delta)
				node.rotate( - min((2*PI) * delta * global.dificuldade/6, (2*PI) * delta * 0.5))
	

	
	global_translate(direcao * velocidade * delta)# * Vector2(3*(sin(0.05*angulo*global.enemy_speed_multiplier) + 1), 1 ))
	
	
	
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
