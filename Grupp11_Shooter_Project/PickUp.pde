public class PickUp extends GameObject
{
    boolean isActive;

    PickUp ()
    {
    }

    PickUp (PVector position, PVector direction, float speed, float radius)
    {
        this.position = position;
        this.direction = direction;
        this.speed = speed;
        this.radius = radius;
        diameter = radius + radius;

        isActive = false;
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