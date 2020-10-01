// Joakim Stenmark

public class Wave8 extends EnemyManager
{
	Wave8()
	{	
		enemyAmount = 64;
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


			if (i == 2) 
			{
				enemies[i] = new Enemy((float)(70 + h * spacing), (float)(-20 + j * spacing));
				
			}

			else 
			{
				enemies[i] = new NoEnemy((float)(70 + h * spacing), (float)(-20 + j * spacing));
				enemyCount--;

			}
			
			

			h++;
		}
	}
}