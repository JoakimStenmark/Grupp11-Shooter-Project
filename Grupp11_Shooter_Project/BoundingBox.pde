// Eddie Norberg

public class BoundingBox
{
    public PVector position;
    public PVector size;

    BoundingBox (PVector size)
    {
        this.position = new PVector ();
        // this.size = size.mult (1.5f);
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

    public void SetPerfectSize (PVector size)
    {
        this.size = size;
    }

    public boolean CollidedWithAABB (BoundingBox other, String first, String second)
    {
        // if (first.charAt(0) == 'P')
        if (first.equals ("P-Bullet[0]") && second.equals ("BB2_[1,0]"))
        {
            println ("Collision between: " + first + " and " + second);
            println ();
            println (first + ".pos: " + position + " - size: " + size);
            println (second + ".pos: " + other.position + " - size: " + other.size);
            println ();
        }

        for (int y = 0; y < 2; y++)
        {
            for (int x = 0; x < 2; x++)
            {
                if (PointOverlapBox (new PVector (  position.x + (size.x * x), 
                                                    position.y + (size.y * y)),
                                                    other))
                {
                    if (first.equals ("P-Bullet[0]"))
                    {
                        println ("HIT!!!!");
                        gameManager.PauseGame ();
                        // return false;
                    }
                    return true;
                }
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
