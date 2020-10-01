// Eddie Norberg

public class Bullet extends GameObject
{
	int damage;

	Bullet (PVector position, PVector direction, int damage, float speed, float radius, color col)
	{
		this.position = position;
		this.direction = direction;

		this.radius = radius;
		diameter = radius + radius;
		aabb = new BoundingBox (new PVector (diameter, diameter));

		this.damage = damage;
		this.speed = speed;

		this.col = col;
	}

	public void Update ()
	{
		if (!isActive)
			return;

		Move ();
		aabb.Update (position);
	}

	public void Draw ()
	{
		if (!isActive)
			return;
		
		noStroke ();
		fill (col);
		ellipse (position.x, position.y, diameter, diameter);

		aabb.Draw ();
	}

	private void Move ()
	{
		position.add (GetVelocity ());

		if (position.y < -radius || position.y > height + radius ||
			position.x < -radius || position.x > width + radius)
			isActive = false;
	}

	public void Fire (PVector position)
	{
		this.position = position.copy ();
		isActive = true;
	}

	public void SetNewDirection (float angle)
	{
        direction = new PVector (cos (radians (angle - 90f)), sin (radians (angle - 90f)));
	}
}
