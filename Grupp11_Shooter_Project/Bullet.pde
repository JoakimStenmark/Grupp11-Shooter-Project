// Eddie Norberg

public class Bullet extends GameObject
{
	int damage;

	Bullet (PVector position, PVector direction, int damage, float speed, float radius, color col)
	{
		this.position = position;
		this.direction = direction;

		this.radius = radius;
		diameter = radius + radius;
		aabb = new BoundingBox (position, new PVector (diameter, diameter));

		this.damage = damage;
		this.speed = speed;

		this.col = col;
	}

	public void Update (boolean isPlayerBullet)
	{
		if (!isActive || FoundCollision (isPlayerBullet))
			return;

		Move ();
	}

	public void Draw ()
	{
		if (!isActive)
		{
			noStroke ();
			fill (255, 0, 0, 128);
			ellipse (position.x, position.y, diameter, diameter);
			return;
		}
		
		noStroke ();
		fill (col);
		ellipse (position.x, position.y, diameter, diameter);

		aabb.Draw ();
	}

	private void Move ()
	{
		position.add (GetVelocity ());

		if (position.y < -radius || position.y > height + radius ||
			position.x < -radius || position.x > width + radius)
			isActive = false;

		aabb.Update (position);
	}

	public void Fire (PVector position)
	{
		this.position = position.copy ();
		aabb.Update (position);
		isActive = true;
	}

	private boolean FoundCollision (boolean isPlayerBullet)
	{
		if (isPlayerBullet)
		{
			// ENEMIES
			for (Enemy enemy : gameManager.enemyManager.enemies)
			{
				if (_name.charAt (0) == 'P')
				{
					if (enemy.isActive)
					{
						println (_name + " - pos: " + position + " - aabb.pos: " + aabb.position);
						println (enemy._name + " - pos: " + enemy.position + " - aabb.pos: " + enemy.aabb.position);
					}
				}
				if (enemy.isActive && DidCollide (enemy))
				{
					enemy.GotHit (damage);
					isActive = false;
					println (_name + " collided with " + enemy._name + " - health: " + enemy.health);
					return true;
				}
			}
		}
		else
		{
			if (DidCollide (gameManager.player))
			{
				gameManager.player.GotHit ();
				isActive = false;
				println (_name + " collided with " + gameManager.player._name + " - health: " + gameManager.player.health);
				return true;
			}	
		}

		// if (newTest)
		// 	return false;

		// BARRIERS
		// How many small barriers in one big.
		int numOfBarriers = gameManager.barrierManager.bigBarrier1.length;
		int barrierIndex = numOfBarriers - 1;	// Fill the array in reverse so we check the lower first.
		Barrier[] barriers = new Barrier[numOfBarriers * 3];

		for (int i = 0; i < numOfBarriers; i++)
		{
			if (!isPlayerBullet)
				barrierIndex = i;	// if not player then fill array in order

			barriers[i] = gameManager.barrierManager.bigBarrier1[barrierIndex - i];
			barriers[numOfBarriers + i] = gameManager.barrierManager.bigBarrier2[barrierIndex - i];
			barriers[numOfBarriers * 2 + i] = gameManager.barrierManager.bigBarrier3[barrierIndex - i];
		}

		for (int i = 0; i < barriers.length; i++)
		{
			if (barriers[i].isActive && DidCollide (barriers[i]))
			{
				barriers[i].GotHit (damage);
				isActive = false;
				// println (_name + " collided with " + barriers[i]._name + " health: " + barriers[i].health);
				return true;
			}
		}

		return false;
	}

	public void SetNewDirection (float angle)
	{
        direction = new PVector (cos (radians (angle - 90f)), sin (radians (angle - 90f)));
	}
}
