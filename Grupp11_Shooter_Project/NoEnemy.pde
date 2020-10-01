// Joakim Stenmark

class NoEnemy extends Enemy
{
	NoEnemy(float x, float y)
	{
		position = new PVector (x, y);
		this.direction = direction;		
		this.speed = speed;		
		this.health = 0;
		this.maxHealth = this.health;
		this.radius = 0f;
		
		diameter = radius + radius;
		// aabb = new BoundingBox (position, new PVector (diameter, diameter));

		col = color(0, 0, 0);
		moveLength = new PVector(0,0);

		right = new PVector(moveLength.x, moveLength.y);
		left = new PVector(moveLength.x * -1, moveLength.y);
		down = new PVector(moveLength.y, moveLength.x);

		InitBullets ();

		points = 0;

		isActive = false;
	}
	public void Shoot ()
	{
		//NoEnemy has no shoot
	}

}