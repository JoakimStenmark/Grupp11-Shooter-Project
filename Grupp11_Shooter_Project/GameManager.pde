// Joakim Stenmark & Eddie Norberg
GameManager gameManager;

public class GameManager
{
    MenuManager menuManager;
    EnemyManager enemyManager;
    EnemyManager[] waves;
    int currentWave = 0;
    float timeBetweenWaves = 2000;
    float timeBetweenWavesCounter;

    BarrierManager barrierManager;
    Player player;

    boolean gameIsPaused;
    boolean gameOver;
    boolean victory;
    int textSize = 96;
    int score;
    int killCount;
    int spawnGoal;

    Pickup[] pickups;
    int pickupsIndex;
    float fadeIn;
    boolean waitingForNextWave = false;

    PImage skyBackground;
    // DEBUG
    boolean drawAABB = false;
    boolean pauseDebug = false;

    GameManager ()
    {
        menuManager = new MenuManager ();

        gameIsPaused = true;

        print ("\n\nGameManager Constructor...\n");

        skyBackground = loadImage("NightSky.jpg");
    }

    public void Update ()
    {
        if (gameOver || gameIsPaused || victory || pauseDebug)
            return;

        player.Update ();
        enemyManager.Update ();

        if (enemyManager.enemyCount == 0) 
        {
            if (currentWave + 1 >= waves.length - 1)
                victory = true;
            else
                StartNextWave();        
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

        if (gameOver)
            DrawGameOverScreen ();
        else if (victory)
            DrawVictoryScreen();

        if (waitingForNextWave) 
        {   

            textSize(textSize/2);
            fill(255, 255, 255, fadeIn);
            textAlign(CENTER);
            text("Next wave inbound...", width/2, height/2);    
            fadeIn += 5;
            if (fadeIn > 127) 
            {
                fadeIn = 0;    
            }
        }
    }

    private void DrawBackground ()
    {
        background (0);
        image(skyBackground, 0, 0, width, height);
        noStroke ();
        fill (85, 45, 10, 255);
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
        text("Your score was: " + score + "!\n'r' to restart game.", width * 0.5, height * 0.5+128);
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
            // println("fadeIn: "+fadeIn);
        }
        fill(0, 0, 0, fadeIn);
        rectMode(CORNER);
        rect(0, 0, width, height);
        fill(255, 255, 255, fadeIn);
        textAlign(CENTER);
        textSize(textSize);
        text("You won!", width/3, height/3);
        textSize(textSize/2);
        text("The earth is safe", width/2, height/2);    
        text("Your score was: " + score + "!\n'r' to restart game.", width/2, height/2+96);
    }

    public void StartGame ()
    {
        //loading all waves
        waves = new EnemyManager[11];
        waves[0] = new Wave0();
        waves[1] = new Wave1();
        waves[2] = new Wave2();
        waves[3] = new Wave3();
        waves[4] = new Wave4();
        waves[5] = new Wave5();
        waves[6] = new Wave6();
        waves[7] = new Wave7();
        waves[8] = new Wave8();
        waves[9] = new Wave9();
        waves[10] = new Ending();

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
        gameIsPaused = false;
        victory = false;

        killCount = 0;
        spawnGoal = 5;

        InitPickups ();
    }

    public void EnemyGotKilled (int points)
    {
        score += points;
		enemyManager.enemyCount -= 1;

        killCount++;
        if (killCount % spawnGoal == 0)
            SpawnPickup ();
    }

    public void PauseGame ()
    {
        if (!gameIsPaused)
            pauseDebug = !pauseDebug;
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

    public void StartNextWave()
    {
        if (!waitingForNextWave) 
        {
            timeBetweenWavesCounter = millis() + timeBetweenWaves;
            waitingForNextWave = true;
        }

        if (millis() >= timeBetweenWavesCounter) 
        {
            waitingForNextWave = false;
            currentWave++;
            fadeIn = 0;
            if (currentWave < waves.length) 
            {
                enemyManager = waves[currentWave];
                if (waves[currentWave] instanceof Ending) 
                {
                    victory = true;
                }
            }
            
        }

    }
}

final int TWIN_GUN = 0;
final int EXTRA_LIFE = 1;
