Input input = new Input ();

public class Input
{
    private PVector direction;

    public int left;
    public int right;

    BUTTON_STATE[] buttons;

    public boolean shootDown;
    public boolean restartDown;

    // temp...
 
    Input ()
    {
        direction = new PVector ();

        buttons = new BUTTON_STATE[6];
        for (int i = 0; i < buttons.length; i++)
        {
            buttons[i] = BUTTON_STATE.NONE;
        }
        
        left = 37;
        right = 39;
    }

    public PVector GetDirectionRAW ()
    {
        return direction;
    }

    public PVector GetDirectionNormalized ()
    {
        return direction.normalize ();
        // return direction.normalized ();
    }

    public void SetInput (BUTTON_NAME button, boolean pressed)
    {
        int buttonIndex = button.value;
        BUTTON_STATE previousState = buttons[buttonIndex];

        // print ("\n\nButton: " + button + " - prevState: " + previousState);

        if (pressed)
        {
            if (previousState == BUTTON_STATE.NONE || previousState == BUTTON_STATE.RELEASED)
                buttons[buttonIndex] = BUTTON_STATE.PRESSED;
            else
                buttons[buttonIndex] = BUTTON_STATE.HOLD;
        }
        else
            if (previousState == BUTTON_STATE.RELEASED)
                buttons[buttonIndex] = BUTTON_STATE.NONE;
            else
                buttons[buttonIndex] = BUTTON_STATE.RELEASED;

        // print ("\nButton: " + button + " - newState: " + buttons[buttonIndex]);
    }

    public void UpdateDirection ()
    {
        direction = new PVector ();

        direction.x += buttons[BUTTON_NAME.RIGHT.value].value - buttons[BUTTON_NAME.LEFT.value].value;
        direction.y += buttons[BUTTON_NAME.DOWN.value].value - buttons[BUTTON_NAME.UP.value].value;
    }

    public void ResetDirectionButtons ()
    {
        for (int i = 0; i < buttons.length; i++)
        {
            if (buttons[i] == BUTTON_STATE.RELEASED)
                buttons[i] = BUTTON_STATE.NONE;
        }
    }

    // public boolean GetButtonDown (BUTTON_NAME buttonName)
    // {
    //     print ("\n\nb1: " + buttons[buttonName.value] + "\nb2: " + BUTTON_STATE.value);
    //     return (buttons[buttonName.value] == BUTTON_STATE.DOWN) ? true : false;
    // }

    public void DisplayInputText (PVector position)
    {
        BUTTON_NAME[] buttonNames = new BUTTON_NAME[] {BUTTON_NAME.LEFT, BUTTON_NAME.RIGHT, BUTTON_NAME.UP, BUTTON_NAME.DOWN, BUTTON_NAME.SHOOT};
    
        textSize (32f);
        textAlign (LEFT, TOP);

        for (int i = 0; i < input.buttons.length; i++)
        {
            text ("Button: " + buttonNames[i] + " - [" + input.buttons[i] + "]\n", position.x, position.y + (32f * i));
        }
    }
}

enum BUTTON_STATE
{
    NONE (0),
    PRESSED (1),
    HOLD (1),
    RELEASED (0);

    private int value;

    private BUTTON_STATE (int value)
    {
        this.value = value;
    }
}

enum BUTTON_NAME
{
    LEFT (0),
    RIGHT (1),
    UP (2),
    DOWN (3),
    SHOOT (4),
    RESTART (5);

    private int value;

    private BUTTON_NAME (int value)
    {
        this.value = value;
    }
}

void keyPressed ()
{
    if (keyCode == LEFT || key == 'a')
        input.SetInput (BUTTON_NAME.LEFT, true);
    if (keyCode == RIGHT || key == 'd')
        input.SetInput (BUTTON_NAME.RIGHT, true);
    if (keyCode == UP || key == 'w')
        input.SetInput (BUTTON_NAME.UP, true);
    if (keyCode == DOWN || key == 's')
        input.SetInput (BUTTON_NAME.DOWN, true);

    if (key == 'k')
        input.SetInput (BUTTON_NAME.SHOOT, true);

    if (key == 'r')
        input.SetInput (BUTTON_NAME.RESTART, true);
}

void keyReleased ()
{
    if (keyCode == LEFT || key == 'a')
        input.SetInput (BUTTON_NAME.LEFT, false);
    if (keyCode == RIGHT || key == 'd')
        input.SetInput (BUTTON_NAME.RIGHT, false);
    if (keyCode == UP || key == 'w')
        input.SetInput (BUTTON_NAME.UP, false);
    if (keyCode == DOWN || key == 's')
        input.SetInput (BUTTON_NAME.DOWN, false);

    if (key == 'k')
        input.SetInput (BUTTON_NAME.SHOOT, false);

    if (key == 'r')
        input.SetInput (BUTTON_NAME.RESTART, true);
}