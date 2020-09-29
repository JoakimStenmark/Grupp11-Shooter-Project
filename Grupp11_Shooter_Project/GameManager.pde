public class GameManager
{
    EnemyManager enemyManager;
    Player player;

    boolean gameOver;
    int textSize = 96;
    int score;

    Barrier[] bigBarrier1;
    Barrier[] bigBarrier2;
    Barrier[] bigBarrier3;
    GameManager ()
    {
        enemyManager = new EnemyManager ();

        player = new Player (   new PVector (width * 0.5f, height - 100),  // Position
                                new PVector (0, -1f),                       // Direction
                                120f,                                       // Speed
                                16f,                                        // Radius
                                color (128, 128, 255));                     // Color

        score = 0;
        gameOver = false;
        print ("\n\nGameManager Constructor...");
        bigBarrier1 = new Barrier[6];

        for (int i = 0; i < 2; i++) 
        {
            for (int j = 0; j < 3; j++) 
            {
                
                bigBarrier1[i*3+j] = new Barrier(j * 80, i * 80, new PVector(), 2, 0, 40);   
            }
            
        }
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
        for (Barrier b : bigBarrier1) 
        {
            b.Draw();
        }

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
