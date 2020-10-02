// Eddie Norberg

public class ExtraLife extends Pickup
{
    ExtraLife (float speed, float radius)
    {
        super (speed, radius);

        this.col = color (128, 255, 255);
        
        this.value = 1; // (ExtraLife+)
        _name = "ExtraLife";
    }

    public void Draw ()
    {
        if (!isActive)
            return;

        float quartz = radius * 0.75f;

        strokeWeight (2);
        stroke (255);
        fill (255, 0, 0);
        ellipse(position.x, position.y, diameter, diameter);
        fill (255, 0, 128);
        ellipse (position.x -quartz, position.y - quartz, radius, radius);
        ellipse (position.x +quartz, position.y - quartz, radius, radius);
        noStroke ();
        ellipse (position.x - radius * 0.5f, position.y - radius * 0.5f, radius , radius * 0.75f);
        ellipse (position.x + radius * 0.5f, position.y - radius * 0.5f, radius , radius * 0.75f);

        aabb.Draw ();
    }
}
