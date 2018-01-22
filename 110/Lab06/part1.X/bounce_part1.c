// **** Include libraries here ****
// Standard libraries

//CMPE13 Support Library
#include "BOARD.h"
#include "leds.h"

// Microchip libraries
#include <xc.h>
#include <plib.h>

// User libraries
#define left 1
#define right 0
// **** Set macros and preprocessor directives ****

// **** Declare any datatypes here ****

// **** Define global, module-level, or external variables here ****
//Call static functions here to use in ISR (input and output of ISR)
// **** Declare function prototypes ****
// Timer Result

struct timer {
    int event;
    int counter;
} timer;

int main(void)
{
    BOARD_Init();
    // Configure Timer 1 using PBCLK as input. This default period will make the LEDs blink at a
    // pretty reasonable rate to start.
    OpenTimer1(T1_ON | T1_SOURCE_INT | T1_PS_1_8, 0xFFFF);

    // Set up the timer interrupt with a priority of 4.
    INTClearFlag(INT_T1);
    INTSetVectorPriority(INT_TIMER_1_VECTOR, INT_PRIORITY_LEVEL_4);
    INTSetVectorSubPriority(INT_TIMER_1_VECTOR, INT_SUB_PRIORITY_LEVEL_0);
    INTEnable(INT_T1, INT_ENABLED);

    /***************************************************************************************************
     * Your code goes in between this comment and the following one with asterisks.
     **************************************************************************************************/
    int dir = left;
    int shine = 0x01;
    LEDS_INIT();
    while (1) {
	LEDS_SET(shine);
	if (timer.event == 1) { //time to switch
	    if (dir == left && LEDS_GET() == 0x80) {//if light reaches end
		dir = right; //change direction to right
	    } else if (dir == right && LEDS_GET() == 0x01) {
		dir = left; //change direction to left
	    }

	    if (dir == right) {
		shine = shine >> 1; //continue moving light right
	    }
	    
	    if (dir == left) {
		shine = shine << 1; //continue moving light left
	    }
	    timer.event = 0; //reset timer
	}
    }

    /***************************************************************************************************
     * Your code goes in between this comment and the preceding one with asterisks
     **************************************************************************************************/

    while (1);
}

/**
 * This is the interrupt for the Timer1 peripheral. During each call it increments a counter (the
 * value member of a module-level TimerResult struct). This counter is then checked against the
 * binary values of the four switches on the I/O Shield (where SW1 has a value of 1, SW2 has a value
 * of 2, etc.). If the current counter is greater than this switch value, then the event member of a
 * module-level TimerResult struct is set to true and the value member is cleared.
 */
void __ISR(_TIMER_1_VECTOR, IPL4AUTO) Timer1Handler(void)
{
    // Clear the interrupt flag.
    INTClearFlag(INT_T1);
    if (timer.counter >= SWITCH_STATES()) {
	timer.event = 1;
	timer.counter = 0;
    } else {
	timer.counter++;
    }



}