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
	
	Enemy()
	{
		super();
		col = color(255, 0, 0);
		moveLength = new PVector(stepLength,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x*-1);

		bullets = new Bullet[1];
		for (int i = 0; i < bullets.length; i++)
		{
			bullets[i] = new Bullet (	new PVector (),			// Position
										new PVector (0, 1f),	// Direction
										1,						// Damage
										240f,					// Speed
										2f,						// Radius
										color (255, 192, 192));	// Color
		}

		bulletTime = 1f;
		bulletTimer = 1f;

		points = 100;
	}

	Enemy(float x, float y)
	{
		//super(x, y, dir, health, speed, radius);

		position = new PVector(x,y);
		

		this.health = 1;

		

	Enemy(float x, float y, PVector direction, int health, float speed)
	{
		position = new PVector (x, y);
		this.direction = direction;
		this.health = 1;
		this.speed = speed;
		this.radius = 16f;
		diameter = radius + radius;

		col = color(255, 0, 0);
		moveLength = new PVector(50,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x);

		bullets = new Bullet[1];
		for (int i = 0; i < bullets.length; i++)
		{
			bullets[i] = new Bullet (	new PVector (),			// Position
										new PVector (0, 1f),	// Direction
										1,						// Damage
										240f,					// Speed
										2f,						// Radius
										color (255, 192, 192));	// Color
		}

		bulletTime = 1f;
		bulletTimer = 1f;

		points = 100;
	}

	public void Update ()
	{
		// Move ();
		if (DidCollide (gameManager.player))
		{
			gameManager.player.GotHit (100);
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
				gameManager.player.GotHit (1);
				bullet.isActive = false;
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

		noStroke();
		fill(col);		
		rectMode(CENTER);
		rect(position.x,position.y, diameter, diameter);
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
		health -= amount;

		if (health <= 0)
		{
			position = new PVector (-100f, -100f);
			health = 0;
			gameManager.score += points;
		}
	}
}
