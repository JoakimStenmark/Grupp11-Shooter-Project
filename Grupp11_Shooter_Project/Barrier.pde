// Eddie Norberg

public class Barrier extends GameObject
{
	int maxHealth;

	Barrier (PVector position, float radius)
	{
		this.position = position;
		this.health = 4;
		maxHealth = health;
		this.radius = radius;
		diameter = radius + radius;
		aabb = new BoundingBox (position, new PVector (diameter, diameter));
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

	public void GotHit (int amount)
	{
		health -= amount;

		if (health <= 0)
			GotKilled ();
	}

	public void GotKilled ()
	{
		isActive = false;
	}
}