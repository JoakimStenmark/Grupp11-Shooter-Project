Enemy e;
EnemyManager enemyManager;
boolean gameOver = false;


void setup()
{
	size(672,768);
	e = new Enemy();
	enemyManager = new EnemyManager();
}

void draw() 
{

	background(0);
	// e.Move(new PVector(5,0));
	// e.Draw();
	enemyManager.update();
	enemyManager.Draw();

	if (gameOver)
	{
		println("GAME OVER");
	}
}
