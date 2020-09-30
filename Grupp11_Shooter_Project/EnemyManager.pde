public class EnemyManager
{
	int enemyAmount = 16;
	int enemyCount;
	Enemy[] enemies;
	PVector enemyDirection = new PVector (0,1);
	float timePerStep = 1000; //1000
	float time; 
	int spacing = 60;
	int enemyPerRow = 8;
	
	//int stepsTaken;

	public EnemyManager () 
	{
		time = millis() + timePerStep;
		enemies = new Enemy[enemyAmount];
		int j = 0;
		int h = 0;

		PVector direction = new PVector (0, 1f);
		int health = 1;
		float speed = 120f;
		float radius = 24f;

		for (int i = 0; i < enemies.length; ++i) 
		{
			if (i % enemyPerRow == 0) 
			{
				j++;
				h = 0;	
			}

			if (i % 3 == 2) 
			{
				enemies[i] = new BigEnemy((float)(80 + h * spacing), (float)(j * spacing));
			}
			else if (i > 0)
			{
				enemies[i] = new Enemy((float)(80 + h * (spacing)), (float)(j * spacing), direction, health, speed, radius);	
			}
			else 
			{
				enemies[i] = new Enemy((float)(80 + h * spacing), (float)(j * spacing), direction, health, speed, radius);
			}

			h++;
		}
		
	}

	void Update()
	{
		MoveEnemies();
		
		for (Enemy enemy : enemies)
		{
			enemy.Update ();
		}
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
