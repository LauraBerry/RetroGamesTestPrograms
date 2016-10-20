# Commodore VIC20 Test Programs

This is a collection of test programs for the Commodore VIC20.
Each has some use in the game we are making for our Retrogames course at the University of Calgary

These should serve as the building blocks for our Retrogame project: Pompeii II.

## Test Program Listing
1. Clear the Screen
  * Testing that we can get control to transfer to an assembly program and back. This just clears the screen.
2. Fonts - Konrad
  * Get a bitmap font in memory with whatever characters/numbers we need.
  * Dump the 64-character font to the screen.
3. Screen Test - Yue
  * Show that we can draw characters and move them around by writing directly to screen memory.
  * Show that we can manipulate text by writing a fast routine to copy a line of text downwards.
4. Movable Character
  * Allow the user to move a character around the screen by pressing buttons.
  * Use WSAD to move the character. Currently there is no sprite, just a cool looking trail of constantly incrementing characters.
5. Input Test - Andrew
  * Get input from the keyboard.
  * Input WSAD, and an arrow will be printed on screen corresponding to the direction you pressed.
6. Score Display - Konrad
  * Show some numbers that can increment at the top of the screen. (Using bitmap fonts)
  * The numbers are stored as an integer in memory. They're converted to a 3-digit number and then to character codes for printing.
7. Sound Test - Andrew
  * Play some sounds on the VIC20 sound hardware.
8. Generate a Random Pattern of Lava - Konrad
  * Generates a grid pattern of tiles with a random distribution
  * The random distribution is due to a simple Linear Congruential Generator
  * A threshold can be specified, determining approximately how much lava will fill the screen.
9. Timing Test - Laura
  * Runs through three background colors at set intervals, 3 seconds apart. 
  * The lava will change its state at three second intervals. This function will serve as the basis for controlling that.
10. Game Loop - Laura
  * Simulate game state transitions
  * Hitting the enter key takes the user from main menu state to the game state to the game over state.
