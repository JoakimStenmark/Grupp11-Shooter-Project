public class Wave3 extends EnemyManager
{
	Wave3()
	{		
		PVector direction = new PVector (0, 1f);
		int health = 1;
		float speed = 120f;
		
		enemyAmount = 16;
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

			if (i > 1  && i < 6 )
			{
				enemies[i] = new FastEnemy((float)(70 + h * spacing), (float)(height * -0.5 + j * spacing), direction, health, speed);
			}
			else 
			{
				enemies[i] = new Enemy((float)(70 + h * spacing), (float)(-20 + j * spacing), direction, health, speed);
			}


			h++;
		}
	}


}