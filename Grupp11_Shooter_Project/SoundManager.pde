import processing.sound.*;

SoundManager soundManager;


public class SoundManager 
{
	PApplet sketchRef;
	SoundFile music;
	SoundFile playerShot;
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
		music.play();
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
