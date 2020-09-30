class BigEnemy extends Enemy
{

	BigEnemy()
	{
		super();
		col = color(0, 0, 255);
	}

	BigEnemy(float x, float y, float radius)
	{

		super(x, y, radius);
		col = color(0, 0, 255);

		this.health = health;

		
		//diameter = radius + radius;

	}
}