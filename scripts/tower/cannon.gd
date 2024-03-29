extends "res://scripts/tower/tower.gd"

const bullet = preload("res://scenes/tower/projectile/cannonball.tscn")

var bullet_health
var target_rot

func _ready():
	._ready()

func init():
	bullet_health = 2
	display_name = "Cannon"
	description = "Shoots slow cannonballs that hit multiple enemies."
	upgrade_costs = [250, 500, 1000, 4000, 20000]
	upgrade_names = ["Longer Range", "Bigger Cannonballs", "Quickshot", "Heavy Metal", "Ultracannon"]
	upgrade_descriptions = ["Increases range by 33%.", "Cannonballs get +1 pierce.", "The cannon shoots 20% faster.", "The cannonballs get an additional +2 pierce.", "Like a machine gun, but a cannon."]
	start_radius = 64
	cost = 500
	value = cost
	$shoot_timer.wait_time = fire_rate
	$shoot_timer.start()
	
func _process(delta):
	._process(delta)
	if !placed:
		return
	if target != null && wr.get_ref():
		$barrel.look_at(target.position)
		
func upgrade():
	value += upgrade_costs[level]
	level += 1
	if level == 1:
		inc_radius(32)
	elif level == 2:
		bullet_health += 1
	elif level == 3:
		fire_rate -= 0.2
	elif level == 4:
		bullet_health += 2
	elif level == 5:
		fire_rate = 0.3
		bullet_health = 5
		inc_radius(32)
	$shoot_timer.wait_time = fire_rate

func _on_shoot_timer_timeout():
	if target == null or !wr.get_ref():
		return
	var b = bullet.instance()
	b.position = position + (Vector2(28, 28) * Vector2(cos($barrel.rotation), sin($barrel.rotation)))
	var dir = Vector2(target.position.x - b.position.x, target.position.y - b.position.y).normalized()
	b.velocity = dir
	b.health = bullet_health
	$bullets.add_child(b)
	$Shoot.play()
