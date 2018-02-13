extends Control

#Variaveis
onready var conjunto_de_dentes_preload = preload('res://Scenes/teeth.tscn')
onready var timer_para_waves = get_node('spawners/timer_para_tocar_o_barco')
onready var a_mega_cena_que_contem_os_upgrades_preload = preload("res://Scenes/hora_dos_bonosos.tscn")
onready var nome_do_jogador = str(OS.get_system_dir(2).substr(9, OS.get_system_dir(2).length() - 9 - 10))
var jogo_comecou = false

func _ready():
	#Lista de frases para a saudacao
	var lista_de_frases = [
		"Teeth exist just to nibble fingernails, am I right?",
		"You know these aren't the milk ones, right?",
		"Remember: we will all loose our teeth someday. Maybe today.",
		"C'mon, just go play a good game, like Archer Hunter.",
		"Bet you can't notice all the references (there are none).",
		"Be sure to check the other Atari remakes on Itch.io!",
		"I think it won't crash this time...",
		"No teeth, no beef.",
		"Ever heard of Banjo-Toothie? A nice game indeed.",
		"Preventing dentist visits since 2018.",
		"Just try to press the toothpaste in the right way, ok?",
		"Funny how toothbrushes are useless here.",
		"You always can use fake teeth if you fail.",
		"Killing Food Simulator 2018.",
		"ERROR: OBJECT tooth/root NOT FOUND.",
		"This game is cientifically accurate; trust me, I'm an engineer.",
		"99% is shining white, but that 1%...",
		"No phrase here this time I guess.",
		"Never ever trust someone named " + nome_do_jogador + ".",
		"Oh, about the music... I think there is an option to disable it.",
		"I've never seen cuspids like these in a long time...",
		"Just Monika.",
		"A brawl is surely brewing!",
		"Better be ready for some dental arch defense.",
		"Kinda similar to that game, Plaque Defense, eh?"
	]
	#Por uma dessas frases marotas na tela
	randomize()
#	$GUI/PanelGreeting/PressStartToGetRekt.set_text(lista_de_frases[randi() % (lista_de_frases.size())] )
	$GUI/PanelGreeting/PressStartToGetRekt.texto_total = lista_de_frases[randi() % (lista_de_frases.size())] 
	#Carregar o highscore!
	global.carregar_highscore()
	#Colocar o jogador da fase zero para a fase 1.
	global.fase_em_que_o_jogador_esta += 1
	#Ligar o processo, para verificar por Input para o jogo comecar.
	set_process(true)
	pass

func _process(delta):
	#Se o jogador apertar 'Enter' e o jogo nao tiver comecado:
		#Inicie uma wave;
		#Tire a mensagem para o jogador dar Input quando pronto para o jogo comecar;
		#Diga que o jogo agora comecou;
		#Coloque este processo no falso, ja que nao sera mais preciso checar pelo Input de 'Enter
	if Input.is_action_just_pressed('ui_accept') and not jogo_comecou:
		$AnimationPlayer.play('entre_a_gui')
		_initiate_wave()
#		$GUI/PanelGreeting.queue_free()
#		$GUI/PanelGreeting2.queue_free()
		jogo_comecou = true
		set_process(false)
	pass

#Funcao para ajeitar e comecar uma wave nova.
func _initiate_wave():
	#Mate as particulas que existam.
	for node in get_tree().get_nodes_in_group('particulas'):
		node.queue_free()
	#Coloque a municao do jogador no maximo.
	$player.municao = $player.municao_maxima
	#Coloque a arcada dentaria na tela.
	add_child(conjunto_de_dentes_preload.instance())
	#Ajeite o tempo entre waves de acordo com a dificuldade, e em seguida diga para a wave comecar.
	timer_para_waves.wait_time = max(1.5, 5.0 - global.dificuldade*0.33)
	timer_para_waves.start()
	#Ajeite o numero de waves que restam aparecer de acordo com o numero de waves que aparecerao (o maximo).
	global.numero_de_waves_faltando = round(global.numero_de_waves_que_o_jogador_enfrentara * 1.5 + 1.25)
	#Atualize o numero de waves que aparecerao.
	global.numero_de_waves_que_o_jogador_enfrentara = global.numero_de_waves_faltando
	
	pass

#Fim de wave: limpar a bagunca da ultima, fazer uns checks, e preparar a proxima.
func the_wave_is_over_now_give_me_my_points():
	#Tempo de espera para continuar o resto da funcao.
	yield(get_tree().create_timer(1.0), 'timeout')
	#Aumentar a dificuldade do jogo.
	global.dificuldade *= 1.75
	global.dificuldade_em_vetor *= 1.75
	global.fase_em_que_o_jogador_esta += 1
	#Agraciar o jogador com um bonus de acordo com o numero de dentes presentes.
	var bonus = get_tree().get_nodes_in_group('tooth').size() * 15
	#Incrementar o numero de pontos do jogador com o bonus.
	global.pontos += bonus
	#Agraciar um jogador com um dente/upgrade extra de acordo com os pontos.
	if global.pontos > global.pontos_para_proximo_upgrade:
			global.pontos_para_proximo_upgrade *= 2
			_agraciar_o_jogador()
			
			global.numero_de_dentes +=1
			while global.numero_de_dentes > 16:
				global.numero_de_dentes -= 1
				global.numero_de_dentes_na_reserva += 1
			
			while (global.numero_de_dentes_na_reserva > 0 and global.numero_de_dentes < 16):
				global.numero_de_dentes += 1
				global.numero_de_dentes_na_reserva -= 1
	#Chamar a funcao de acabar a fase no node da .
	get_tree().get_nodes_in_group('teeth')[0].the_wave_is_over()
	#Pegar os spawners e pedir para o timer deles pararem.
	$spawners/timer_para_tocar_o_barco.stop()
	#Tempo de espera para a proxima wave.
	yield(get_tree().create_timer(5.0), 'timeout')
	#Comecar outra wave.
	_initiate_wave()
	pass

#Se o jogador conseguiu aguentar o tranco, lhe de umas escolhas.
func _agraciar_o_jogador():
	var hora_dos_bonosos = a_mega_cena_que_contem_os_upgrades_preload.instance()
	get_tree().set_pause(true)
	$GUI.add_child(hora_dos_bonosos)
	pass


#Se nao houverem mais dentes, game over.
func game_over():
	#Mensagem de gamer over. Ajeitar depois.
	print('perdeu, start pra recomeçar')
	#Atualizar o highscore
	if global.pontos > global.highscore:
		global.highscore = global.pontos
	#Salvar o highscore.
	global.salvar_highscore()
	#Resetar as propriedades do jogo.
	global.pontos = 0
	global.dificuldade = 1
	global.numero_de_waves_faltando = 0
	global.numero_de_waves_que_o_jogador_enfrentara = 0
	#Remover o node de arcada do jogo.
	get_tree().get_nodes_in_group('teeth')[0].queue_free()
	#Mudar o estado de jogo para "nao comecou"
	jogo_comecou = false
	#Ligar o processo, para que o jogador possa recomecar.
	set_process(true)

