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
	}

	GameObject(float x, float y, PVector dir)
	{
		position = new PVector(x,y);
		direction = new PVector(dir.x, dir.y);
	}

	public void Update ()
	{
	}

	public void Draw ()
	{
	}
}
