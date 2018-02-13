extends Area2D

#Variaveis
var direcao_que_esta_apontando = Vector2(0, -1)
#var global.numero_de_bombas_que_o_jogador_tem = global.numero_de_bombas_do_jogador
var pode_atacar = true

var municao = 150
var municao_maxima = global.municao_maxima_do_jogador
var margem_em_y = 75

var frame_base = 0
var posicao_bot_da_vez = 0

onready var sprite_trail_preload = preload("res://Scenes/sprite_trail.tscn")
onready var tiro_preload = preload('res://Scenes/shot_standard.tscn')
#onready var tiro_normal_preload = preload('res://Scenes/shot.tscn')
#onready var tiro_chaser_preload = preload('res://Scenes/shot_chaser.tscn')
#onready var tiro_spread_preload = preload('res://Scenes/shot_spread.tscn')

onready var timer_para_poder_atacar_de_novo = get_node('timer_para_poder_atacar_de_novo')
#Constantes
#const VELOCIDADE_MAXIMA = 250
var VELOCIDADE_MAXIMA = global.velocidade_maxima_do_jogador

func _ready():
	$timer_para_poder_atacar_de_novo.set_wait_time(global.tempo_entre_tiros)
	self.add_to_group('player')
	set_physics_process(true)
	global.numero_de_bombas_que_o_jogador_tem = global.numero_de_bombas_do_jogador
	pass

func _physics_process(delta):
	
#	global.municao_do_jogador = municao
#	_checar_municao()
	_checar_sprite()
	if global.nivel_dos_upgrades['velocidade'] >= 1:
		var sprite_trail = sprite_trail_preload.instance()
		sprite_trail.set_texture( $Sprite.get_texture() )
		sprite_trail.set_scale( $Sprite.get_scale() )
		sprite_trail.set_hframes( $Sprite.get_hframes() )
		sprite_trail.set_vframes( $Sprite.get_vframes() )
		sprite_trail.set_frame( $Sprite.get_frame() )
		sprite_trail.global_position = $Sprite.global_position
		get_parent().add_child(sprite_trail)
	
	
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

#	move_and_slide(movimento.normalized() * VELOCIDADE_MAXIMA * delta)
	global_translate( movimento.normalized() * VELOCIDADE_MAXIMA * delta)
	self.global_position.y = clamp(self.global_position.y, margem_em_y, OS.window_size.y-margem_em_y)


	### Ataque ###
	if Input.is_action_pressed('ui_attack') and pode_atacar:# and municao > 0:
		_ataque(delta)
		if global.nivel_dos_upgrades['dualshot'] == 1:
			_ataque_bot(delta)

#	if Input.is_action_just_released('ui_attack'):
#		pode_atacar = true

	### Flip ###
	if Input.is_action_just_pressed('ui_flip'):
		direcao_que_esta_apontando *= -1
		pass
	pass

	### Bomba ###
	if Input.is_action_just_pressed('ui_bomb') and global.numero_de_bombas_que_o_jogador_tem > 0:
		get_parent().get_node('Camera2D').shake(1, 20, 12)
		global.numero_de_bombas_que_o_jogador_tem -= 1
		for node in get_tree().get_nodes_in_group('enemy'):
			node._causar_dano( node.vida )
		
#		if global.nivel_dos_upgrades['bomba'] >= 3:
#			for node in get_tree().get_nodes_in_group('tooth'):
#				node.vida += global.vida_do_dente/2
	
	if Input.is_action_just_pressed('ui_pause'):
		pass
	
	### Debug ###
	if Input.is_action_just_pressed('ui_debug'):
		global.pontos += 100
		for dente in get_tree().get_nodes_in_group('tooth'):
			dente._levar_dano(round(dente.vida * 0.5))
		pass
#		get_parent()._initiate_wave()
#		get_tree().get_current_scene().tst('teste')
#		global.numero_de_dentes -= 1
#		get_tree().get_current_scene().game_over()
#		get_parent().get_node('spawners/spawnerl')._spawn(2)

func _ataque(delta):
#	for node in get_tree().get_nodes_in_group('killer_boundary'):
#		print(str(node))
	$AudioStreamPlayer2D.play()
	pode_atacar = false
	timer_para_poder_atacar_de_novo.start()
	var tiro = tiro_preload.instance()
	tiro.direcao = self.direcao_que_esta_apontando
	tiro.global_position = $topo_cima.global_position
