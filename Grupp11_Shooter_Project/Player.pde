// Eddie Norberg

public class Player extends GameObject
{
	Bullet[] bullets;

	float recoveryTime;
	float recoveryTimer;

	int numOfTurrets;
	int maxNumOfTurrets;
	int maxBulletsPerTurret;

	int killCount;
	int spawnGoal;

	int maxExtraLives = 5;

	Player (PVector position, PVector direction, float speed, float radius, color colour)
	{
		this.position = position;
		this.direction = direction;

		this.speed = speed;

		this.radius = radius;
		diameter = radius + radius;
		aabb = new BoundingBox (new PVector (diameter, diameter));
		aabb.SetPerfectSize (new PVector (diameter, diameter));

		col = colour;

		health = 3;

		maxNumOfTurrets = 3;
		maxBulletsPerTurret = 8;
		bullets = new Bullet[maxBulletsPerTurret * maxNumOfTurrets];
		println ("bullets.length: " + bullets.length);
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

		numOfTurrets = 3;

		killCount = 0; // Counts as the player kills an Enemy.
		spawnGoal = 5; // Every 5th enemy spawns a Pickup.
	}

	public void Update ()
	{
		Move ();
		aabb.Update (position);

		UpdateTimers ();

		BulletCollisionCheck ();
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

		if (numOfTurrets == 1)
		{
			stroke (255);
			strokeWeight (2);
			fill (0);
			ellipse (position.x, position.y, gunSize, gunSize);
		}
		else if (numOfTurrets == 2)
		{
			stroke (255);
			strokeWeight (2);
			fill (0);
			for (int i = 0; i < 2; i++)
			{
				ellipse ((position.x - radius) + (diameter * i), position.y, gunSize, gunSize);
			}
		}
		else
		{
			stroke (255);
			strokeWeight (2);
			fill (0);
			int turretCounter = 1;
			for (int i = -1; i < 2; i++)
			{
				ellipse (position.x + (i * radius), position.y - ((radius * 0.5f) * ((turretCounter + 1) % 2)), gunSize, gunSize);
				turretCounter++;
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
		position.add (GetVelocity ());

		if (position.x <= radius)
			position.x = radius;
		else if (position.x >= width - radius)
			position.x = width - radius;
	}

	public void Shoot ()
	{
		int bulletAmount = 0;
		int maxBullets = numOfTurrets * maxBulletsPerTurret;
		int x = -1;

		for (int i = 0; i < maxBullets; i++)
		{
			if (bullets[i].isActive)
				continue;

			bullets[i].SetNewDirection (0f);

			if (numOfTurrets == 1)
			{
				bullets[i].Fire (position);
				return;
			}
			else if (numOfTurrets == 2)
				bullets[i].Fire (new PVector ((position.x - radius) + (bulletAmount * diameter), position.y));
			else
			{
				bullets[i].Fire (new PVector (position.x + (x * radius), position.y - ((radius * 0.5f) * ((bulletAmount + 1) % 2))));
				bullets[i].SetNewDirection (10f * x);
				x++;
			}
			
			bulletAmount++;
			if (bulletAmount >= numOfTurrets)
				return;
		}
	}

	private void BulletCollisionCheck ()
	{
		// println ();

		for (Bullet bullet : bullets)
		{
			if (!bullet.isActive)
				continue;
			
			println ();
			println (bullet._name + " isActive: " + bullet.isActive);

			bullet.Update ();

			boolean didCollide = false;
			
			// ENEMIES
			for (Enemy enemy : gameManager.enemyManager.enemies)
			{

				if (didCollide)
					break;

				if (enemy.isActive && bullet.DidCollide (enemy))
				{
					enemy.GotHit (bullet.damage);
					bullet.isActive = false;

					killCount++;
					if (killCount % spawnGoal == 0)
						gameManager.SpawnPickup ();

					didCollide = true;

					println (_name + " collided with " + enemy._name);
				}
			}

			if (didCollide)
				continue;

			// BIG BARRIER 1
			for (Barrier barrier : gameManager.barrierManager.bigBarrier1)
			{
				if (didCollide)
					break;

				if (barrier.health > 0 && bullet.DidCollide (barrier))
				{
					barrier.GotHit (bullet.damage);
					bullet.isActive = false;
					didCollide = true;

					println (_name + " collided with (1) " + barrier._name);
				}
			}

			if (didCollide)
				continue;

			// BIG BARRIER 2
			for (Barrier barrier : gameManager.barrierManager.bigBarrier2)
			{
				if (didCollide)
					break;

				if (barrier.isActive && bullet.DidCollide (barrier))
				{
					barrier.GotHit (bullet.damage);
					bullet.isActive = false;
					didCollide = true;

					println (_name + " collided with (2) " + barrier._name + " health: " + barrier.health);
				}
			}

			if (didCollide)
				continue;

			// BIG BARRIER 3
			for (Barrier barrier : gameManager.barrierManager.bigBarrier3)
			{
				if (didCollide)
					break;

				if (barrier.health > 0 && bullet.DidCollide (barrier))
				{
					barrier.GotHit (bullet.damage);
					bullet.isActive = false;
					didCollide = true;

					println (_name + " collided with (3) " + barrier._name);
				}
			}
		}
	}

	public void GotHit (int amount)
	{
		if (recoveryTimer > 0f)
			return;

		health -= amount;

		numOfTurrets--;
		if (numOfTurrets <= 1)
			numOfTurrets = 1;

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
		{
			numOfTurrets++;
			if (numOfTurrets > 3)
				numOfTurrets = 3;
		}
		else if (pickup instanceof ExtraLife)
		{
			health += pickup.value;
			if (health > maxExtraLives)
				health = maxExtraLives;
		}
	}

	private void UpdateTimers ()
	{
		if (recoveryTimer > 0f)
		{
			recoveryTimer -= deltaTime;

			if (recoveryTimer <= 0f)
				recoveryTimer = 0f;
		}
	}
}
