public class Barrier extends GameObject
{
	int maxHealth;

	Barrier()
	{
	}

	Barrier(float x, float y, PVector direction, int health, float radius)
	{
		position = new PVector (x, y);
		this.direction = direction;
		this.health = health;
		maxHealth = health;
		this.radius = radius;
		diameter = radius + radius;
		col = color (255, 255, 0);
	}

	void Draw()
	{
		int g = round (((float)health / (float)maxHealth) * 255);
		fill(red (col), g, 0);
		stroke(0);
		rect(position.x,position.y, diameter,diameter);
	}

	void GotHit (int amount)
	{
		health -= amount;

		if (health <= 0)
		{
			position = new PVector (-100f, -100f);
			health = 0;
		}
	}
}