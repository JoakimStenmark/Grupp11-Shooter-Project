// Eddie Norberg

public class MenuManager
{
    boolean isOpen;
    boolean drawTitleScreen;

    String[] textButtons;
    int buttonIndex;

    MenuManager ()
    {
        isOpen = true;
        drawTitleScreen = true;

        textButtons = new String[] {"PLAY", "CONTROLS"};
        buttonIndex = 0;
    }

    public void Draw ()
    {
        if (drawTitleScreen)
            DrawTitleScreen ();
        else
            DrawControls ();
    }

    private void DrawTitleScreen ()
    {
        background (0);

        PVector offset = new PVector (width * 0.5f, height * 0.5f);
        float fontSize = 64f;
        float lineHeight = 64f;

        color selectedColor = color (255);
        color deselectedColor = color (0);

        textAlign (CENTER);

        textSize (72f);
        fill (255, 64, 64);
        text ("SPACE MY VADERS", offset.x, offset.y * 0.5f);

        textSize (fontSize);

        for (int i = 0; i < textButtons.length; i++)
        {
            if (i == buttonIndex)
            {
                stroke (selectedColor);
                fill(255, 255, 128, 255);
            }
            else
            {
                stroke (deselectedColor);
                fill(128, 128, 64, 255);
            }

            text (textButtons[i], offset.x, offset.y + lineHeight * i);
        }
    }

    private void DrawControls ()
    {
        background (0);

        PVector offset = new PVector (width * 0.5f, height * 0.25f);
        float lineHeight = 64f;

        stroke (192, 192, 64);
        strokeWeight (2);
        fill (255);

        textSize (48f);
        textAlign (CENTER);

        fill (255, 64, 64);
        text ("CONTROLS", offset.x, offset.y);
        
        fill (255);
        offset.y += lineHeight * 2f;
        textSize (32f);
        text ("MOVE = LEFT 'a' + RIGHT 'd'", offset.x, offset.y);
        offset.y += lineHeight;
        text ("SHOOT = 'k'", offset.x, offset.y);
        offset.y += lineHeight;
        text ("RESTART = 'r'", offset.x, offset.y);
        
        textSize (20f);
        offset.y += lineHeight * 0.75f;
        fill (128, 255, 128);
        text ("DEBUG MODE = 'b'", offset.x, offset.y);

        fill (255, 192, 32);
        offset.y += lineHeight * 1f;
        textSize (24f);
        text ("Kill all enemies before they reach the end zone.\nUse your Barriers and powerups.", offset.x, offset.y);
        
        textSize (32f);
        offset.y += lineHeight * 2f;
        text ("Press 'k' to return to Title", offset.x, offset.y);

    }

    public void Confirm ()
    {
        if (buttonIndex == START_GAME)
        {
            gameManager.StartGame ();
            isOpen = false;
            return;
        }
        else
            drawTitleScreen = !drawTitleScreen;
    }

    public void MoveMenu (int amount)
    {
        if (!drawTitleScreen)
            return;

        buttonIndex += amount;
        if (buttonIndex < 0)
            buttonIndex = textButtons.length - 1;
        else if (buttonIndex >= textButtons.length)
            buttonIndex = 0;
    }
}

final int START_GAME = 0;