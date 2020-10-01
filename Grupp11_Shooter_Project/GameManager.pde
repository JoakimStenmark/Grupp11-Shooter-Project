public class GameManager
{
    EnemyManager enemyManager;
    EnemyManager[] waves;
    int currentWave = 0;
    BarrierManager barrierManager;
    Player player;

    boolean gameOver;
    int textSize = 96;
    int score;

    Pickup[] pickups;
    int pickupsIndex;

    // DEBUG
    boolean drawAABB = false;

    GameManager ()
    {
        //loading all waves
        waves = new EnemyManager[4];
        waves[0] = new Wave0();
        waves[1] = new Wave1();
        waves[2] = new Wave2();
        waves[3] = new Wave3();

        //current wave
        enemyManager = waves[currentWave];
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

        if (enemyManager.enemyCount == 0) 
        {
            currentWave++;
            if (currentWave >= waves.length) 
            {
                currentWave = 0;
            }
            
            enemyManager = waves[currentWave];
        }

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
