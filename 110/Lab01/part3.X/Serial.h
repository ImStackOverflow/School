#ifndef SERIAL_H
#define SERIAL_H

#include <stdio.h>
/**
 * Initialize the UART peripheral for use by the PIC. Also sets stdin/stdout to point to the proper
 * UART and disables buffering for both.
 */
void SerialInit(void);
#endif