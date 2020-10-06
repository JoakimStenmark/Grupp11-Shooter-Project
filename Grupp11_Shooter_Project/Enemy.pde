// Joakim Stenmark (Original Creator) & Eddie Norberg (Mostly Re-written)

class Enemy extends GameObject
{
	int stepsTaken = 0;
	int stepLength = 48;
	boolean goLeft = false;
	boolean goRight = true;

	PVector moveLength;
	PVector right;
	PVector left;
	PVector down;

	Bullet[] bullets;
	int maxBullets;

	float bulletTimer;
	float minBulletTime;
	float maxBulletTime;

	int points;
	int shootChance = 6;

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
		this.radius = 16f;
		diameter = radius + radius;
		aabb = new BoundingBox (position, new PVector (diameter, diameter));

		col = color(255, 0, 0);
		moveLength = new PVector(48,0);		

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x);

		maxBullets = 1;
		InitBullets ();

		_name = "Enemy";

		points = 100;

		recoveryTime = 0.05f;
		recoveryTimer = 0f;

		isActive = true;
	}

	public void Update ()
	{
		if (bullets != null)
		{
			for (Bullet bullet : bullets)
			{
				bullet.Update (false);
			}
		}

		if (!isActive || (isActive = !FoundCollision ()) == false)
			return;

		UpdateTimers ();
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

		}
		else if (goRight)
		{
			moveLength.set(right);
		}

		position.add(moveLength);
		stepsTaken++;
		if (position.y + radius >= height - 96) 
		{
			gameManager.GameOver();
		}

		ClampPosition (true, false);
		aabb.Update (position);
	}

	protected void ClampPosition (boolean horizontal, boolean vertical)
	{
		if (horizontal)
		{
			if (position.x < -radius)
				position.x = -radius;
			else if (position.x > width - radius)
				position.x = width - radius;
		}

		if (vertical)
		{
			if (position.y < -radius)
				position.y = -radius;
			else if (position.y > height - radius)
				position.y = height - radius;
		}
	}

	public void Shoot ()
	{
		soundManager.enemyShot.play();
		for (int i = 0; i < bullets.length; i++)
		{
			if (bullets[i].isActive)
				continue;

			bullets[i]._name = _name + "-Bullet[" + i + "]";
			bullets[i].Fire (position);

			return;
		}
	}

	private boolean FoundCollision ()
	{
		if (DidCollide (gameManager.player))
		{
			gameManager.player.GotHit ();
			GotKilled (0);
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
				GotKilled (0);
				return true;
			}
		}

		return false;
	}

	public void GotHit (int amount)
	{
		health -= amount;

		if (health <= 0)
		{
			GotKilled (points);
			return;
		}
		else 
		{
			soundManager.enemyHitSound.play();
		}

		recoveryTimer = recoveryTime;
	}

	private void GotKilled (int points)
	{
		isActive = false;
		gameManager.EnemyGotKilled (points);

		if (_name == "BigEnemy") 
			soundManager.explosion.play(0.8);
		else
			soundManager.explosion.play(1);

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
		if (bullets == null)
			return;

		boolean bulletsAvailable = false;
		for (Bullet bullet : bullets)
		{
			if (!bullet.isActive)
				bulletsAvailable = true;
		}

		if (!bulletsAvailable)
			return;

		bulletTimer -= deltaTime;
		if (bulletTimer <= 0f)
		{
			if (round (random (shootChance)) == shootChance)
				Shoot ();

			bulletTimer = random (minBulletTime, maxBulletTime);
		}
	}

	protected void InitBullets ()
	{
		bullets = new Bullet[maxBullets];
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

		minBulletTime = 0.5f;
		maxBulletTime = 1f;

		bulletTimer = random (minBulletTime, maxBulletTime);
	}

	private color GetColorPercentValue ()
	{
		int r = round (((float)health / (float)maxHealth) * red(col));
		int g = round (((float)health / (float)maxHealth) * green(col));
		int b = round (((float)health / (float)maxHealth) * blue(col));
		return color (r, g, b, alpha(col));
	}
}
