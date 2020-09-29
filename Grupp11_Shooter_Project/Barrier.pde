public class Barrier extends GameObject
{
	Barrier()
	{
		super();

	}

	Barrier(float x, float y, PVector dir, int health, float speed, float radius)
	{
		
		super(x,y,dir,health,0,radius);

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

	void Draw()
	{
		fill(255, 255, 0);
		rect(position.x,position.y, diameter,diameter);
	}


}