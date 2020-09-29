public class GameManager
{
    // EnemyManager enemyManager;
    Player player;

    int score;
    int textSize = 96;



    GameManager ()
    {
        // enemyManager = new EnemyManager ();

        player = new Player (   new PVector (width * 0.5f, height * 0.5f),  // Position
                                new PVector (0, -1f),                       // Direction
                                120f,                                       // Speed
                                16f,                                        // Radius
                                color (255, 0, 0));                         // Color

        print ("\n\nGameManager Constructor...");
    }

    public void Init ()
    {
    }

    public void Update ()
    {

        if (gameOver) 
        {
            enemyManager.update();
            player.Update ();
            
        }


        player.Update ();

    }

    public void Draw ()
    {

        enemyManager.Draw();
        player.Draw ();
        if (!gameOver) 
        {
            textSize(textSize);
            fill(255, 255, 255, 127);
            textAlign(CENTER);
            text("Game Over", width/2, height/2);    
            textSize(textSize/2);
            text("Your score was: " + score + "!", width/2, height/2+128);    

        }

        player.Draw ();

    }
}
