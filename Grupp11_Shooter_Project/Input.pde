public Input input = new Input ();

public class Input
{
    private PVector direction;

    // public int left;
    // public int right;

    BUTTON_STATE[] buttons;

    public boolean shootDown;
    public boolean restartDown;
    public boolean aabbDown;
    public boolean upMenuDown;
    public boolean downMenuDown;

    // temp...
 
    Input ()
    {
        direction = new PVector ();

        buttons = new BUTTON_STATE[6];
        for (int i = 0; i < buttons.length; i++)
        {
            buttons[i] = BUTTON_STATE.NONE;
        }

        shootDown = false;
        restartDown = false;
        aabbDown = false;
        upMenuDown = false;
        downMenuDown = false;
        
        // left = 37;
        // right = 39;
    }

    public PVector GetDirectionRAW ()
    {
        return direction;
    }

    public PVector GetDirectionNormalized ()
    {
        return direction.normalize ();
    }

    public void SetInput (BUTTON_NAME button, boolean pressed)
    {
        int buttonIndex = button.value;
        BUTTON_STATE previousState = buttons[buttonIndex];

        // print ("\n\nButton: " + button + " - prevState: " + previousState);

        if (pressed)
        {
            if (previousState == BUTTON_STATE.PRESSED || previousState == BUTTON_STATE.HOLD)
                buttons[buttonIndex] = BUTTON_STATE.HOLD;
            else
                buttons[buttonIndex] = BUTTON_STATE.PRESSED;
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

        int rightState = buttons[BUTTON_NAME.RIGHT.value].value;
        int leftState = buttons[BUTTON_NAME.LEFT.value].value;
        int upState = buttons[BUTTON_NAME.UP.value].value;
        int downState = buttons[BUTTON_NAME.DOWN.value].value;

        if (rightState == BUTTON_STATE.PRESSED.value || rightState == BUTTON_STATE.HOLD.value)
            direction.x++;

        if (leftState == BUTTON_STATE.PRESSED.value || leftState == BUTTON_STATE.HOLD.value)
            direction.x--;

        if (upState == BUTTON_STATE.PRESSED.value || upState == BUTTON_STATE.HOLD.value)
            direction.y--;

        if (downState == BUTTON_STATE.PRESSED.value || downState == BUTTON_STATE.HOLD.value)
            direction.y++;

        // direction.x += buttons[BUTTON_NAME.RIGHT.value].value - buttons[BUTTON_NAME.LEFT.value].value;
        // direction.y += buttons[BUTTON_NAME.DOWN.value].value - buttons[BUTTON_NAME.UP.value].value;
    }

    private void ResetDirectionButtons ()
    {
        for (int i = 0; i < buttons.length; i++)
        {
            if (buttons[i] == BUTTON_STATE.RELEASED)
                buttons[i] = BUTTON_STATE.NONE;
        }
    }

    // public boolean GetButtonDown (int buttonName)
    // {
    //     return (buttons[buttonName].value == BUTTON_STATE.PRESSED.value) ? true : false;
    // }

    public void DisplayInputText (PVector position)
    {
        BUTTON_NAME[] buttonNames = new BUTTON_NAME[] {BUTTON_NAME.LEFT, BUTTON_NAME.RIGHT, BUTTON_NAME.UP, BUTTON_NAME.DOWN, BUTTON_NAME.SHOOT, BUTTON_NAME.RESTART};
    
        textSize (32f);
        textAlign (LEFT, TOP);

        for (int i = 0; i < input.buttons.length; i++)
        {
            text ("Button: " + buttonNames[i] + " - [" + input.buttons[i] + "]\n", position.x, position.y + (32f * i));
        }
    }

    public void Update ()
    {
        UpdateDirection ();
        ResetDirectionButtons ();
    }
}

enum BUTTON_STATE
{
    NONE (0),
    PRESSED (1),
    HOLD (2),
    RELEASED (3);

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
    // DIRECTION
    if (keyCode == LEFT || key == 'a')
        input.SetInput (BUTTON_NAME.LEFT, true);
    if (keyCode == RIGHT || key == 'd')
        input.SetInput (BUTTON_NAME.RIGHT, true);
    // if (keyCode == UP || key == 'w')
    //     input.SetInput (BUTTON_NAME.UP, true);
    // if (keyCode == DOWN || key == 's')
    //     input.SetInput (BUTTON_NAME.DOWN, true);

    // SHOOT / CONFIRM
    if (key == 'k' && !input.shootDown)
    {
        input.SetInput (BUTTON_NAME.SHOOT, true);
        input.shootDown = true;

        if (gameManager.menuManager.isOpen)
            gameManager.menuManager.Confirm ();
        else
            gameManager.player.Shoot ();
    }

    // RESTART
    if (key == 'r' && !input.restartDown)
    {
        input.restartDown = true;
        Init ();
    }

    // DRAW AABB
    if (key == 'b' && !input.aabbDown)
    {
        input.aabbDown = true;
        gameManager.drawAABB = !gameManager.drawAABB;
    }

    // MOVE UP/DOWN - MENU
    if ((keyCode == UP || key == 'w') && !input.upMenuDown)
    {
        input.upMenuDown = true;
        gameManager.menuManager.MoveMenu (-1);
    }
    else if ((keyCode == DOWN || key == 's') && !input.downMenuDown)
    {
        input.downMenuDown = true;
        gameManager.menuManager.MoveMenu (1);
    }
}

void keyReleased ()
{
    // DIRECTION
    if (keyCode == LEFT || key == 'a')
        input.SetInput (BUTTON_NAME.LEFT, false);
    if (keyCode == RIGHT || key == 'd')
        input.SetInput (BUTTON_NAME.RIGHT, false);
    // if (keyCode == UP || key == 'w')
    //     input.SetInput (BUTTON_NAME.UP, false);
    // if (keyCode == DOWN || key == 's')
    //     input.SetInput (BUTTON_NAME.DOWN, false);

    // SHOOT
    if (key == 'k' && input.shootDown)
    {
        input.SetInput (BUTTON_NAME.SHOOT, false);
        input.shootDown = false;
    }

    // RESTART
    if (key == 'r' && input.restartDown)
        input.restartDown = false;

    // DRAW AABB
    if (key == 'b' && input.aabbDown)
        input.aabbDown = false;

    // MOVE UP - MENU
    if ((keyCode == UP || key == 'w') && input.upMenuDown)
        input.upMenuDown = false;

    // MOVE DOWN - MENU
    if ((keyCode == DOWN || key == 's') && input.downMenuDown)
        input.downMenuDown = false;
}
