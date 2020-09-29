public class Bullet extends GameObject
{
	boolean isActive;
	int damage;

	Bullet ()
	{
		position = new PVector (0, 0);
		direction = new PVector (0, -1f);

		radius = 2f;
		diameter = radius + radius;

		damage = 1;
		speed = 240f;

		isActive = false;
	}

	Bullet (PVector position, PVector direction, int damage, float speed, float radius)
	{
		this.position = position;
		this.direction = direction;

		this.radius = radius;
		diameter = radius + radius;

		this.damage = damage;
		this.speed = speed;

		isActive = false;
	}

	public void Update ()
	{
		if (!isActive)
			return;

		position.add (direction.copy ().mult (speed * deltaTime));

		if (position.y < -radius)
			isActive = false;
	}

	public void Draw ()
	{
		if (!isActive)
			return;
		
		noStroke ();
		fill (col);
		ellipse (position.x, position.y, diameter, diameter);
	}

	public void Fire (PVector position)
	{
		this.position = position.copy ();
		isActive = true;
	}
}
