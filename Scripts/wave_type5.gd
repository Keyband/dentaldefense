extends KinematicBody2D

var vida = 1 * global.enemy_life_multiplier
var velocidade = Vector2(400, 1) * global.enemy_speed_multiplier/6
var dano = 1 * global.enemy_damage_multiplier
onready var particulas_preload = preload("res://Scenes/particulas_comida.tscn")
onready var area_preload = preload("res://Scenes/shameless_bugfix.tscn")
onready var timer_preload = preload("res://Scenes/timer_5s.tscn")
var movimento = Vector2()
var direcao_da_rotacao = 1
var contador = 0
var pode_explodir = false
var fade_in = true
var margem = 150
var entrando = true


func _ready():
	$Sprite.modulate.a = 0
	randomize()
	var eu = self
	$Timer.set_wait_time(rand_range(4.5, 8.5))
	$Timer.connect('timeout', self, 'acabou_o_tempo')#get_parent())
	$Timer.start()
	
	if $Sprite.get_frame() != 3:
		randomize()
		$Sprite.set_scale(Vector2(rand_range(0.95, 1.05), rand_range(0.95, 1.05)))
	
	velocidade = Vector2(400, 1) * global.enemy_speed_multiplier/6
	vida = 4 * global.enemy_life_multiplier
	add_to_group('enemy')
	velocidade += global.dificuldade_em_vetor*5
	set_physics_process(true)

#	timer1.set_wait_time(max(rand_range(2.0, 3.5) * (1/global.dificuldade) , 1.2))
#	timer1.start()
#	timer1.one_shot = true
#	velocidade.x = min(velocidade.x, 250)
	velocidade.x = min(abs(velocidade.x), 275) * sign(velocidade.x)
	velocidade.y = min(velocidade.y, rand_range(3,13))*(sign(randi()%2 - 0.5))
	pass


	var area = area_preload.instance()
	area.position = Vector2()
	add_child(area)

	var timer = timer_preload.instance()
	timer.connect('timeout', self, 'que_esteja_dentro_da_area')
	add_child(timer)
	
func que_esteja_dentro_da_area():
	var tela = OS.window_size
	if (self.global_position.x > tela.x or self.global_position.x < 0) or (self.global_position.y > tela.y or self.global_position.y < 0):
		self.queue_free()

func _causar_dano(dano):
	if global.particulas == true:
		var particulas = particulas_preload.instance()
		particulas.set_global_position(self.get_global_position())
		particulas.set_emitting(true)
		get_tree().get_current_scene().add_child(particulas)
	print("Causou dano! Vida restante: " + str(vida))
	vida -= dano
	if vida <= 0:
		$snd_destruido.play()
		randomize()
		self.remove_from_group('enemy')
		$CollisionShape2D.set_disabled(true)
		self.set_physics_process(true)
		self.direcao_da_rotacao = sign(rand_range(-1, 1))
		movimento = Vector2(rand_range(-100, 100), rand_range(-100, -300))
#		self.set_owner(get_tree().get_current_scene())
#		add_to_group(self.get_name())
#		get_tree().get_current_scene().move_child get_nodes_in_group(self.get_name())[0]
		global.pontos += 20
	else:
		$snd_hit.play()

var alvo = self

# Variaveis
var direcao = Vector2(1, 1)

var colidiu = false
#var margem = 200

onready var cookie_preload = preload("res://Scenes/wave_patterns/wave4.tscn")



func _physics_process(delta):
	if self.global_position.x >= margem and self.global_position.x <= OS.window_size.x - margem and entrando:
		entrando = false
	
	if self.fade_in:
		if self.get_node('Sprite').modulate.a <= 1.1:
			self.get_node('Sprite').modulate.a += 0.05
		else:
			self.fade_in = false
	
	if self.vida <= 0:
		var cor = get_modulate()
		cor.a -= 0.015
		set_modulate( cor )
			
		global_translate(movimento * delta)
		rotate(direcao_da_rotacao * delta)
		movimento += Vector2(0, 10).rotated(rand_range(-PI/10, PI/10))
		pass
	else:
		if pode_explodir:
			var cookie = cookie_preload.instance()
			cookie.global_position = self.global_position
			cookie.colidiu = true
			cookie.rotate(rand_range(PI/8, PI/2))
			for node in cookie.get_children():
				if node.is_in_group('enemy'):
					node.fade_in = false
					
			get_tree().get_current_scene().add_child(cookie)
			self.queue_free()
	#		for node in get_children():
	#			if node.is_in_group('enemy'):
	#				node.translate( node.position.normalized() * 450 * delta)
	#			pass
			pass
		else:
			if self.global_position.x >= margem and self.global_position.x <= OS.window_size.x - margem:
				entrando = false
			
			global_translate(direcao * velocidade * delta )
		
	#		rotate( (PI/8) * delta * global.dificuldade/6)
			rotate( - min((2*PI) * delta * global.dificuldade/6, (2*PI) * delta * 0.02))
			
#		if get_child_count() <= 1:
#			queue_free()
	pass

func acabou_o_tempo():
	pode_explodir = true

func _on_checker_body_entered( body ):
	if body.is_in_group('boundary'):
		if entrando:
			pass
#			entrando = false
		else:
			direcao *= Vector2(-1, 1)
			if colidiu == false:
				colidiu = true
	if body.is_in_group('killer_boundary'):
		self.queue_free()
	pass # replace with function body

#func _on_timer_para_parar_timeout():
#	self.velocidade = Vector2()
#	timer2.set_wait_time(rand_range(1.0, 2.5))
#	timer2.start()
#	timer2.one_shot = true
#	pass # replace with function body
#
#func _on_timer_para_cair_com_tudo_timeout():
#	if self.global_position < OS.window_size/2:
#		self.velocidade = Vector2(0, rand_range(250, 550))
#	else:
#		self.velocidade = Vector2(0, rand_range(250, -550))
#	pass # replace with function body



