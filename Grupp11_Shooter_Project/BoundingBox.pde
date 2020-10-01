// Eddie Norberg

public class BoundingBox
{
    public PVector position;
    public PVector size;

    BoundingBox (PVector position, PVector size)
    {
        this.position = position;
        // this.size = size.mult (1.5f);
        this.size = size;
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
        // noFill ();
        rectMode(CORNER);
        rect (position.x, position.y, size.x, size.y);

        strokeWeight (1);
        float diameter = 8f;
        stroke (255, 255, 255, 192);
        noFill ();

        for (int y = -1; y <= 2; y += 2)
        {
            for (int x = -1; x <= 2; x += 2)
            {
                ellipse (position.x + x * (size.x * 0.5f), position.y + y * (size.y * 0.5f), diameter, diameter);
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
        // if (first.charAt(0) == 'P')
        if (first.equals ("P-Bullet[0]") && second.equals ("BB2_[1,0]"))
        {
            println ("Collision between: " + first + " and " + second);
            println ();
            println (first + ".pos: " + position + " - size: " + size);
            println (second + ".pos: " + other.position + " - size: " + other.size);
            println ();
        }

        // println ();

        // boolean didHit = false;

        // boolean[] cornerHits = new boolean[] {false, false, false, false};
        // int totalHits = 0;

        int velocityCount = ceil (velocity.mag() / min (size.x, size.y));
        PVector moveDelta = velocity.copy ().limit (velocity.mag () / velocityCount);

        for (int i = 1; i <= velocityCount; i++)
        {
            // if (didHit)
            // {
            //     velocity.x = moveDelta.copy ().mult (i-1).x;
            //     velocity.y = moveDelta.copy ().mult (i-1).y;
            //     break;
            // }

            for (int y = 0; y < 2; y++)
            {
                for (int x = 0; x < 2; x++)
                {
                    // boolean doPrint = (y == 0 && x == 0) ? true : false;
                    // boolean doPrint = true;

                    // if (doPrint)
                    // {
                        // println ("\n" + first + " [" + y + "," + x + "]: " + (y * 2 + x));
                        // println ("x: " + (position.x + (size.x * x)));
                        // println ("y: " + (position.y + (size.y * y)));

                        // println ("\n" + second + " [" + y + "," + x + "]: " + (y * 2 + x));
                        // println ("x: " + (other.position.x + (other.size.x * x)));
                        // println ("y: " + (other.position.y + (other.size.y * y)));

                        // x + width + dx > other.x &&
                        // x + dx < other.x + other.width &&
                        // y + height > other.x &&
                        // y < other.y + other.height

                        // println ();
                    // }

                    // println ("other.box:");
                    // println ("TOP-LEFT: [" + other.position.x + ", " + other.position.y + "]");
                    // println ("TOP-RIGHT: [" + (other.position.x + other.size.x) + ", " + other.position.y + "]");
                    // println ("BOTTOM-LEFT: [" + other.position.x + ", " + (other.position.y + other.size.y) + "]");
                    // println ("BOTTOM-RIGHT: [" + (other.position.x + other.size.x) + ", " + (other.position.y + other.size.y) + "]");
                    // println ("min.x: " + other.position.x + " - max.x: " + (other.position.x + other.size.x));
                    // println ("min.y: " + other.position.y + " - max.y: " + (other.position.y + other.size.y));

                    PVector point = new PVector (   position.x + (size.x * x) + moveDelta.copy ().mult (i).x,
                                                    position.y + (size.y * y) + moveDelta.copy ().mult (i).y);

                    // println ("current position: " + position + " - velocity: " + velocity + " - moveDelta: " + moveDelta);
                    // println ("point[" + y + "," + x + "]: " + point);
                    // println ("velCount: " + velocityCount + " - equal: " + (moveDelta.copy ().mult (i)));

                    if (PointOverlapBox (point, other))
                        return true;
                    // if (PointOverlapBox (point, other))
                    // {
                    //     cornerHits[y * 2 + x] = true;
                    //     totalHits++;
                    //     didHit = true;
                    //     break;
                    // }
                }
            }
        }

        // String[] cornerNames = new String[] {"TOP-LEFT", "TOP-RIGHT", "BOTTOM-LEFT", "BOTTOM-RIGHT"};

        // println ("Total Corners Hit: " + totalHits);
        
        // for (int i = 0; i < cornerHits.length; i++)
        // {
        //     println (cornerNames[i] + ": " + ((cornerHits[i] == true) ? "HIT" : "MISS"));
        // }

        // if (totalHits > 0)
        //     return true;

        return false;
    }

    private boolean PointOverlapBox (PVector point, BoundingBox box)
    {
        // println ("point - x: " + point.x + " - y: " + point.y);
        // println ("\nbox.position: " + box.position);
        // println ("\nbox.position: " + box.size);
        // println ((point.x > box.position.x) ? "(TRUE) - point.x[" + point.x + "] > box.position.x[" + box.position.x + "]" : "(FALSE) - point.x[" + point.x +"] <= box.position.x[" + box.position.x + "]");
        // println ((point.x < box.position.x + box.size.x) ? "(TRUE) - point.x[" + point.x + "] < box.position.x + box.size.x[" + (box.position.x + box.size.x) + "]" : "(FALSE) - point.x[" + point.x + "] >= box.position.x + box.size.x[" + (box.position.x + box.size.x) + "]");
        // println ((point.y > box.position.y) ? "(TRUE) - point.y[" + point.y + "] > box.position.y[" + box.position.y + "]" : "(FALSE) - point.y[" + point.y +"] <= box.position.y[" + box.position.y + "]");
        // println ((point.y < box.position.y + box.size.y) ? "(TRUE) - point.y[" + point.y + "] < box.position.y + box.size.y[" + (box.position.y + box.size.y) + "]" : "(FALSE) - point.y[" + point.y + "] >= box.position.y + box.size.y[" + (box.position.y + box.size.y) + "]");

        if (point.x > box.position.x && point.x < box.position.x + box.size.x &&
            point.y > box.position.y && point.y < box.position.y + box.size.y)
            return true;
            
        return false;
    }
}
