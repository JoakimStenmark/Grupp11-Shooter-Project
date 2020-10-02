// Eddie Norberg

public class BoundingBox
{
    public PVector position;
    public PVector size;

    BoundingBox (PVector position, PVector size)
    {
        this.position = position;
        this.size = size.mult (0.5f);
    }

    public void Update (PVector position)
    {
        this.position = position;
    }

    public void Draw ()
    {
        Draw (color (0, 255, 0, 32));
    }

    public void Draw (color colour)
    {
        if (!gameManager.drawAABB)
            return;

        stroke (192, 255, 192, 192);
        strokeWeight(2);
        fill (colour);
        rectMode(CENTER);
        rect (position.x, position.y, size.x + size.x, size.y + size.y);

        strokeWeight (1);
        float diameter = 8f;
        stroke (255, 255, 255, 192);
        noFill ();

        for (int y = -1; y <= 2; y += 2)
        {
            for (int x = -1; x <= 2; x += 2)
            {
                ellipse (position.x + x * size.x, position.y + y * size.y, diameter, diameter);
            }
        }
    }

    public void SetPerfectSize (PVector size)
    {
        this.size = size;
    }

    // Default way of calling the method.
    public boolean CollidedWithAABB (BoundingBox other, PVector velocity)
    {
        return CollidedWithAABB (other, velocity, "Me", "You");
    }

    // Just a wrapper for debugging.
    public boolean CollidedWithAABB (BoundingBox other, PVector velocity, String first, String second)
    {
        int velocityCount = ceil (velocity.mag () / min (size.x, size.y));
        PVector moveDelta = velocity.copy ().limit (velocity.mag () / velocityCount);

        for (int i = 1; i <= velocityCount; i++)
        {
            for (int y = -1; y < 2; y += 2)
            {
                for (int x = -1; x < 2; x += 2)
                {
                    PVector point = new PVector (   position.x + (size.x * x) + moveDelta.copy ().mult (i).x,
                                                    position.y + (size.y * y) + moveDelta.copy ().mult (i).y);

                    if (PointOverlapBox (point, other))
                        return true;
                }
            }
        }

        return false;
    }

    private boolean PointOverlapBox (PVector point, BoundingBox box)
    {
        if (point.x > box.position.x - box.size.x && point.x < box.position.x + box.size.x &&
            point.y > box.position.y - box.size.y && point.y < box.position.y + box.size.y)
            return true;
            
        return false;
    }
}
