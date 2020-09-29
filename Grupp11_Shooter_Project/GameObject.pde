class GameObject
{
	PVector position;
	PVector direction;
	int health;
	color col = 255;

	GameObject()
	{
		position = new PVector(0,0);
		direction = new PVector(0,1);

		health = 1;

		speed = 60f;

		radius = 8f;
		diameter = radius + radius;
	}

	GameObject(float x, float y, PVector dir, int health, float speed, float radius)
	{
		position = new PVector(x,y);
		direction = new PVector(dir.x, dir.y);

		this.health = health;

		this.speed = speed;

		this.radius = radius;
		diameter = radius + radius;
	}


<<<<<<< HEAD
	public void Draw ()
	{
	}

	public boolean DidCollide (GameObject other)
	{
		float maxDistance = radius + other.radius;

        if (abs (position.x - other.position.x) > maxDistance || abs (position.y - other.position.y) > maxDistance)
            return false;

        if (PVector.dist (position, other.position) > maxDistance)
            return false;

		return true;
	}
=======

>>>>>>> parent of 89d4a85... Merge branch 'master' into Jockes-Branch
}
