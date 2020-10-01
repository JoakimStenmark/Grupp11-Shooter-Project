// Joakim Stenmark

public class Wave2 extends EnemyManager
{
	Wave2()
	{		
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

			if (i == 0 || i == 7)
			{
				enemies[i] = new BigEnemy((float)(70 + h * spacing), (float)(-20 + j * spacing));
				enemies[i]._name = "BigEnemy["+ i +"]";
			}
			else 
			{
				enemies[i] = new Enemy((float)(70 + h * spacing), (float)(-20 + j * spacing));
				enemies[i]._name = "Enemy["+ i +"]";
			}

			h++;
		}
	}


}