#	var tiro = tiro_preload.instance()
##	if global.tipo_do_tiro == 'normal':
##		tiro = tiro_normal_preload.instance()
##	elif global.tipo_do_tiro == 'chaser':
##		tiro = tiro_chaser_preload.instance()
##	elif global.tipo_do_tiro == 'spread':
##		tiro = tiro_spread_preload.instance()
#
#	tiro.direcao = self.direcao_que_esta_apontando
#	var posicao_do_tiro = $topo_cima.global_position
##	var posicao_do_tiro =  Vector2()
##	if direcao_que_esta_apontando.y == 1:
##		posicao_do_tiro = $topo_baixo.global_position
##	else:
##		posicao_do_tiro = $topo_cima.global_position
#	tiro.set_global_position( posicao_do_tiro )
	get_parent().add_child(tiro)

#	municao -= 1
#	_checar_municao()
	pass

func _ataque_bot(delta):
	pode_atacar = false
	timer_para_poder_atacar_de_novo.start()
	var tiro = tiro_preload.instance()
	tiro.direcao = -self.direcao_que_esta_apontando
	tiro.global_position = posicao_bot_da_vez
#	var tiro = tiro_preload.instance()
##	if global.tipo_do_tiro == 'normal':
##		tiro = tiro_normal_preload.instance()
##	elif global.tipo_do_tiro == 'chaser':
##		tiro = tiro_chaser_preload.instance()
##	elif global.tipo_do_tiro == 'spread':
##		tiro = tiro_spread_preload.instance()
#
#	tiro.direcao = self.direcao_que_esta_apontando
#	var posicao_do_tiro = $topo_cima.global_position
##	var posicao_do_tiro =  Vector2()
##	if direcao_que_esta_apontando.y == 1:
##		posicao_do_tiro = $topo_baixo.global_position
##	else:
##		posicao_do_tiro = $topo_cima.global_position
#	tiro.set_global_position( posicao_do_tiro )
	get_parent().add_child(tiro)

#	municao -= 1
#	_checar_municao()
	pass

func _on_timer_para_poder_atacar_de_novo_timeout():
	pode_atacar = true
	$timer_para_poder_atacar_de_novo.set_wait_time(global.tempo_entre_tiros)
#	timer_para_poder_atacar_de_novo.set_wait_time(0.35)
	pass # replace with function body

func _checar_municao():	
	municao_maxima = global.municao_maxima_do_jogador
#	if municao >=  0:#0.70 * municao_maxima:
	$Sprite.set_frame(frame_base)
	if frame_base >= 12:
		posicao_bot_da_vez = $topo_baixo.global_position
	$"0".set_disabled(false)
	$"1".set_disabled(true)
	$"2".set_disabled(true)
	$"3".set_disabled(true)
#	elif municao >= 0.40 * municao_maxima:
#		$Sprite.set_frame(frame_base + 1)
#		if frame_base >= 12:
#			posicao_bot_da_vez = $topo_baixo2.global_position
#		$"0".set_disabled(true)
#		$"1".set_disabled(false)
#		$"2".set_disabled(true)
#		$"3".set_disabled(true)
#	elif municao >= 0.10 * municao_maxima:
#		$Sprite.set_frame(frame_base + 2)
#		if frame_base >= 12:
#			posicao_bot_da_vez = $topo_baixo3.global_position
#		$"0".set_disabled(true)
#		$"1".set_disabled(true)
#		$"2".set_disabled(false)
#		$"3".set_disabled(true)
#	else:
#		$Sprite.set_frame(frame_base + 3)
#		if frame_base >= 12:
#			posicao_bot_da_vez = $topo_baixo4.global_position
#		$"0".set_disabled(true)
#		$"1".set_disabled(true)
#		$"2".set_disabled(true)
#		$"3".set_disabled(false)

#	if municao <= 0:
##		print('Municao acabou!')
#		municao = 0
	pass

func _on_player_body_entered( body ):
	if body.is_in_group('boundaryl'):
		self.global_position.x = OS.window_size.x
	elif body.is_in_group('boundaryr'):
		self.global_position.x = 0
		pass
	pass # replace with function body

func _checar_sprite():
	if global.nivel_dos_upgrades['dualshot'] == 0:
		if global.nivel_dos_upgrades['moreshots'] == 0:
			frame_base = 0
		elif global.nivel_dos_upgrades['moreshots'] == 1:
			frame_base = 4
		elif global.nivel_dos_upgrades['moreshots'] == 2:
			frame_base = 8
#		$Sprite.set_visible(true)
	elif global.nivel_dos_upgrades['dualshot'] == 1:
		if global.nivel_dos_upgrades['moreshots'] == 0:
			frame_base = 12
		elif global.nivel_dos_upgrades['moreshots'] == 1:
			frame_base = 16
		elif global.nivel_dos_upgrades['moreshots'] == 2:
			frame_base = 20
			
	$Sprite.set_frame(frame_base)
#		$Sprite.set_visible(false)
#		$Sprite2.set_visible(true)











