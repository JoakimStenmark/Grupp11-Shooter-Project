public class Barrier extends GameObject
{
	Barrier()
	{
		super();

	}

	Barrier(float x, float y, float radius)
	{
		
		super(x,y);
		position = new PVector(x,y);
		

		this.health = 1;

		
		this.radius = radius;
		diameter = radius + radius;
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
		stroke(0);
		rect(position.x,position.y, diameter,diameter);
	}


}