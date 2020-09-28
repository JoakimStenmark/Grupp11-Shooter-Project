Enemy e;
void setup()
{
	size(672,768);
	e = new Enemy();
}

void draw() 
{

	background(0);
	e.Move(new PVector(5,0));
	e.Draw();
}
