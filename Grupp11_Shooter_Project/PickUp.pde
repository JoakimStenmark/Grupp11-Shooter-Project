// Eddie Norberg

public class Pickup extends GameObject
{
    boolean isActive;
    int value;

    Pickup (float speed, float radius)
    {
        this.direction = new PVector (0f, 1f);
        this.speed = speed;
        this.radius = radius;
        this.diameter = radius + radius;
        aabb = new BoundingBox (new PVector (diameter, diameter));

        this.isActive = false;
        this.value = 0;
    }

    public void Update ()
    {
        if (!isActive)
            return;

        Move ();
        CollisionCheck ();
    }

    public void Draw ()
    {
        if (!isActive)
            return;

        noStroke ();
        fill (col);
        ellipse (position.x, position.y, diameter, diameter);

        aabb.Draw ();
    }

    protected void Move ()
	{
		position.add (direction.copy ().mult (speed * deltaTime));

		if (position.y > height + radius)
			isActive = false;
	}

    protected void CollisionCheck ()
    {
        aabb.Update (position);

        if (DidCollide (gameManager.player))
        {
            gameManager.player.GotPickup (this);
            isActive = false;
        }
    }

    public boolean CouldSpawn ()
    {
        if (isActive)
            return false;

        position = new PVector (random (diameter, width - diameter), -diameter);
        return isActive = true;
    }
}