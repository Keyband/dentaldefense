extends Position2D

#Variaveis
onready var spawners = [preload("res://Scenes/wave_patterns/wave1.tscn"), preload("res://Scenes/wave_patterns/wave2.tscn"), preload("res://Scenes/wave_patterns/wave3.tscn"), preload("res://Scenes/wave_patterns/wave4.tscn"), preload("res://Scenes/wave_patterns/wave5.tscn")]
var tamanho_viewport = OS.window_size

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _spawn(tipo):
	randomize()
	self.global_position.y = rand_range( tamanho_viewport.y * 0.4, tamanho_viewport.y * 0.6)
	var wave = spawners[tipo].instance()
	wave.global_position = self.global_position
	wave.direcao.x *= 1
#	if self.global_position.y > tamanho_viewport.y/2:
#		wave.velocidade.y *= -1
	get_parent().add_child(wave)
