// Joakim Stenmark

public class Wave5 extends EnemyManager
{
	Wave5()
	{	
		enemyAmount = 32;
		enemyCount = enemyAmount;
		spacing = 64;
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
				enemies[i] = new FastEnemy((float)(90 + h * spacing), (float)(-20 + j * spacing));
				enemies[i]._name = "FastEnemy["+ i +"]";
			}
			else if (i % 3 >= 1) 
			{
				enemies[i] = new Enemy((float)(120 + h * spacing/2), (float)(-20 + j * spacing/2));
				enemies[i]._name = "Enemy["+ i +"]";
			}
			else 
			{
				enemies[i] = new NoEnemy((float)(70 + h * spacing), (float)(-20 + j * spacing));
				enemies[i]._name = "NoEnemy["+ i +"]";
				enemyCount--;
				
			}
			
			

			h++;
		}
	}
}