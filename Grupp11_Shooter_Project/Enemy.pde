// Joakim Stenmark

class Enemy extends GameObject
{
	int stepsTaken = 0;
	int stepLength = 50;
	boolean goLeft = false;
	boolean goRight = true;

	PVector moveLength;
	PVector right;
	PVector left;
	PVector down;

	Bullet[] bullets;

	float bulletTime;
	float bulletTimer;

	int points;

	int maxHealth;

	Enemy ()
	{
	}

	Enemy(float x, float y)
	{
		position = new PVector (x, y);
		this.direction = new PVector (0f, 1f);
		this.health = 1;
		this.maxHealth = this.health;
		this.speed = 120f;
		this.radius = 16f;
		diameter = radius + radius;
		aabb = new BoundingBox (new PVector (diameter, diameter));
		aabb.Update (position);

		col = color(255, 0, 0);
		moveLength = new PVector(50,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x);

		InitBullets ();

		points = 100;
	}

	public void Update ()
	{
		if (health <= 0)
			return;
		// Move ();

		if (DidCollide (gameManager.player))
		{
			gameManager.player.GotHit (100);
		}

		for (Barrier barrier : gameManager.barrierManager.bigBarrier1)
		{
			if (DidCollide (barrier))
			{
				barrier.GotHit (100);
				GotHit (100);
			}
		}

		for (Barrier barrier : gameManager.barrierManager.bigBarrier2)
		{
			if (DidCollide (barrier))
			{
				barrier.GotHit (100);
				GotHit (100);
			}
		}

		for (Barrier barrier : gameManager.barrierManager.bigBarrier3)
		{
			if (DidCollide (barrier))
			{
				barrier.GotHit (100);
				GotHit (100);
			}
		}

		bulletTimer -= deltaTime;
		if (bulletTimer <= 0f)
		{
			if (round (random (10)) == 10)
				Shoot ();

			bulletTimer += bulletTime;
		}

		for (Bullet bullet : bullets)
		{
			if (!bullet.isActive)
				continue;

			bullet.Update ();
			
			if (bullet.DidCollide (gameManager.player))
			{
				gameManager.player.GotHit (bullet.damage);
				bullet.isActive = false;
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

	void Draw()
	{
		for (Bullet bullet : bullets)
		{
			bullet.Draw ();
		}

		if (health <= 0)
			return;

		stroke (255, 255, 255, 127);
		strokeWeight (4);
		fill(GetColorPercentValue ());
		rectMode(CENTER);
		rect(position.x,position.y, diameter, diameter);

		aabb.Draw ();
	}

	void Move()
	{
		if (health <= 0)
			return;

		moveLength.set(right);

		if (stepsTaken % 4 == 3) 
		{
			moveLength.set(down);
			goLeft = !goLeft;
			goRight = !goRight;
		}
		else if (goLeft)
		{
			moveLength.set(left);

			//goLeft = !goLeft;
		}
		else if (goRight)
		{
			moveLength.set(right);
			//goRight = !goRight;
		}

		position.add(moveLength);
		stepsTaken++;
		//println("stepsTaken: " + stepsTaken % 4);
		if (position.y >= height - 96) 
		{
			gameManager.gameOver = true;
		}

		aabb.Update (position);
	}

	public void Shoot ()
	{
		for (Bullet bullet : bullets)
		{
			if (bullet.isActive)
				continue;

			bullet.Fire (position);
			return;
		}
	}

	public void GotHit (int amount)
	{
		if (health <= 0)
			return;

		health -= amount;

		if (health <= 0)
		{
			position = new PVector (-100f, -100f);
			health = 0;
			gameManager.score += points;
			gameManager.enemyManager.enemyCount -= 1;
		}
	}

	protected void InitBullets ()
	{
		bullets = new Bullet[1];
		for (int i = 0; i < bullets.length; i++)
		{
			bullets[i] = new Bullet (	new PVector (),			// Position
										new PVector (0, 1f),	// Direction
										1,						// Damage
										240f,					// Speed
										4f,						// Radius
										color (255, 192, 192));	// Color

			bullets[i]._name = "E-Bullet["+i+"]";
		}

		bulletTime = 1f;
		bulletTimer = 1f;
	}

	private color GetColorPercentValue ()
	{
		int r = round (((float)health / (float)maxHealth) * red(col));
		int g = round (((float)health / (float)maxHealth) * green(col));
		int b = round (((float)health / (float)maxHealth) * blue(col));
		return color (r, g, b, alpha(col));
	}
}
