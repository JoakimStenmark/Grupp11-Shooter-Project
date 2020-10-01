// Eddie Norberg (mostly)

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

	float recoveryTime;
	float recoveryTimer;

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
		aabb = new BoundingBox (position, new PVector (diameter, diameter));

		col = color(255, 0, 0);
		moveLength = new PVector(50,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x);

		InitBullets ();

		_name = "Enemy";

		points = 100;

		recoveryTime = 0.05f;
		recoveryTimer = 0f;

		isActive = true;
	}

	public void Update ()
	{
		for (Bullet bullet : bullets)
		{
			bullet.Update (false);
		}

		if (!isActive)
			return;

		FoundCollision ();
	}

	void Draw()
	{
		for (Bullet bullet : bullets)
		{
			bullet.Draw ();
		}

		if (!isActive)
			return;

		if (recoveryTimer > 0f)
		{
			noStroke ();
			fill (255);
		}
		else
		{
			stroke (255, 255, 255, 127);
			strokeWeight (4);
			fill(GetColorPercentValue ());
		}
		
		rectMode(CENTER);
		rect(position.x,position.y, diameter, diameter);

		aabb.Draw ();
	}

	void Move()
	{
		if (!isActive)
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

	private boolean FoundCollision ()
	{
		if (DidCollide (gameManager.player))
		{
			gameManager.player.GotHit ();
			GotKilled (false);
		}

		// BARRIERS
		// How many small barriers in one big.
		int numOfBarriers = gameManager.barrierManager.bigBarrier1.length;
		Barrier[] barriers = new Barrier[numOfBarriers * 3];

		for (int i = 0; i < numOfBarriers; i++)
		{
			barriers[i] = gameManager.barrierManager.bigBarrier1[i];
			barriers[numOfBarriers + i] = gameManager.barrierManager.bigBarrier2[i];
			barriers[numOfBarriers * 2 + i] = gameManager.barrierManager.bigBarrier3[i];
		}

		for (int i = 0; i < barriers.length; i++)
		{
			if (barriers[i].isActive && DidCollide (barriers[i]))
			{
				barriers[i].GotKilled ();
				GotKilled (false);
				println (_name + " collided with " + barriers[i]._name + " health: " + barriers[i].health);
				return true;
			}
		}

		return false;
	}

	public void GotHit (int amount)
	{
		if (health <= 0)
			return;

		health -= amount;

		if (health <= 0)
		{
			GotKilled (true);
			return;
		}

		recoveryTimer = recoveryTime;
	}

	private void GotKilled (boolean getPoints)
	{
		isActive = false;
		if (getPoints)
			gameManager.EnemyGotKilled (points);
	}

	private void UpdateTimers ()
	{
		// Update Recovery Animation if was hit recently.
		if (recoveryTimer > 0f)
		{
			recoveryTimer -= deltaTime;
			if (recoveryTimer <= 0f)
				recoveryTimer = 0f;
		}

		// Do we Shoot?
		bulletTimer -= deltaTime;
		if (bulletTimer <= 0f)
		{
			if (round (random (10)) == 10)
				Shoot ();

			bulletTimer += bulletTime;
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
