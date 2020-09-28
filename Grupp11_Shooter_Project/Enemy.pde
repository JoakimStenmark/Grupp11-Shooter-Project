class Enemy extends GameObject
{
	float size = 30;

	Enemy()
	{
		super();
		col = color(255, 0, 0);
	}
	Enemy(float x, float y, PVector dir)
	{
		super(x, y, dir); 
		col = color(255, 0, 0);

	}

	void Move(PVector vel)
	{
		position.add(vel);
	}
	void Draw()
	{
		fill(col);
		rectMode(CENTER);
		rect(position.x,position.y, size, size);
	}

}