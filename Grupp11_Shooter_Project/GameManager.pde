public class GameManager
{
    MenuManager menuManager;
    EnemyManager enemyManager;
    EnemyManager[] waves;
    int currentWave = 3;
    BarrierManager barrierManager;
    Player player;

    boolean gameIsPaused;
    boolean gameOver;
    boolean victory;
    int textSize = 96;
    int score;

    Pickup[] pickups;
    int pickupsIndex;
    float fadeIn;

    // DEBUG
    boolean drawAABB = false;

    GameManager ()
    {
        menuManager = new MenuManager ();

        //loading all waves
        waves = new EnemyManager[5];
        waves[0] = new Wave0();
        waves[1] = new Wave1();
        waves[2] = new Wave2();
        waves[3] = new Wave3();
        waves[4] = new Ending();

        //current wave
        enemyManager = waves[currentWave];
        barrierManager = new BarrierManager ();

        player = new Player (   new PVector (width * 0.5f, height - 96),    // Position
                                new PVector (0, -1f),                       // Direction
                                240f,                                       // Speed
                                16f,                                        // Radius
                                color (128, 128, 255));                     // Color
        fadeIn = 0;
        score = 0;
        gameOver = false;
        gameIsPaused = true;
        victory = false;

        InitPickups ();
        
        print ("\n\nGameManager Constructor...\n");
    }

    public void Update ()
    {
        // if (victory) 
        // {
        //     return;
        // }

        if (gameOver || gameIsPaused)
            return;

        player.Update ();
        enemyManager.Update ();

        if (enemyManager.enemyCount == 0) 
        {
            currentWave++;
            if (currentWave < waves.length) 
            {
                enemyManager = waves[currentWave];
                if (waves[currentWave] instanceof Ending) 
                {
                    victory = true;
                }
            }
    
        }

        for (Pickup pickup : pickups)
        {
            pickup.Update ();
        }
    }

    public void Draw ()
    {
        if (gameIsPaused)
        {
            menuManager.Draw ();
            return;
        }

        DrawBackground ();
        player.Draw ();
        enemyManager.Draw();
        barrierManager.DrawBarriers();

        for (Pickup pickup : pickups)
        {
            pickup.Draw ();
        }

        if (victory) 
        {
            DrawVictoryScreen();
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

    public void DrawVictoryScreen() 
    {
        if (fadeIn < 255) 
        {
            fadeIn += 1;
            println("fadeIn: "+fadeIn);
        }
        fill(0, 0, 0, fadeIn);
        rectMode(CORNER);
        rect(0, 0, width, height);
        fill(255, 255, 255, fadeIn);
        textAlign(CENTER);
        textSize(textSize);
        text("You won!", width/2, height/2);
        textSize(textSize/2);
        text("The earth is safe", width/2, height/2+96);    
        text("Your score was: " + score + "!", width/2, height/2+256);

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
