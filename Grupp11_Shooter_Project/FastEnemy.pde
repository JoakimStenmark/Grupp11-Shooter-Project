// Joakim Stenmark

public class FastEnemy extends Enemy
{
	FastEnemy()
	{
	}

	FastEnemy(float x, float y)
	{
		position = new PVector (x, y);
		this.direction = new PVector (0f, 1f);
		
		this.health = 1;
		this.radius = 16f;
		
		diameter = radius + radius;
		aabb = new BoundingBox (position, new PVector (diameter, diameter));

		col = color(127, 0, 127);
		moveLength = new PVector(48,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x);

		_name = "FastEnemy";

		recoveryTime = 0.05f;
		recoveryTimer = 0f;

		points = 200;

		isActive = true;
	}

	void Draw()
	{
		if (!isActive)
			return;

		if (recoveryTimer > 0f)
		{
			noStroke ();
			fill (255);

			recoveryTimer -= deltaTime;
			if (recoveryTimer <= 0f)
				recoveryTimer = 0f;
		}
		else
		{
			fill(col);
			noStroke();
		}
		rectMode(CENTER);
		triangle(position.x, position.y + radius, position.x - radius , position.y - radius, position.x + radius, position.y - radius);

		aabb.Draw ();
	}

	void Move()
	{
		if (!isActive)
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
		
		if (position.y - radius >= height - 96) 
		{
			gameManager.GameOver();
		}

		ClampPosition (true, false);
		aabb.Update (position);
	}

	public void Shoot ()
	{
		//fast enemy has no shoot
	}

}