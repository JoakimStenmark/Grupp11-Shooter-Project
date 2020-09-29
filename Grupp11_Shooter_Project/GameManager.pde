public class GameManager
{
    EnemyManager enemyManager;
    Player player;

    boolean gameOver = false;

    GameManager ()
    {
        enemyManager = new EnemyManager ();

        player = new Player (   new PVector (width * 0.5f, height * 0.5f),  // Position
                                new PVector (0, -1f),                       // Direction
                                120f,                                       // Speed
                                16f,                                        // Radius
                                color (128, 128, 255));                     // Color

        print ("\n\nGameManager Constructor...");
    }

    public void Init ()
    {
    }

    public void Update ()
    {
        player.Update ();
        enemyManager.Update ();
    }

    public void Draw ()
    {
        player.Draw ();
    }
}
