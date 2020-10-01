public class MenuManager
{
    boolean isOpen;

    String[] textButtons;
    int buttonIndex;

    MenuManager ()
    {
        isOpen = true;

        textButtons = new String[] {"PLAY", "CONTROLS"};
        buttonIndex = 0;
    }

    public void Draw ()
    {
        background (0);

        PVector offset = new PVector (width * 0.5f, height * 0.5f);
        float fontSize = 64f;
        float lineHeight = 64f;

        color selectedColor = color (255);
        color deselectedColor = color (0);

        textSize (fontSize);
        textAlign (CENTER);

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

    public void Confirm ()
    {
        print ("\n\nbuttonIndex " + buttonIndex);
    }

    public void MoveMenu (int amount)
    {
        buttonIndex += amount;
        if (buttonIndex < 0)
            buttonIndex = textButtons.length - 1;
        else if (buttonIndex >= textButtons.length)
            buttonIndex = 0;
    }
}