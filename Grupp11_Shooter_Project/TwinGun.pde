// Eddie Norberg

public class TwinGun extends Pickup
{
    TwinGun (float speed, float radius)
    {
        super (speed, radius);

        this.col = color (128, 255, 255);

        this.value = 2; // (Damage!?)
        _name = "TwinGun";
    }

    public void Draw ()
    {
        if (!isActive)
            return;

        stroke (255, 255, 255, 255);
        strokeWeight (2);
        fill (0);
        ellipse(position.x, position.y, diameter, diameter);
        ellipse(position.x - radius, position.y, radius * 0.75f, radius * 0.75f);
        ellipse(position.x + radius, position.y, radius * 0.75f, radius * 0.75f);

        aabb.Draw ();
    }
}
