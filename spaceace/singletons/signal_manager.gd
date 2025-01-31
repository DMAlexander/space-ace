extends Node


signal on_create_bullet(pos: Vector2, 
		dir: Vector2, 
		speed: float, 
		bull_type: BaseBullet.BulletType)
signal on_create_powerup(pos: Vector2, pu_type: PowerUp.PowerUpType)
signal on_create_powerup_random(pos: Vector2)
signal on_create_explosion(pos: Vector2, et: Explosion.ExplosionType)
signal on_create_homing_missile(pos: Vector2)


signal on_player_hit(v: int)
signal on_player_health_bonus(v: int)
signal on_player_died
signal on_score_updated(v: int)
