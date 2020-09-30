public class Player extends GameObject
{
	Bullet[] bullets;

	float recoveryTime;
	float recoveryTimer;

	Player ()
	{
	}

	Player (PVector position, PVector direction, float speed, float radius, color colour)
	{
		this.position = position;
		this.direction = direction;

		this.speed = speed;

		this.radius = radius;
		diameter = radius + radius;

		col = colour;

		health = 3;

		bullets = new Bullet[8];
		for (int i = 0; i < bullets.length; i++)
		{
			bullets[i] = new Bullet (	new PVector (),			// Position
										new PVector (0, -1f),	// Direction
										1,						// Damage
										480f,					// Speed
										2f,						// Radius
										color (255, 255, 0));	// Color
		}

		recoveryTime = 1.5f;
		recoveryTimer = 0f;
	}

	public void Update ()
	{
		Move ();

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
		int a = 255;
		if (recoveryTimer > 0f)
		{
			float timeDiff = recoveryTimer / recoveryTime;
			int b = (int)(timeDiff * 768);
			a = b % 256;
		}
		color _col = color (red (col), green(col), blue (col), a);

		noStroke ();
		fill (_col);
		ellipse (position.x, position.y, diameter, diameter);

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
	}

	public void Shoot ()
	{
		for (int i = 0; i < bullets.length; i++)
		{
			if (bullets[i].isActive)
				continue;

			bullets[i].Fire (position);
			return;
		}
	}

	public void GotHit (int amount)
	{
		if (recoveryTimer > 0f)
			return;

		health -= amount;

		// print ("\n\nPlayer got hit with: " + amount + " amount!");

		if (health <= 0)
		{
			health = 0;
			position = new PVector (-100f, -100f);
			gameManager.GameOver ();
		}
		else
			recoveryTimer = recoveryTime;
	}
}
