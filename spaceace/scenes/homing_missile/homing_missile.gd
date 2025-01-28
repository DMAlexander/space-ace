extends HitBox


class_name HomingMissle


const ROTATION_SPEED: float = 1.2
const SPEED: float = 40.0
const SCORE: int = 5


var _player_ref: Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(GameManager.GROUP_PLAYER)
	if !_player_ref:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dtp: Vector2 = global_position.direction_to(_player_ref.global_position)
	var atp: float = transform.x.angle_to(dtp)
	
	rotate(sign(atp) * min(abs(atp), ROTATION_SPEED * delta))
	position += transform.x * SPEED * delta


func blow_up() -> void:
	SignalManager.on_create_explosion.emit(global_position, Explosion.ExplosionType.BOOM)
	ScoreManager.increment_score(SCORE)
	set_process(false)
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	blow_up()
