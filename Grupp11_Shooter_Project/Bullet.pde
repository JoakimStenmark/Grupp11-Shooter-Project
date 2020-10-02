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
		if (!isActive || (isActive = !FoundCollision (isPlayerBullet)) == false)
			return;

		Move ();
	}

	public void Draw ()
	{
		if (gameManager.drawAABB && !isActive)
		{
			noStroke ();
			fill (255, 0, 0, 128);
			ellipse (position.x, position.y, diameter, diameter);
			return;
		}
		else if (!isActive)
			return;
		
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
			for (Enemy enemy : gameManager.enemyManager.enemies)
			{
				if (enemy.isActive && DidCollide (enemy))
				{
					enemy.GotHit (damage);
					return true;
				}
			}
		}
		else
		{
			if (DidCollide (gameManager.player))
			{
				gameManager.player.GotHit ();
				return true;
			}	
		}

		// BARRIERS
		// How many small barriers in one big.
		int numOfBarriers = gameManager.barrierManager.bigBarrier1.length;
		int barrierIndex;
		Barrier[] barriers = new Barrier[numOfBarriers * 3];

		for (int i = 0; i < numOfBarriers; i++)
		{
			// if not player then fill array in order
			barrierIndex = (isPlayerBullet) ? (numOfBarriers - 1) - i : i;

			barriers[i] = gameManager.barrierManager.bigBarrier1[barrierIndex];
			barriers[numOfBarriers + i] = gameManager.barrierManager.bigBarrier2[barrierIndex];
			barriers[numOfBarriers * 2 + i] = gameManager.barrierManager.bigBarrier3[barrierIndex];
		}

		for (Barrier barrier : barriers)
		{
			if (barrier.isActive && DidCollide (barrier))
			{
				barrier.GotHit (damage);
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
