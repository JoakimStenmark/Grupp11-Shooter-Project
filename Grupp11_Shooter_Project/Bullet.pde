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

		col = color (192, 192, 192);

		damage = 1;
		speed = 480f;

		isActive = false;
	}

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

		print ("\n\nBullet.pos: " + this.position + "\ncolor: " + red(col) + "\nisActive: " + isActive);
	}
}
