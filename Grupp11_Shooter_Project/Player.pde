public class Player extends GameObject
{
	Bullet[] bullets;

	Player ()
	{
		super ();

		speed = 120f;

		radius = 16f;
		diameter = radius + radius;

		health = 1;

		bullets = new Bullet[3];
		for (int i = 0; i < bullets.length; i++)
		{
			bullets[i] = new Bullet (	new PVector (),			// Position
										new PVector (0, -1f),	// Direction
										1,						// Damage
										240f,					// Speed
										2f);					// Radius
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

		bullets = new Bullet[3];
		for (int i = 0; i < bullets.length; i++)
		{
			bullets[i] = new Bullet (	new PVector (),			// Position
										new PVector (0, -1f),	// Direction
										1,						// Damage
										240f,					// Speed
										2f);					// Radius
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
					enemy.GotHit (1);
					bullet.isActive = false;
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
}
