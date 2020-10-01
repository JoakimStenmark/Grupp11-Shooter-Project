public class BoundingBox
{
    public PVector position;
    public PVector size;

    BoundingBox (PVector size)
    {
        this.position = new PVector ();
        this.size = size;
    }

    public void Update (PVector position)
    {
        this.position = position;
    }

    public void Draw ()
    {
        Draw (color (0, 255, 0, 64));
    }

    public void Draw (color colour)
    {
        if (!gameManager.drawAABB)
            return;

        stroke (192, 255, 192, 192);
        strokeWeight(2);
        fill (colour);
        rect (position.x, position.y, size.x, size.y);
    }

    public boolean CollidedWithAABB (BoundingBox other)
    {
        for (int y = 0; y < 2; y++)
        {
            for (int x = 0; x < 2; x++)
            {
                if (PointOverlapBox (new PVector (  position.x + (size.x * x), 
                                                    position.y + (size.y * y)),
                                                    other))
                    return true;
            }
        }

        return false;
    }

    private boolean PointOverlapBox (PVector point, BoundingBox box)
    {
        if (point.x > box.position.x && point.x < box.position.x + box.size.x &&
            point.y > box.position.y && point.y < box.position.y + box.size.y)
            return true;
            
        return false;
    }
}
