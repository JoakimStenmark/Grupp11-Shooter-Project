public class GameManager
{
    EnemyManager enemyManager;
    BarrierManager barrierManager;
    Player player;

    boolean gameOver;
    int textSize = 96;
    int score;

    GameManager ()
    {
        enemyManager = new EnemyManager ();
        barrierManager = new BarrierManager();
        player = new Player (   new PVector (width * 0.5f, height - 100),  // Position
                                new PVector (0, -1f),                       // Direction
                                120f,                                       // Speed
                                16f,                                        // Radius
                                color (128, 128, 255));                     // Color

        score = 0;
        gameOver = false;
        
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
        }

    }

    public void Draw ()
    {
        player.Draw ();
        enemyManager.Draw();
        barrierManager.DrawBarriers();
        if (gameOver) 
        {
            textSize(textSize);
            fill(255, 255, 255, 127);
            textAlign(CENTER);
            text("Game Over", width/2, height/2);    
            textSize(textSize/2);
            text("Your score was: " + score + "!", width/2, height/2+128);    

        }
        else 
        {
            textSize(24);
            fill(255, 255, 255, 127);
            textAlign(LEFT,TOP);
            text("Score: " + score, 0, 0);
        }

    }

    
}
