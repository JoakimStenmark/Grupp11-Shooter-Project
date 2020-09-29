class Enemy extends GameObject
{
	float size = 30;
	int stepsTaken = 0;
	int stepLength = 50;
	boolean goLeft = false;
	boolean goRight = true;

	PVector moveLength;
	PVector right;
	PVector left;
	PVector down;

	Enemy()
	{
		super();
		col = color(255, 0, 0);
		moveLength = new PVector(stepLength,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x*-1);

	}

	Enemy(float x, float y, PVector dir)
	{
		super(x, y, dir); 
		col = color(255, 0, 0);
		moveLength = new PVector(50,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x);

	}

	void Move()
	{
		
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
			gameOver = true;
		}

	}

	void Draw()
	{
		fill(col);
		rectMode(CENTER);
		rect(position.x,position.y, size, size);
	}

}