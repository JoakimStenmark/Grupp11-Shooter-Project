public class Barrier extends GameObject
{
	int maxHealth;

	Barrier()
	{
		super();
		col = color (255, 255, 0);
		maxHealth = health;
	}

	Barrier(float x, float y, PVector dir, int health, float speed, float radius)
	{
		super(x,y,dir,health,0,radius);
		col = color (255, 255, 0);
		maxHealth = health;
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