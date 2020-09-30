public class Pickup extends GameObject
{
    boolean isActive;

    Pickup ()
    {
    }

    Pickup (PVector position, float speed, float radius)
    {
        this.position = position;
        this.speed = speed;
        this.radius = radius;
        this.diameter = radius + radius;

        this.isActive = false;
    }

    public void Update ()
    {
        Move ();
    }

    public void Draw ()
    {
        noStroke ();
        fill (col);
        ellipse (position.x, position.y, diameter, diameter);
    }

    protected void Move ()
	{
		position.add (direction.copy ().mult (speed * deltaTime));

		if (position.y < -radius || position.y > height + radius)
			isActive = false;
	}
}