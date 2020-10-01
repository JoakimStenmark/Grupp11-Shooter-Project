// Joakim Stenmark

public class Wave9 extends EnemyManager
{
	Wave9()
	{	
		enemyAmount = 128;
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

			if (i % 8 == 0 || i % 8 == 7) 
			{
				enemies[i] = new FastEnemy((float)(90 + h * spacing), (float)(height * -2 + j * spacing));
			}
			else if (i % 3 >= 1) 
			{
				enemies[i] = new BigEnemy((float)(120 + h * spacing/2), (float)(height * -0.65 + j * spacing/2));
				
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