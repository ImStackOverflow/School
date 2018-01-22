#ifndef OLED_H
#define OLED_H

#include <stdbool.h>
#include <stdlib.h>

#include "OledDriver.h"
#include "Ascii.h"

/**
 * Initializes the OLED, turns it on, and clears the screen.
 */
void OledInit(void);

/**
 * Reads the value of the given pixel from the frame buffer.
 * @param x The X position (left is zero)
 * @param y The Y position (top is zero)
 * @return 1 if the pixel is white (on) or 0 if the pixel is black (off)
 */
int OledGetPixel(int x, int y);

/**
 * Sets a specific pixel in the frame buffer, available colors are black or white.
 * @note OledUpdate() must be called before the OLED will actually display these changes.
 * @param x The X position (left is zero)
 * @param y The Y position (top is zero)
 * @param color 1 to indicate white, or 0 for black.
 */
void OledSetPixel(int x, int y, int color);

/**
 * Draws the specified character at the specified position, using Ascii.h as the font.
 * @param x The x-position to use as the left-most value for the character.
 * @param y The y-position to use as the top-most value for the character
 * @param c The character to write. Uses the character array defined in Ascii.h
 * @return True if the write succeeded. Fails on invalid inputs.
 */
bool OledDrawChar(int x, int y, char c);

/**
 * Draws a string to the OLED framebuffer, starting on the top line. 21 characters fit on the 4 lines
 * on the screen. Characters are wrapped to the next line if a newline character is encountered or
 * if OLED_CHARS_PER_LINE is reached.
 * @note Areas not overwritten with characters will still contain old character data.
 * @note OledUpdate() must be called to actually update the OLED with the updated framebuffer contents.
 * @param string A null-terminated string to print.
 */
void OledDrawString(const char *string);

/**
 * Writes the specified color pixels to the entire frame buffer.
 * @param color 0 to set the entire screen black, 1 to set the entire screen to white.
 */
void OledClear(int color);

/**
 * Redraws the OLED display based on the contents of rgb0ledBmp. Use after rgb0ledBmp is modified.
 */
void OledUpdate(void);

#endif // OLED_H