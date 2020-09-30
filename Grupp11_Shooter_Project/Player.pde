public class Player extends GameObject
{
	Bullet[] bullets;

	Player ()
	{
		super ();

		speed = 240f;

		radius = 16f;
		diameter = radius + radius;

		health = 1;

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
	}

	Player (PVector position, PVector direction, float speed, float radius, color colour)
	{
		this.position = position;
		this.direction = direction;

		this.speed = speed;

		this.radius = radius;
		diameter = radius + radius;

		col = colour;

		health = 1;

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
	}

	public void Draw ()
	{
		noStroke ();
		fill (col);
		ellipse (position.x, position.y, diameter, diameter);

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
		health -= amount;

		print ("\n\nPlayer got hit with: " + amount + " amount!");

		if (health <= 0)
		{
			health = 0;
			position = new PVector (-100f, -100f);
			gameManager.GameOver ();
		}
	}
}
