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
	int points;
	Enemy()
	{
		super();
		col = color(255, 0, 0);
		moveLength = new PVector(stepLength,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x*-1);

	}

	Enemy(float x, float y, PVector dir, int health, float speed, float radius)
	{
		super(x, y, dir, health, speed, radius);

		col = color(255, 0, 0);
		moveLength = new PVector(50,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x);
		points = 100;
	}

	void Draw()
	{
		if (health <= 0)
			return;

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
		if (position.y > height - 50) 
		{
			gameManager.gameOver = true;
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
