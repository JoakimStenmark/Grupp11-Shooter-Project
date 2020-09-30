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
