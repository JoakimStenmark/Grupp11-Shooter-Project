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
        enemyManager = new Wave2 ();
        barrierManager = new BarrierManager ();

        player = new Player (   new PVector (width * 0.5f, height - 96),    // Position
                                new PVector (0, -1f),                       // Direction
                                240f,                                       // Speed
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
        DrawBackground ();
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
