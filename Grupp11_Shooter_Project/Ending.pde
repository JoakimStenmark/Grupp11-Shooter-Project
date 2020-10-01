public class Ending extends EnemyManager
{
	Ending()
	{		
		enemyAmount = 1;
		enemyCount = enemyAmount;
		spacing = 60;
		enemyPerRow = 8;
		time = millis() + timePerStep;
		enemies = new Enemy[enemyAmount];

		int j = 0;
		int h = 0;
		for (int i = 0; i < enemies.length; i++) 
		{
			if (i % enemyPerRow == 0)  
			{
				j++;
				h = 0;	
			}

			enemies[i] = new Enemy((float)(70 + h * spacing), (float)(-20 + j * spacing));

			h++;
		}
	}

	void Update()
	{
		//do nothing
	}
	void Draw()
	{
		//do nothing
	}

}