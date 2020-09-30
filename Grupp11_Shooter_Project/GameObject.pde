class GameObject
{
	PVector position;
	PVector direction;
	int health;
	color col = 255;

	float speed;

	float radius;
	float diameter;

	GameObject()
	{
		position = new PVector(0,0);
		direction = new PVector(0,1);

		health = 1;

		speed = 60f;

		radius = 8f;
		diameter = radius + radius;
	}

	GameObject(float x, float y)
	{
		position = new PVector(x,y);


		this.health = health;

		this.speed = speed;

		this.radius = radius;
		diameter = radius + radius;
	}

	public void Update ()
	{
		if (health <= 0)
			return;
	}

	public void Draw ()
	{
		if (health <= 0)
			return;
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
}
