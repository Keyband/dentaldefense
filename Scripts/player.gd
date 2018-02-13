extends KinematicBody2D

#Variaveis
var direcao_que_esta_apontando = Vector2(0, 1)
var contador_de_bombas = 3
var pode_atacar = true

onready var tiro_normal_preload = preload('res://Scenes/shot.tscn')
onready var tiro_chaser_preload = preload('res://Scenes/shot_chaser.tscn')
onready var tiro_spread_preload = preload('res://Scenes/shot_spread.tscn')

onready var timer_para_poder_atacar_de_novo = get_node('timer_para_poder_atacar_de_novo')
#Constantes
const VELOCIDADE_MAXIMA = 12000

func _ready():
	self.add_to_group('player')
	set_physics_process(true)
	pass

func _physics_process(delta):
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
	
	move_and_slide( movimento.normalized() * VELOCIDADE_MAXIMA * delta)
	
	
	### Ataque ###
	if Input.is_action_pressed('ui_attack') and pode_atacar:
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
		get_parent().get_node('spawnerl')._spawn(2)

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
	tiro.set_global_position( self.get_global_position() )
	get_parent().add_child(tiro)
	pass

func _on_timer_para_poder_atacar_de_novo_timeout():
	pode_atacar = true
#	timer_para_poder_atacar_de_novo.set_wait_time(0.35)
	pass # replace with function body
