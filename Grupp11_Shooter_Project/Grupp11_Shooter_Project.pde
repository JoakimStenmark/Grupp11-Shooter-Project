// Eddie Norberg
BoundingBox enemy;
BoundingBox player;
float scale = 1f;
boolean debuging = false;
boolean stop = false;
int loopCounter;
boolean newTest = true;

GameManager gameManager;

void setup()
{
	size (672, 768);
	frameRate (60);

	Init ();
}

void draw () 
{
	UpdateDeltaTime ();

	input.Update ();

	if (debuging)
	{
		DebugUpdate ();
		return;
	}

	gameManager.Update ();
	gameManager.Draw ();
}

public void Init ()
{
	gameManager = new GameManager ();
	
	if (debuging)
		DebugInit ();
}

private void DebugInit ()
{
	background (0);

	enemy = new BoundingBox (	new PVector (0f, 200f),
								new PVector (100f, 100f).mult (scale));

	player = new BoundingBox (	new PVector (10f + 100f - 10f, 200f + 100f + 100f),
								new PVector (50f, 50f).mult (scale));

	loopCounter = 0;
	stop = false;

	stroke (255);
	fill (255, 255, 0, 128);
	rect (player.position.x, player.position.y, player.size.x, player.size.y);
	player.Draw ();

	rectMode (CORNER);
	fill (0, 255, 0, 128);
	rect (enemy.position.x, enemy.position.y, enemy.size.x, enemy.size.y);
	println ("e.pos: " + enemy.position);
	println ("e.size: " + enemy.size);
	// enemy.Draw ();
}

private void DebugUpdate ()
{
	if (stop)
		return;

	loopCounter++;

	fill (0, 0, 0, 16);
	rectMode(CORNER);
	rect(0, 0, width, height);

	stroke (255);

	PVector direction = input.GetDirectionRAW ();
	// float speed = 60f;
	// PVector velocity = direction.mult (speed * deltaTime);
	float speed = 10f;
	PVector velocity = direction.mult (speed);
	// velocity.y = -30000f;

	println ("\n\n\nCurrent loop: " + loopCounter);
	println ("Player.pos: " + player.position);
	println ("Enemy.pos: " + enemy.position);
	println ("Diff: " + player.position.copy ().sub (enemy.position));
	println ("Player.vel: " + velocity);

	println ("CheckCollide 1. vel: " + velocity);
	if (player.CollidedWithAABB (enemy, velocity, "Player", "Enemy"))
	{
		println ("HIT! - Looped: " + loopCounter);
		println ("HIT 2. vel: " + velocity);

		fill (255, 0, 0, 192);
		rect (player.position.x + velocity.x, player.position.y + velocity.y, player.size.x, player.size.y);
		player.Update (player.position.copy ().add (velocity));
		player.Draw ();
		stop = true;
		return;
	}
	else
		fill (0);

	player.position.add (velocity);

	rect (player.position.x, player.position.y, player.size.x, player.size.y);
	player.Draw ();

	rectMode (CORNER);
	fill (0, 255, 0, 128);
	rect (enemy.position.x, enemy.position.y, enemy.size.x, enemy.size.y);
	// enemy.Draw ();
}
