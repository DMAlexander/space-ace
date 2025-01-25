extends Node2D


@onready var music: AudioStreamPlayer = $Music


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.reset_score()
	SignalManager.on_player_died.connect(on_player_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE) == true:
		GameManager.load_main_scene()
	if Input.is_action_just_pressed("maker"):
		#SignalManager.on_create_bullet.emit(
			#Vector2(100, 100),
			#Vector2.DOWN,
			#50,
			#BaseBullet.BulletType.ENEMY)
			
		SignalManager.on_create_powerup.emit(
			Vector2(315, 100),
			PowerUp.PowerUpType.HEALTH
		)
		
	if Input.is_action_just_pressed("explode"):
		SignalManager.on_create_explosion.emit(Vector2(
			randf_range(50, 500),
			randf_range(50, 200)
		),
		Explosion.ExplosionType.EXPLOSION)


func on_player_died() -> void:
	music.stop()
	for n in get_tree().get_nodes_in_group(GameManager.GROUP_MOVEABLES):
		if is_instance_valid(n):
			n.queue_free()
			
	var player: Player = get_tree().get_first_node_in_group(GameManager.GROUP_PLAYER)
	if player:
		player.queue_free()
