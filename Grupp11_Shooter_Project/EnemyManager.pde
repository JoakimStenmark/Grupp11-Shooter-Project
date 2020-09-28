public class EnemyManager
{
	int enemyAmount = 5;
	int enemyCount;
	Enemy[] enemies;
	PVector enemyDirection = new PVector (0,1);
	public EnemyManager () 
	{
		enemies = new Enemy[enemyAmount];
		for (int i = 0; i < enemies.length; ++i) 
		{
			enemies[i] = new Enemy(50 + i*50, 50, enemyDirection);
		}
	}

	void MoveEnemies()
	{
		for (Enemy e : enemies) 
		{
			
		}
	}
	void Draw()
	{
		for (Enemy e : enemies) 
		{
			e.Draw();
		}
	}



}