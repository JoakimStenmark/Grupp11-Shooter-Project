GameManager gameManager;
boolean gameOver = false;
EnemyManager enemyManager;
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
	enemyManager.update();
	
	
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
	enemyManager = new EnemyManager();
	gameManager.Init ();
}
