extends Node2D

#Variaveis
var lista_de_posicoes = []
var lista_de_dentes = []
var dente_preload = preload('res://Scenes/tooth.tscn')
onready var lista_de_sons = [get_node('snd_1'), get_node('snd_2')]

func _ready():
	for posicao in get_children():
		lista_de_posicoes.append(posicao)
	
	for num_dente in range(global.numero_de_dentes):
		var dente = dente_preload.instance()
		var correcao = 0
		if lista_de_posicoes[num_dente].global_position.y < OS.window_size.y/2:
			correcao = +30
		else:
			correcao = -30
		dente.global_position = lista_de_posicoes[num_dente].global_position + Vector2(0, correcao)
		dente.add_to_group('tooth')
		
		var sprite_do_dente = 0
		var vflip = false
		var numdente = num_dente + 1
		
		if numdente in [1, 2]:
			sprite_do_dente = 0
		elif numdente in [3, 4, 5, 8]:
			sprite_do_dente = 2
			vflip = true
		elif numdente in [6, 7]:
			sprite_do_dente = 2
		elif numdente in [10, 14]:
			sprite_do_dente = 3
		elif numdente in [9, 13]:
			sprite_do_dente = 3
			vflip = true
		elif numdente in [11, 15]:
			sprite_do_dente = 1
		elif numdente in [12, 16]:
			sprite_do_dente = 1
			vflip = true
			
		dente.get_node("Sprite").set_frame(sprite_do_dente)
		dente.get_node('Sprite').set_flip_v(vflip)
		
		randomize()
		var som_indice = round(randi() % 2)
		lista_de_sons[som_indice].play()
		
#		dente.frames_do_sprite = [0, 4, 8, 12]
#		dente.frames_do_sprite = dente.frames_do_sprite + [dente.get_node("Sprite").get_frame(), dente.get_node("Sprite").get_frame(), dente.get_node("Sprite").get_frame(), dente.get_node("Sprite").get_frame()]
		
		add_child(dente)
		yield(get_tree().create_timer(0.1), "timeout")
	
	#Conectar os dentes com a camera, para podermos ter um screenshake e etc.
	for dente in get_tree().get_nodes_in_group('tooth'):
		dente.connect('atingido', get_tree().get_nodes_in_group('camera')[0], '_um_dente_foi_atingido')
#		lista_de_dentes.append([dente, weakref(dente)])
		
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func the_wave_is_over():
#	for dente_array in lista_de_dentes:
#		if not dente_array[1].get_ref():
#			pass
#		else:
#			dente_array[0].queue_free()
#	yield(get_tree().create_timer(0.1), "timeout")
#	if self.get_child_count() <= 0:
#		queue_free()
	for dente in get_children():
		dente.queue_free()
#		var wr = weakref(dente)
#		if wr.get_ref():
#			dente.queue_free()
#		else:
#			pass
		yield(get_tree().create_timer(0.1), "timeout")
		if self.get_child_count() <= 0:
			queue_free()

#func game_over():
#	pass
