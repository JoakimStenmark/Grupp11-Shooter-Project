// Eddie Norberg (mostly)

public class Barrier extends GameObject
{
	int maxHealth;

	Barrier(float x, float y, PVector direction, int health, float radius)
	{
		position = new PVector (x, y);
		this.direction = direction;
		this.health = health;
		maxHealth = health;
		this.radius = radius;
		diameter = radius + radius;
		aabb = new BoundingBox (new PVector (diameter, diameter));
		aabb.Update (position);
		col = color (255, 255, 0);
		isActive = true;
	}

	void Draw()
	{
		if (!isActive)
			return;
			
		int g = round (((float)health / (float)maxHealth) * 255);
		fill(red (col), g, 0);
		stroke(0);
		rect(position.x,position.y, diameter,diameter);

		aabb.Draw ();
	}

	void GotHit (int amount)
	{
		health -= amount;

		if (health <= 0)
			isActive = false;
	}
}