extends KinematicBody2D

#Variaveis
var direcao_que_esta_apontando = Vector2(0, -1)
var contador_de_bombas = 0
var pode_atacar = true

var municao = 150
var municao_maxima = 150

onready var tiro_normal_preload = preload('res://Scenes/shot.tscn')
onready var tiro_chaser_preload = preload('res://Scenes/shot_chaser.tscn')
onready var tiro_spread_preload = preload('res://Scenes/shot_spread.tscn')

onready var timer_para_poder_atacar_de_novo = get_node('timer_para_poder_atacar_de_novo')
#Constantes
const VELOCIDADE_MAXIMA = 15000

func _ready():
	self.add_to_group('player')
	set_physics_process(true)
	pass

func _physics_process(delta):
	if direcao_que_esta_apontando.y == 1:
#		$Sprite.set_flip_v(true)
		self.set_rotation(PI)
		$Sprite.set_flip_h(true)
	else:
		self.set_rotation(0)
		$Sprite.set_flip_h(false)
#		$Sprite.set_flip_v(false)

	### Movimento ###
	var movimento = Vector2()
	if Input.is_action_pressed('ui_left'):
		movimento += Vector2( -1, 0)
	if Input.is_action_pressed('ui_right'):
		movimento += Vector2( 1, 0)
	if Input.is_action_pressed('ui_up'):
		movimento += Vector2( 0, -1)
	if Input.is_action_pressed('ui_down'):
		movimento += Vector2( 0, 1)
	
	move_and_slide(movimento.normalized() * VELOCIDADE_MAXIMA * delta)
#	global_translate( movimento.normalized() * VELOCIDADE_MAXIMA * delta)


	### Ataque ###
	if Input.is_action_pressed('ui_attack') and pode_atacar and municao >= 0:
		_ataque(delta)

	if Input.is_action_just_released('ui_attack'):
		pode_atacar = true


	### Flip ###
	if Input.is_action_just_pressed('ui_flip'):
		direcao_que_esta_apontando *= -1
		pass
	pass

	### Bomba ###
	if Input.is_action_just_pressed('ui_bomb') and contador_de_bombas > 0:
		contador_de_bombas -= 1
		for node in get_tree().get_nodes_in_group('enemy'):
			node.queue_free()

	### Debug ###
	if Input.is_action_just_pressed('ui_debug'):
#		get_parent()._initiate_wave()
#		get_tree().get_current_scene().tst('teste')
#		global.numero_de_dentes -= 1
		get_tree().get_current_scene().game_over()
#		get_parent().get_node('spawners/spawnerl')._spawn(2)

func _ataque(delta):
	pode_atacar = false
	timer_para_poder_atacar_de_novo.start()
	var tiro = null
	if global.tipo_do_tiro == 'normal':
		tiro = tiro_normal_preload.instance()
	elif global.tipo_do_tiro == 'chaser':
		tiro = tiro_chaser_preload.instance()
	elif global.tipo_do_tiro == 'spread':
		tiro = tiro_spread_preload.instance()

	tiro.direcao = self.direcao_que_esta_apontando
	var posicao_do_tiro = $topo_cima.global_position
#	var posicao_do_tiro =  Vector2()
#	if direcao_que_esta_apontando.y == 1:
#		posicao_do_tiro = $topo_baixo.global_position
#	else:
#		posicao_do_tiro = $topo_cima.global_position
	tiro.set_global_position( posicao_do_tiro )
	get_parent().add_child(tiro)
	
	municao -= 1
	_checar_municao()
	
	pass

func _on_timer_para_poder_atacar_de_novo_timeout():
	pode_atacar = true
#	timer_para_poder_atacar_de_novo.set_wait_time(0.35)
	pass # replace with function body

func _checar_municao():
	if municao >=  0.70 * municao_maxima:
		$Sprite.set_frame(0)
		$"0".set_disabled(false)
		$"1".set_disabled(true)
		$"2".set_disabled(true)
		$"3".set_disabled(true)
	elif municao >= 0.40 * municao_maxima:
		$Sprite.set_frame(1)
		$"0".set_disabled(true)
		$"1".set_disabled(false)
		$"2".set_disabled(true)
		$"3".set_disabled(true)
	elif municao >= 0.10 * municao_maxima:
		$Sprite.set_frame(2)
		$"0".set_disabled(true)
		$"1".set_disabled(true)
		$"2".set_disabled(false)
		$"3".set_disabled(true)
	else:
		$Sprite.set_frame(3)
		$"0".set_disabled(true)
		$"1".set_disabled(true)
		$"2".set_disabled(true)
		$"3".set_disabled(false)
	
	if municao <= 0:
		print('Municao acabou!')
	pass
