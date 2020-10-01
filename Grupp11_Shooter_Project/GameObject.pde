// Eddie Norberg (mostly)

class GameObject
{
	PVector position;
	PVector direction;
	int health;
	color col = 255;

	float speed;

	float radius;
	float diameter;

	BoundingBox aabb;

	String _name;

	boolean isActive = false;

	public boolean DidCollideCircle (GameObject other)
	{
		float maxDistance = radius + other.radius;

        if (abs (position.x - other.position.x) > maxDistance || abs (position.y - other.position.y) > maxDistance)
            return false;

        if (PVector.dist (position, other.position) > maxDistance)
            return false;

		return true;
	}

	public boolean DidCollide (GameObject other)
	{
		return aabb.CollidedWithAABB (other.aabb, GetVelocity (), _name, other._name);
	}

	public PVector GetVelocity ()
	{
		return direction.copy ().mult (speed * deltaTime);
	}
}
