public class Wave1 extends EnemyManager
{
	Wave1()
	{		
		spacing = 60;
		time = millis() + timePerStep;
		enemies = new Enemy[enemyAmount];
		enemyCount = enemyAmount;
		int j = 0;
		int h = 0;

		for (int i = 0; i < enemies.length; i++) 
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
				enemies[i] = new Enemy((float)(80 + h * (spacing)), (float)(j * spacing));	
			}
			else 
			{
				enemies[i] = new Enemy((float)(80 + h * spacing), (float)(j * spacing));
			}

			h++;
		}
	}
}