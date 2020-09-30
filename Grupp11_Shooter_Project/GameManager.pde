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

    TwinGun twinGun;


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

        twinGun = new TwinGun ( new PVector (width * 0.5f, height * 0.5f),  // Position
                                new PVector (0, 1f),                        // Direction
                                120f,                                       // Speed
                                8f);                                        // Radius
        
        print ("\n\nGameManager Constructor...");
    }   

    public void Init ()
    {
    }

    public void Update ()
    {



        if (!gameOver) 
        {
            player.Update ();
            enemyManager.Update ();

            twinGun.Update ();

            if (enemyManager.enemyCount == 0) 
            {
                currentWave++;
                if (currentWave >= waves.length) 
                {
                    currentWave = 0;
                }
                
                enemyManager = waves[currentWave];
            }
        }

    }

    public void Draw ()
    {
        DrawBackground ();
        player.Draw ();
        enemyManager.Draw();
        barrierManager.DrawBarriers();

        twinGun.Draw ();

        if (gameOver) 
        {
            textSize(textSize);
            fill(255, 255, 255, 127);
            textAlign(CENTER);
            text("Game Over", width/2, height/2);    
            textSize(textSize/2);
            text("Your score was: " + score + "!", width/2, height/2+128);
        }
        println("enemyManager.enemyCount: "+enemyManager.enemyCount);
    }

    private void DrawBackground ()
    {
        background (0);

        fill (255, 0, 0, 64);
        rectMode(CENTER);
        rect(width * 0.5f, height - 48, width, 96);
    }

    public void GameOver ()
    {
        gameOver = true;
    }
}
