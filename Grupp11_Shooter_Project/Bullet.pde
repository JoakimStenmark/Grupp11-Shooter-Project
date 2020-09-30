public class Bullet extends GameObject
{
	boolean isActive;
	int damage;

	Bullet (PVector position, PVector direction, int damage, float speed, float radius, color col)
	{
		this.position = position;
		this.direction = direction;

		this.radius = radius;
		diameter = radius + radius;

		this.damage = damage;
		this.speed = speed;

		this.col = col;

		isActive = false;
	}

	public void Update ()
	{
		if (!isActive)
			return;

		Move ();
	}

	public void Draw ()
	{
		if (!isActive)
			return;
		
		noStroke ();
		fill (col);
		ellipse (position.x, position.y, diameter, diameter);
	}

	private void Move ()
	{
		position.add (direction.copy ().mult (speed * deltaTime));

		if (position.y < -radius || position.y > height + radius)
			isActive = false;
	}

	public void Fire (PVector position)
	{
		this.position = position.copy ();
		isActive = true;
	}
}
