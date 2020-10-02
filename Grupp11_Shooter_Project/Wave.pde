public class Wave extends EnemyManager
{
	Wave(int waveNumber)
	{		

		switch (waveNumber) 
		{
			case 0:
				wave0();
				break;
			case 1:
				wave1();
				break;
			case 2:
				wave2();
				break;
			case 3:
				wave3();
				break;
			case 4:
				wave4();
				break;
			case 5:
				wave5();
				break;
			case 6:
				wave6();
				break;
			case 7:
				wave7();
				break;
			case 8:
				wave8();
				break;
			case 9:
				wave9();
				break;
		}
	}

	void wave0()
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

	void wave1()
	{
				enemyAmount = 24;
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
	void wave2()
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
	void wave3()
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

			if (i > 1  && i < 6 )
			{
				enemies[i] = new FastEnemy((float)(70 + h * spacing), (float)(height * -0.5 + j * spacing));
				enemies[i]._name = "FastEnemy["+ i +"]";
			}
			else 
			{
				enemies[i] = new Enemy((float)(70 + h * spacing), (float)(-20 + j * spacing));
				enemies[i]._name = "Enemy["+ i +"]";
			}

			h++;
		}
	}
	void wave4()
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
	void wave5()
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
	void wave6()
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

			if (i % 2 == 0 && i < 9 ) 
			{
				enemies[i] = new BigEnemy((float)(70 + h * spacing), (float)(-20 + j * spacing));
				enemies[i]._name = "BigEnemy["+ i +"]";
			}

			else if (i % 2 == 1 && i > 8) 
			{
				enemies[i] = new Enemy((float)(70 + h * spacing), (float)(-20 + j * spacing));
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
	void wave7()
	{
		enemyAmount = 64;
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

			if (i % 3 == 0) 
			{
				enemies[i] = new Enemy((float)(70 + h * spacing), (float)(height * -0.66 + j * spacing));
				enemies[i]._name = "Enemy["+ i +"]";
			}
			else if (i % 7 == 0) 
			{
				enemies[i] = new FastEnemy((float)(70 + h * spacing), (float)(height * -0.75 + j * spacing));
				enemies[i]._name = "FastEnemy["+ i +"]";
				
			}
			else if (i % 11 == 0) 
			{
				enemies[i] = new BigEnemy((float)(70 + h * spacing), (float)(height * -0.66 + j * spacing));
				enemies[i]._name = "BigEnemy["+ i +"]";
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
	void wave8()
	{
		enemyAmount = 32;
		enemyCount = enemyAmount;
		spacing = 64;
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
				enemies[i]._name = "Enemy["+ i +"]";
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
			
			h++;
		}
	}
	void wave9()
	{
		enemyAmount = 128;
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
				enemies[i] = new FastEnemy((float)(90 + h * spacing), (float)(height * -2 + j * spacing));
				enemies[i]._name = "FastEnemy["+ i +"]";
			}
			else if (i % 3 >= 1) 
			{
				enemies[i] = new BigEnemy((float)(120 + h * spacing/2), (float)(height * -0.65 + j * spacing/2));
				enemies[i]._name = "BigEnemy["+ i +"]";
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