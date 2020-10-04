import processing.sound.*;

SoundManager soundManager;


public class SoundManager 
{
	PApplet sketchRef;
	SoundFile music;

	SoundFile playerShot1;
	SoundFile playerShot2;
	SoundFile playerShot3;

	SoundFile enemyShot;

	SoundFile explosion;
	SoundFile playerMovingSound;
	SoundFile gameOverSound;

	boolean playerMoving;

	SoundManager(PApplet pApplet)
	{
		sketchRef = pApplet;
		
		playerMovingSound = new SoundFile(sketchRef, "Move.wav");
		
		playerMoving = false;

		gameOverSound = new SoundFile(sketchRef, "GameOver.wav");
		
		PlayMusic(); 

		playerShot1 = new SoundFile(sketchRef, "Laser_Shoot2.wav");
		playerShot1.amp(0.6);
		playerShot2 = new SoundFile(sketchRef, "LaserDouble_Shoot2.wav");
		playerShot2.amp(0.6);
		playerShot3 = new SoundFile(sketchRef, "LaserTripple_Shoot2.wav");
		playerShot3.amp(0.6);

		enemyShot = new SoundFile(sketchRef, "Laser_Shoot.wav");
		enemyShot.amp(0.7);

		explosion = new SoundFile(sketchRef, "Explosion.wav");
		enemyShot.amp(0.8);
	}

	void Update()
	{
		if(playerMoving && playerMovingSound.isPlaying() == false)
		{
			playerMovingSound.loop();
		}
		else 
		{
			playerMovingSound.stop();
		}
	}


	public void PlayMusic() 
	{
		music = new SoundFile(sketchRef , "Music.wav");	
		music.amp(0.8);
		music.loop();
	}

	public void PlaySound(String fileName) 
	{
		SoundFile soundToPlay = new SoundFile(sketchRef, fileName);
		soundToPlay.play();
	}

	public void PlaySound(String fileName, float volume) 
	{
		SoundFile soundToPlay = new SoundFile(sketchRef, fileName);
		soundToPlay.amp(volume);
		soundToPlay.play();
	}

	public void ToggleGameOverMusic(boolean b) 
	{
		if (b) 
		{
			gameOverSound.loop();
		}
		else 
		{
			gameOverSound.stop();
		}

	}
}
