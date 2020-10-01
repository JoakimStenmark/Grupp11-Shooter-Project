// Eddie Norberg

public class Player extends GameObject
{
	Bullet[] bullets;

	float recoveryTime;
	float recoveryTimer;

	boolean hasTwinGun;

	int killCount;
	int spawnGoal;

	Player (PVector position, PVector direction, float speed, float radius, color colour)
	{
		this.position = position;
		this.direction = direction;

		this.speed = speed;

		this.radius = radius;
		diameter = radius + radius;
		aabb = new BoundingBox (new PVector (diameter, diameter));

		col = colour;

		health = 3;

		bullets = new Bullet[16];
		for (int i = 0; i < bullets.length; i++)
		{
			bullets[i] = new Bullet (	new PVector (),			// Position
										new PVector (0, -1f),	// Direction
										1,						// Damage
										600f,					// Speed
										4f,						// Radius
										color (255, 255, 0));	// Color

			bullets[i]._name = "P-Bullet["+i+"]";
		}

		_name = "Player";

		recoveryTime = 1.5f;
		recoveryTimer = 0f;

		hasTwinGun = false;

		killCount = 0; // Counts as the player kills an Enemy.
		spawnGoal = 5; // Every 5th enemy spawns a Pickup.
	}

	public void Update ()
	{
		Move ();
		aabb.Update (position);

		for (Bullet bullet : bullets)
		{
			if (!bullet.isActive)
				continue;

			bullet.Update ();
			
			for (Enemy enemy : gameManager.enemyManager.enemies)
			{
				if (enemy.health > 0 && bullet.DidCollide (enemy))
				{
					enemy.GotHit (bullet.damage);
					bullet.isActive = false;

					killCount++;
					if (killCount % spawnGoal == 0)
						gameManager.SpawnPickup ();
					continue;
				}
			}

			for (Barrier barrier : gameManager.barrierManager.bigBarrier1)
			{
				if (barrier.health > 0 && bullet.DidCollide (barrier))
				{
					barrier.GotHit (bullet.damage);
					bullet.isActive = false;
					continue;
				}
			}

			for (Barrier barrier : gameManager.barrierManager.bigBarrier2)
			{
				if (barrier.health > 0 && bullet.DidCollide (barrier))
				{
					barrier.GotHit (bullet.damage);
					bullet.isActive = false;
					continue;
				}
			}

			for (Barrier barrier : gameManager.barrierManager.bigBarrier3)
			{
				if (barrier.health > 0 && bullet.DidCollide (barrier))
				{
					barrier.GotHit (bullet.damage);
					bullet.isActive = false;
					continue;
				}
			}
		}

		if (recoveryTimer > 0f)
		{
			recoveryTimer -= deltaTime;

			if (recoveryTimer <= 0f)
				recoveryTimer = 0f;
		}
	}

	public void Draw ()
	{
		// Calculate Alpha Color
		int a = 255;
		if (recoveryTimer > 0f)
		{
			float timeDiff = recoveryTimer / recoveryTime;
			int b = (int)(timeDiff * 768);
			a = b % 256;
		}
		color _col = color (red (col), green(col), blue (col), a);

		// Player
		noStroke ();
		fill (_col);
		ellipse (position.x, position.y, diameter, diameter);

		// Player Turrets
		float gunSize = 8f;

		if (!hasTwinGun)
		{
			stroke (255);
			strokeWeight (2);
			fill (0);
			ellipse (position.x, position.y, gunSize, gunSize);
		}
		else
		{
			stroke (255);
			strokeWeight (2);
			fill (0);
			for (int i = 0; i < 2; i++)
			{
				ellipse ((position.x - radius) + (diameter * i), position.y, gunSize, gunSize);
			}
		}

		aabb.Draw ();

		// PLAYER HUD
		for (int i = 0; i < health; i++)
		{
			stroke (255, 255, 255);
			fill (red (col), green (col), blue (col), 192);
			ellipse (i * (diameter + radius) + diameter, height - diameter, diameter, diameter);
		}

		// BULLETS
		for (int i = 0; i < bullets.length; i++)
		{
			bullets[i].Draw ();
		}
	}

	private void Move ()
	{
		direction = input.GetDirectionRAW ();
		direction.y = 0f;
		position.add (direction.copy ().mult (speed * deltaTime));

		if (position.x <= radius)
			position.x = radius;
		else if (position.x >= width - radius)
			position.x = width - radius;
	}

	public void Shoot ()
	{
		int bulletAmount = 0;
		int maxBullets = (hasTwinGun) ? bullets.length : (int)(bullets.length * 0.5f);

		for (int i = 0; i < maxBullets; i++)
		{
			if (bullets[i].isActive)
				continue;

			if (!hasTwinGun)
			{
				bullets[i].Fire (position);
				return;
			}
			else
			{
				bullets[i].Fire (new PVector ((position.x - radius) + (bulletAmount * diameter), position.y));
				bulletAmount++;
				if (bulletAmount >= 2)
					return;
			}
		}
	}

	public void GotHit (int amount)
	{
		if (recoveryTimer > 0f)
			return;

		health -= amount;

		hasTwinGun = false;

		if (health <= 0)
		{
			health = 0;
			position = new PVector (-100f, -100f);
			gameManager.GameOver ();
		}
		else
			recoveryTimer = recoveryTime;
	}

	public void GotPickup (Pickup pickup)
	{
		if (pickup instanceof TwinGun)
			hasTwinGun = true;
		else if (pickup instanceof ExtraLife)
			health += pickup.value;
	}
}
