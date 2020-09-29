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

<<<<<<< HEAD
	input.Update ();
=======
	GetInput ();
	
	
>>>>>>> parent of 89d4a85... Merge branch 'master' into Jockes-Branch
	
	gameManager.Update ();
	gameManager.Draw ();
}

public void Init ()
{
	gameManager = new GameManager ();
	gameManager.Init ();
}
