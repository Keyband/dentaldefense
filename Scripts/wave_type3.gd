extends Node2D

# Variaveis
var direcao = Vector2(1, 1)
var velocidade = Vector2(550, 1) * global.enemy_speed_multiplier/5
var entrando = true
var margem = 200

onready var timer1 = get_node('timer_para_parar')
onready var timer2 = get_node('timer_para_cair_com_tudo')

func _ready():
	randomize()
	velocidade += global.dificuldade_em_vetor
	set_physics_process(true)
	randomize()
	timer1.set_wait_time(max(rand_range(6.0, 15.5) * (1/global.dificuldade) , 1.2))
	timer1.start()
	timer1.one_shot = true
#	velocidade.x = min(velocidade.x, 400)
	velocidade.x = min(abs(velocidade.x), 400) * sign(velocidade.x)
	velocidade.y = min(velocidade.y, 10)*(sign(randi()%2 - 0.5))
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
	
	global_translate(direcao * velocidade * delta )

	if get_child_count() <= 3:
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

func _on_timer_para_parar_timeout():
	self.velocidade = Vector2()
	timer2.set_wait_time(rand_range(1.0, 2.5))
	timer2.start()
	timer2.one_shot = true
	pass # replace with function body

func _on_timer_para_cair_com_tudo_timeout():
	if self.global_position < OS.window_size/2:
		self.velocidade = Vector2(0, rand_range(150, 300)).rotated(rand_range(-deg2rad(15),deg2rad(15)))
	else:
		self.velocidade = Vector2(0, rand_range(150, -300)).rotated(rand_range(-deg2rad(15),deg2rad(15)))
	pass # replace with function body



