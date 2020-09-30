class BigEnemy extends Enemy
{


	BigEnemy()
	{
		super();
		col = color(0, 0, 255);
	}

	BigEnemy(float x, float y, PVector direction, int health, float speed)
	{

		super(x, y);
		col = color(0, 0, 255);

		position = new PVector (x, y);
		this.direction = direction;		
		this.speed = speed;		
		this.health = 5;
		this.radius = 24f;
		
		diameter = radius + radius;

	}
		col = color(0, 0, 255);
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
		if (health > 1)
		{
			stroke(255);
			
		}
		rectMode(CENTER);
		rect(position.x,position.y, diameter, diameter);
	}
}