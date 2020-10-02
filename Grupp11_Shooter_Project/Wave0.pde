public class Wave0 extends EnemyManager
{
	Wave0()
	{		
		enemyAmount = 16;
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

			enemies[i] = new Enemy((float)(70 + h * spacing), (float)(-20 + j * spacing));
			enemies[i]._name = "Enemy["+ i +"]";

			h++;
		}
	}
}