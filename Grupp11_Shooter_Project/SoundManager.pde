import processing.sound.*;

SoundManager soundManager;


public class SoundManager 
{
	PApplet sketchRef;
	SoundFile music;
	SoundFile playerShot;
	SoundFile explosion;
	SoundFile playerMovingSound;


	boolean playerMoving = false;

	SoundManager(PApplet pApplet)
	{
		sketchRef = pApplet;
		
		playerMovingSound = new SoundFile(sketchRef, "Move.wav");

	}

	void Update()
	{

	}

	public void PlayMusic() 
	{
		music = new SoundFile(sketchRef , "Music.wav");	
		music.play();
	}

	public void PlaySound(String fileName) 
	{
		SoundFile soundToPlay = new SoundFile(sketchRef, fileName);;
		soundToPlay.play();
	}
}
