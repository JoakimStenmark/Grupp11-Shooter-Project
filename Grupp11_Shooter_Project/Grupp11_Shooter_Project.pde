GameManager gameManager;

void setup()
{
	size (672, 768);
	frameRate (60);

	Init ();
}

void draw () 
{
	background(0);

	UpdateDeltaTime ();

	GetInput ();
	
	gameManager.Update ();
	gameManager.Draw ();
}

public void GetInput ()
{
	input.Update ();
}

public void Init ()
{
	gameManager = new GameManager ();
	gameManager.Init ();
}
