public class TwinGun extends Pickup
{
    int damage = 2;

    TwinGun ()
    {
    }

    TwinGun (PVector position, float speed, float radius)
    {
        super (position, speed, radius);

        this.direction = new PVector (0f, 1f);
        this.col = color (128, 255, 255);
    }

    public void Update ()
    {
        if (!isActive)
            return;

        super.Update ();

        if (DidCollide (gameManager.player))
        {
            gameManager.player.hasTwinGun = true;
            isActive = false;
        }
    }

    public void Draw ()
    {
        if (!isActive)
            return;

        super.Draw ();
    }
}