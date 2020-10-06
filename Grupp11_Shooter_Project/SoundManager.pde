// Joakim Stenmark
import processing.sound.*;

SoundManager soundManager;

public class SoundManager 
{
	PApplet sketchRef;
	SoundFile music;

	boolean playerMoving;
	SoundFile playerMovingSound;
	SoundFile playerShot1;
	SoundFile playerShot2;
	SoundFile playerShot3;
	SoundFile playerHurtSound;

	SoundFile pickupHealthSound;
	SoundFile pickupPowerupSound;


	SoundFile enemyShot;
	SoundFile enemyHitSound;	
	SoundFile explosion;

	SoundFile gameOverSound;


	SoundManager(PApplet pApplet)
	{
		sketchRef = pApplet;
		
		playerMoving = false;
		playerMovingSound = new SoundFile(sketchRef, "Move.wav");
		playerShot1 = new SoundFile(sketchRef, "Laser_Shoot2.wav");
		playerShot1.amp(0.6);
		playerShot2 = new SoundFile(sketchRef, "LaserDouble_Shoot2.wav");
		playerShot2.amp(0.6);
		playerShot3 = new SoundFile(sketchRef, "LaserTripple_Shoot2.wav");
		playerShot3.amp(0.6);
		playerHurtSound = new SoundFile(sketchRef, "Player_hurt.wav");

		pickupHealthSound = new SoundFile(sketchRef, "Powerup3.wav");
		pickupPowerupSound = new SoundFile(sketchRef, "Life_Get.wav");

		enemyShot = new SoundFile(sketchRef, "Laser_Shoot.wav");
		enemyShot.amp(0.7);
		enemyHitSound = new SoundFile(sketchRef, "EnemyHit.wav");


		explosion = new SoundFile(sketchRef, "Explosion.wav");
		enemyShot.amp(0.8);
		
		gameOverSound = new SoundFile(sketchRef, "GameOver.wav");

		PlayMusic(); 
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


}
