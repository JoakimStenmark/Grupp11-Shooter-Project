// Eddie Norberg



void setup()
{
	size (672, 768);
	frameRate (60);

	Init ();

}

void draw () 
{
	UpdateDeltaTime ();

	input.Update ();
	soundManager.Update();

	gameManager.Update ();
	gameManager.Draw ();
}

public void Init ()
{
	gameManager = new GameManager ();
	soundManager = new SoundManager(this);
}
