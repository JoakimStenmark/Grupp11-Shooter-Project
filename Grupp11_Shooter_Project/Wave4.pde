// Joakim Stenmark

public class Wave4 extends EnemyManager
{
	Wave4()
	{				
		enemyAmount = 27;
		enemyCount = enemyAmount;
		spacing = 64;
		enemyPerRow = 9;
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

			if (i % 2 == 1)
			{
				enemies[i] = new NoEnemy((float)(70 + h * spacing), (float)(-20  + j * spacing));
				enemies[i]._name = "NoEnemy["+ i +"]";
				enemyCount--;
			}
			else if (i % 2 == 0 && i > 8) {
				
				enemies[i] = new FastEnemy((float)(70 + h * spacing), (float)(-20 + j * spacing));
				enemies[i]._name = "FastEnemy["+ i +"]";
			}
			else 
			{
				enemies[i] = new Enemy((float)(70 + h * spacing/2), (float)(-20 + j * spacing/2));				
				enemies[i]._name = "Enemy["+ i +"]";
			}

			h++;
		}
	}


}