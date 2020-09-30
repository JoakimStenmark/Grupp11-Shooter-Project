public class GameManager
{
    EnemyManager enemyManager;
    BarrierManager barrierManager;
    Player player;

    boolean gameOver;
    int textSize = 96;
    int score;

    Pickup[] pickups;
    int pickupsIndex;

    GameManager ()
    {
        enemyManager = new Wave1 ();
        barrierManager = new BarrierManager ();

        player = new Player (   new PVector (width * 0.5f, height - 96),    // Position
                                new PVector (0, -1f),                       // Direction
                                240f,                                       // Speed
                                16f,                                        // Radius
                                color (128, 128, 255));                     // Color

        score = 0;
        gameOver = false;

        InitPickups ();
        
        print ("\n\nGameManager Constructor...\n");
    }

    public void Update ()
    {
        if (gameOver)
            return;

        player.Update ();
        enemyManager.Update ();

        for (Pickup pickup : pickups)
        {
            pickup.Update ();
        }
    }

    public void Draw ()
    {
        DrawBackground ();
        player.Draw ();
        enemyManager.Draw();
        barrierManager.DrawBarriers();

        for (Pickup pickup : pickups)
        {
            pickup.Draw ();
        }

        if (gameOver)
            DrawGameOverScreen ();
    }

    private void DrawBackground ()
    {
        background (0);
        noStroke ();
        fill (255, 0, 0, 64);
        rectMode(CENTER);
        rect(width * 0.5f, height - 48, width, 96);

        textSize(textSize);
        fill(255, 255, 255, 255);
        textAlign(RIGHT, BOTTOM);
        textSize(32f);
        text("SCORE: " + score, width, height);
    }

    private void DrawGameOverScreen ()
    {
        textSize(textSize);
        fill(255, 255, 255, 127);
        textAlign(CENTER);
        text("Game Over", width/2, height/2);    
        textSize(textSize/2);
        text("Your score was: " + score + "!", width/2, height/2+128);
    }

    public void GameOver ()
    {
        gameOver = true;
    }

    public void SpawnPickup ()
    {
        if (pickups[pickupsIndex].CouldSpawn ())
            pickupsIndex = (pickupsIndex + 1) % pickups.length;
    }

    private void InitPickups ()
    {
        pickups = new Pickup[2];

        pickups[TWIN_GUN] = new TwinGun (180f, 12f);
        pickups[EXTRA_LIFE] = new ExtraLife (120f, 16f);

        pickupsIndex = 0;
    }
}

final int TWIN_GUN = 0;
final int EXTRA_LIFE = 1;
