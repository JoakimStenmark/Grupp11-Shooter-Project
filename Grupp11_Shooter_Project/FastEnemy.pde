public class FastEnemy extends Enemy
{
	FastEnemy()
	{
	}

	FastEnemy(float x, float y, PVector direction, int health, float speed)
	{
		position = new PVector (x, y);
		this.direction = direction;
		
		this.speed = speed;	
		this.health = 1;
		this.radius = 16f;
		
		diameter = radius + radius;

		col = color(127, 0, 127);
		moveLength = new PVector(50,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x);

		InitBullets ();

		points = 200;
	}

	void Draw()
	{
		for (Bullet bullet : bullets)
		{
			bullet.Draw ();
		}

		if (health <= 0)
			return;

		fill(col);
		noStroke();
		rectMode(CENTER);
		
		triangle(position.x, position.y + radius, position.x - radius , position.y - radius, position.x + radius, position.y - radius);

	}

	void Move()
	{
		if (health <= 0)
			return;

		moveLength.set(down);

		if (stepsTaken % 4 == 3) 
		{

			if (goLeft)
			{
				moveLength.set(left);
				goLeft = !goLeft;
				goRight = !goRight;			
			}
			else if (goRight) 
			{
				moveLength.set(right);
				goRight = !goRight;
				goLeft = !goLeft;
			}
			
			
		}

		position.add(moveLength);
		stepsTaken++;
		
		if (position.y >= height - 96) 
		{
			gameManager.gameOver = true;
		}
	}

	public void Shoot ()
	{
		//fast enemy has no shoot
	}

}