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

	input.Update ();
	
	gameManager.Update ();
	gameManager.Draw ();
}

public void Init ()
{
	gameManager = new GameManager ();
	gameManager.Init ();
}
