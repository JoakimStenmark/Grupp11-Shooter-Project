class BigEnemy extends Enemy
{
	BigEnemy(float x, float y)
	{
		position = new PVector (x, y);
		this.direction = direction;		
		this.speed = speed;		
		this.health = 5;
		this.maxHealth = this.health;
		this.radius = 24f;
		
		diameter = radius + radius;

		col = color(0, 0, 255);
		moveLength = new PVector(50,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x);

		InitBullets ();

		points = 200;
	}
}