// Joakim Stenmark (Originally Creator)

public class BarrierManager
{
	float barrierSize = 10;

	Barrier[] bigBarrier1;
	Barrier[] bigBarrier2;
	Barrier[] bigBarrier3;

	BarrierManager()
	{
		MakeNewBarriers();
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
				bigBarrier1[i*4+j] = new Barrier((width * 0.125f) + j * (barrierSize * 2), height * 0.75 + i * barrierSize * 2, new PVector(), 4, barrierSize);
				bigBarrier2[i*4+j] = new Barrier(width * 0.46f + j * barrierSize * 2, height * 0.75 + i * barrierSize * 2, new PVector(), 4, barrierSize);   
				bigBarrier3[i*4+j] = new Barrier(width * 0.875f - j * barrierSize * 2, height * 0.75 + i * barrierSize * 2, new PVector(), 4, barrierSize);   

				bigBarrier1[i*4+j]._name = "BB1_["+ i + "," + j +"]";
				bigBarrier2[i*4+j]._name = "BB2_["+ i + "," + j +"]";
				bigBarrier3[i*4+j]._name = "BB3_["+ i + "," + j +"]";
			}
		}

		bigBarrier1[0].isActive = false;
		bigBarrier1[3].isActive = false;

		bigBarrier2[0].isActive = false;
		bigBarrier2[3].isActive = false;

		bigBarrier3[0].isActive = false;
		bigBarrier3[3].isActive = false;
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
