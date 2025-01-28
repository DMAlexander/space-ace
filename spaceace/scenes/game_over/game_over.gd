extends Control


@onready var timer: Timer = $Timer
@onready var score_label: Label = $VBoxContainer/ScoreLabel


var _can_shoot: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	SignalManager.on_player_died.connect(on_player_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _can_shoot == false:
		return
		
	if Input.is_action_just_pressed("shoot") == true:
		GameManager.load_main_scene()
	
	

func on_player_died() -> void:
	set_process(true)
	show()
	timer.start()
	score_label.text = "Score:%s (Best:%s)" % [
		ScoreManager.get_score(),
		ScoreManager.get_high_score()
	]


func _on_timer_timeout() -> void:
	_can_shoot = true
