class BigEnemy extends Enemy
{


	BigEnemy()
	{
		super();
		col = color(0, 0, 255);
	}

	BigEnemy(float x, float y)
	{

		super(x, y);
		col = color(0, 0, 255);

		this.health = 5;
		this.radius = 24f;
		
		diameter = radius + radius;

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