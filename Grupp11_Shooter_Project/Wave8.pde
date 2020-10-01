// Joakim Stenmark

public class Wave8 extends EnemyManager
{
	Wave8()
	{	
		enemyAmount = 32;
		enemyCount = enemyAmount;
		spacing = 70;
		enemyPerRow = 6;
		time = millis() + timePerStep;
		enemies = new Enemy[enemyAmount];

		int j = 0;
		int h = 0;
		for (int i = 0; i < enemies.length; i++) 
		{

			if (i % 5 == 0) 
			{
				enemies[i] = new FastEnemy((float)(70 + h * spacing), (float)(height * -0.5 + j * spacing));
				
			}
			else if (j == 1) 
			{
				enemies[i] = new BigEnemy((float)(70 + h * spacing), (float)(height * -0.3+ j * spacing));
				
			}
			else 
			{
				enemies[i] = new Enemy((float)(70 + h * spacing), (float)(height * -0.3 + j * spacing));
				//enemyCount--;

			}
			
			if (i % enemyPerRow == enemyPerRow - 1) 
			{
				j++;
				h = 0;	
			}
			
			println("i % 8: "+i % 8);
			h++;
		}
	}
}