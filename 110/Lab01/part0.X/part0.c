/*
 * File:   part0.c
 * Author: Gavin
 *
 */

#include "xc.h"
#include "BOARD.h"

int main(void)
{
    BOARD_Init();
    printf("hello world\n");
    while (1);
    return 0;
}
