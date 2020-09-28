class GameObject
{
	PVector position;
	PVector direction;

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
}
