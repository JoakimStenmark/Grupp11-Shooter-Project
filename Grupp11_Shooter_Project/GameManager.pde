
public class GameManager
{
    EnemyManager enemyManager;
    Player player;
<<<<<<< HEAD

    boolean gameOver = false;

=======
    int score;
    int textSize = 96;
>>>>>>> parent of 89d4a85... Merge branch 'master' into Jockes-Branch
    GameManager ()
    {
        enemyManager = new EnemyManager ();

        player = new Player (   new PVector (width * 0.5f, height * 0.5f),  // Position
                                new PVector (0, -1f),                       // Direction
                                120f,                                       // Speed
                                16f,                                        // Radius
                                color (128, 128, 255));                     // Color

        print ("\n\nGameManager Constructor...");
    }

    public void Init ()
    {
    }

    public void Update ()
    {
<<<<<<< HEAD
        player.Update ();
        enemyManager.Update ();
=======
        if (gameOver) 
        {
            enemyManager.update();
            player.Update ();
            
        }

>>>>>>> parent of 89d4a85... Merge branch 'master' into Jockes-Branch
    }

    public void Draw ()
    {
<<<<<<< HEAD
        player.Draw ();
=======

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
>>>>>>> parent of 89d4a85... Merge branch 'master' into Jockes-Branch
    }
}