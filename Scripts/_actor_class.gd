extends KinematicBody2D

var vida = 1 * global.enemy_life_multiplier
var velocidade = 4500
var dano = 1 * global.enemy_damage_multiplier
onready var particulas_preload = preload("res://Scenes/particulas_comida.tscn")
onready var area_preload = preload("res://Scenes/shameless_bugfix.tscn")
onready var timer_preload = preload("res://Scenes/timer_5s.tscn")
var movimento = Vector2()
var direcao_da_rotacao = 1
var contador = 0
var fade_in = true

func _ready():
	if fade_in == true:
		$Sprite.modulate.a = 0
	
	if $Sprite.get_frame() != 3:
		randomize()
		$Sprite.set_scale(Vector2(rand_range(0.95, 1.05), rand_range(0.95, 1.05)))
	
	set_physics_process(false)
	add_to_group('enemy')
	
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
#	print("Causou dano! Vida restante: " + str(vida))
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
		global.pontos += 20 + round(global.fase_em_que_o_jogador_esta*1.4)
	else:
		$snd_hit.play()

func _physics_process(delta):
#	var tela = OS.window_size
#	if (self.global_position.x > tela.x or self.global_position.x < 0) or (self.global_position.y > tela.y or self.global_position.y < 0):
#		print('hm')
#		contador += delta
#		if contador >= delta * 50:
#			self.queue_free()
		
	
#	if self.global_position.y > OS.window_size.y + 100:
#		queue_free()
	
	var cor = get_modulate()
	cor.a -= 0.015
	set_modulate( cor )
		
	global_translate(movimento * delta - get_parent().direcao * get_parent().velocidade * delta)
	rotate(direcao_da_rotacao * delta)
	movimento += Vector2(0, 10)
	pass

