public class TwinGun extends PickUp
{
    int damage = 2;

    TwinGun ()
    {
    }

    TwinGun (PVector position, PVector direction, float speed, float radius)
    {
        super (position, direction, speed, radius);

        col = color (128, 255, 255);
        isActive = true;
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