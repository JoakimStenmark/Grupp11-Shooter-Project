public class GameManager
{
    EnemyManager enemyManager;
    Player player;

    boolean gameOver;
    int textSize = 96;
    int score;
    float barrierSize = 10;

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
        MakeNewBarriers();
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
        DrawBarriers();

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

    void MakeNewBarriers()
    {
        bigBarrier1 = new Barrier[8];
        bigBarrier2 = new Barrier[8];
        bigBarrier3 = new Barrier[8];


        for (int i = 0; i < 2; i++) 
        {
            for (int j = 0; j < 4; j++) 
            {

                bigBarrier1[i*4+j] = new Barrier((width * 0.125f) + j * (barrierSize * 2), height * 0.75 + i * barrierSize * 2, new PVector(), 2, 0, barrierSize);
                bigBarrier2[i*4+j] = new Barrier(width * 0.46f + j * barrierSize * 2, height * 0.75 + i * barrierSize * 2, new PVector(), 2, 0, barrierSize);   
                bigBarrier3[i*4+j] = new Barrier(width * 0.875f - j * barrierSize * 2, height * 0.75 + i * barrierSize * 2, new PVector(), 2, 0, barrierSize);   

            }
            
        }

        bigBarrier1[0].position = new PVector (-100f, -100f);
        bigBarrier1[3].position = new PVector (-100f, -100f);

        bigBarrier2[0].position = new PVector (-100f, -100f);
        bigBarrier2[3].position = new PVector (-100f, -100f);

        bigBarrier3[0].position = new PVector (-100f, -100f);
        bigBarrier3[3].position = new PVector (-100f, -100f);



    }

    void DrawBarriers()
    {
        for (Barrier b : bigBarrier1) 
        {
            b.Draw();
        }
        for (Barrier b : bigBarrier2) 
        {
            b.Draw();
        }
        for (Barrier b : bigBarrier3) 
        {
            b.Draw();
        }

    }
}
