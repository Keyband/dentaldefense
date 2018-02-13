extends Area2D

#Variaveis
var vida = global.vida_do_dente
onready var sprite = get_node('Sprite')
onready var particulas_do_dente_preload = preload("res://Scenes/po_dos_dentes.tscn")
onready var particulas_do_dente_small_preload = preload("res://Scenes/po_dos_dentes_small.tscn")

var frames_do_sprite = [0, 4, 8, 12]
var frames_do_dente = []

#Sinais
#signal atingido

func _ready():
	for index in frames_do_sprite:
		frames_do_dente.append($Sprite.get_frame() + index)
	
	frames_do_sprite = frames_do_dente
	add_to_group('teeth')
	add_to_group('tooth')
	add_user_signal('atingido')
	
	if vida >24:
		#Dentes de ouro:
		sprite.set_frame(frames_do_sprite[2])
		pass
	elif vida > 8:
		#Dentes de titanio:
		sprite.set_frame(frames_do_sprite[3])
		pass
	elif vida > 4:
		#Dentes de calcio (no momento, igual a titanio)
		sprite.set_frame(frames_do_sprite[0])
		pass
	elif vida > 2:
		#Clareamento, igual ao normal eu acho
		sprite.set_frame(frames_do_sprite[0])
		pass
	elif vida > 1:
		#Dentes normais
		sprite.set_frame(frames_do_sprite[0])
		pass
	elif vida > 0:
		#Dentes amarelados
		sprite.set_frame(frames_do_sprite[1])
		pass
		
#	frames_do_sprite = frames_do_sprite + [sprite.get_frame(), sprite.get_frame(), sprite.get_frame(), sprite.get_frame()]
#	for num in frames_do_sprite:
#		frames_do_sprite[num] = num + sprite.get_frame()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _levar_dano(dano):
	
	emit_signal('atingido')
	vida -= dano
	if global.particulas == true:
		var particulas_small = particulas_do_dente_small_preload.instance()
		particulas_small.global_position = self.global_position
		particulas_small.set_emitting(true)
		get_tree().get_current_scene().get_node('gengiva').add_child(particulas_small)
	
	if vida >= 0:
		$snd_hit.play()
	else:
		$snd_destruido.play()
	
#	if vida == 3: #Para o 'clareamento'
#		sprite.set_frame(0)
	#Tiers de vida: 0, 1, 2, 4, 8, 24, 120?
	
	if vida >24:
		#Dentes de ouro:
		sprite.set_frame(frames_do_sprite[2])
		pass
	elif vida > 8:
		#Dentes de titanio:
		sprite.set_frame(frames_do_sprite[3])
		pass
	elif vida > 4:
		#Dentes de calcio (no momento, igual a titanio)
		sprite.set_frame(frames_do_sprite[0])
		pass
	elif vida > 2:
		#Clareamento, igual ao normal eu acho
		sprite.set_frame(frames_do_sprite[0])
		pass
	elif vida > 1:
		#Dentes normais
		sprite.set_frame(frames_do_sprite[0])
		pass
	elif vida > 0:
		#Dentes amarelados
		sprite.set_frame(frames_do_sprite[1])
		pass
	elif vida <= 0:
#		queue_free()
		self.set_visible(false)
		$CollisionShape2D.set_disabled(true)

		global.numero_de_dentes -= 1
		if global.particulas == true:
			var particulas = particulas_do_dente_preload.instance()
			particulas.global_position = self.global_position
			particulas.set_emitting(true)
			get_tree().get_current_scene().get_node('gengiva').add_child(particulas)
		
		if global.numero_de_dentes <= 0:
			get_tree().get_current_scene().game_over()
	
#	if vida > 24:
#		sprite.set_frame( sprite.get_frame() )
#	elif vida == 2:
#		sprite.set_frame(0)
#	elif vida == 1:
#		sprite.set_frame(1)
#	elif vida == 0:
#		queue_free()
#		global.numero_de_dentes -= 1
#		if global.numero_de_dentes <= 0:
##			get_parent().game_over()
#			get_tree().get_current_scene().game_over()
	
	

func _on_tooth_body_entered( body ):
	if body.is_in_group('enemy'):
		_levar_dano(body.dano)
		body.queue_free()
	pass # replace with function body
