public class EnemyManager
{
	int enemyAmount = 25;
	int enemyCount;
	Enemy[] enemies;
	PVector enemyDirection = new PVector (0,1);
	float timePerStep = 1000;
	float time; 
	int spacing = 35;
	int enemyPerRow = 12;
	
	//int stepsTaken;

	public EnemyManager () 
	{
		time = millis() + timePerStep;
		enemies = new Enemy[enemyAmount];
		int j = 0;
		int h = 0;

		for (int i = 0; i < enemies.length; ++i) 
		{
			if (i % enemyPerRow == 0) 
			{
				j++;
				h = 0;	
			}
			enemies[i] = new Enemy(	80 + h * spacing,	// Position.x
									j * spacing,		// Position.y
									enemyDirection,		// Direction
									1,					// Health
									60f,				// Speed
									16f);				// Radius
			h++;
		}
		
	}

	void Update()
	{
		MoveEnemies();
		Draw();
	}

	void Draw()
	{
		for (Enemy e : enemies) 
		{
			e.Draw();
		}
	}

	void MoveEnemies()
	{
		if (millis() > time) 
		{
			for (Enemy e : enemies) 
			{
				e.Move();		
				//stepsTaken++;
			}

			time = millis() + timePerStep;
			timePerStep *= 0.98;
		}
	}
}
