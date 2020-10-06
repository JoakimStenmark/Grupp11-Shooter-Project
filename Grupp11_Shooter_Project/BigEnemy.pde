// Joakim Stenmark

class BigEnemy extends Enemy
{
	BigEnemy(float x, float y)
	{
		position = new PVector (x, y);
		this.direction = new PVector (0,1);	
		this.health = 5;
		this.maxHealth = this.health;
		this.radius = 24f;
		
		diameter = radius + radius;
		aabb = new BoundingBox (position, new PVector (diameter, diameter));

		col = color(0, 0, 255);
		moveLength = new PVector(50,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x);

		InitBullets ();

		_name = "BigEnemy";
		recoveryTime = 0.05f;
		recoveryTimer = 0f;

		points = 200;

		isActive = true;
	}
	
}