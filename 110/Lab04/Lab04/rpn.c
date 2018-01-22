// **** Include libraries here ****
// Standard libraries

//CMPE13 Support Library
#include "BOARD.h"
#include "Stack.h"

// Microchip libraries
#include <xc.h>
#include <plib.h>

// User libraries
#define LAB4_TESTING
#include <ctype.h>

// **** Set macros and preprocessor directives ****
#define strLen 256

// **** Define global, module-level, or external variables here ****

// **** Declare function prototypes ****
/*
 * Function prototype for ProcessBackspaces() - This function should be defined
 * below main after the related comment.
 */
int ProcessBackspaces(char *rpn_sentence);

// If this code is used for testing, rename main to something we can call from our testing code. We
// also skip all processor configuration and initialization code.
#ifndef LAB4_TESTING

int main(void)
{
    BOARD_Init();
#else

	/******* test StackInit *******/
void testInit (struct Stack values){
    StackInit(&values);
    if (sizeof (values.stackItems) / sizeof (values.stackItems[0]) == STACK_SIZE
	    && values.currentItemIndex == -1) {
	printf("StackInit is functional %i\n", values.currentItemIndex);
	printf("StackInit is functional %i\n", values.currentItemIndex);
	printf("StackInit is functional %i\n", values.currentItemIndex);
	printf("StackInit is functional %i\n", values.currentItemIndex);

    } else {
	printf("StackInit is not functioning\n");
    }
}

/******* test StackPush *******/
void testPush(struct Stack values){
    printf("StackInit is functional %i\n", values.currentItemIndex);
	StackPush(&values, 6);
    if (values.currentItemIndex == 0
	    && values.stackItems[values.currentItemIndex] == (float)6) {
	printf("StackPush is functional\n");
    } else {
	printf("StackPush is not functioning, %f, %i\n", values.stackItems[values.currentItemIndex],values.currentItemIndex);
    }
}

/******* test StackPop *******/
void testPop(struct Stack values){
    float result;
    StackPop(&values, &result);
    if (values.currentItemIndex == -1 && result == (float)6) {
	printf("StackPop is functional\n");
    } else {
	printf("StackPop is not functioning\n");
    }
}

    /******* test StackIsEmpty *******/
void testEmpty(struct Stack values){
    if (StackIsEmpty(&values) == SUCCESS) {
	printf("StackIsEmpty (no values) is functional\n");
    } else {
	printf("StackIsEmpty (no values) is not functioning\n");
    }
    values.currentItemIndex = 0;
    values.initialized = STANDARD_ERROR;
    if (StackIsEmpty(&values) == SUCCESS) {
	printf("StackIsEmpty (not initialized) is functional\n");
    } else {
	printf("StackIsEmpty (not initialized) is not functioning\n");
    }
    values.initialized = SUCCESS;
	values.currentItemIndex = -1;
}

    /******* test StackIsFull *******/
void testFull(struct Stack values){
    values.currentItemIndex = STACK_SIZE + 1;
    if (StackIsFull(&values) == SUCCESS) {
	printf("StackFull is functional\n");
    } else {
	printf("StackFull is not functioning\n");
    }
}

    /******* test StackGetSize *******/
void testSize(struct Stack values){
    int test[3];
    values.initialized = STANDARD_ERROR;
    test[0] = StackGetSize(&values);
    StackInit(&values);
    test[1] = StackGetSize(&values);
    StackPush(&values, 4);
    test[2] = StackGetSize(&values);
    if (test[0] == SIZE_ERROR && test[1] == 0 && test[2] == 1) {
	printf("StackGetSize is functional\n");
    } else {
	printf("StackGetSise is not functioning\n");
    }
}
void testShit(struct Stack values){
	testInit(values);
	printf("StackInit is functional %i\n", values.currentItemIndex);
	testPush(values);
	testPop(values);
	testEmpty(values);
	testFull(values);
	testSize(values);
}

//get input and return true if good input error if not
int getInput(char *output){
    char penis[strLen];
	printf("Please enter floats and +-*/ in RPN format: \n> ");
	fgets(penis, strLen, stdin);
	ProcessBackspaces(penis);
	char *token;
	for(token = strtok(penis, " "); token != NULL; token = strtok(penis, " ")){
		if(isdigit(*token)|| ispunct(*token)){
			strcat(output, token);
			strcat(output, "\0");
		}
		else{
			printf("Not a correct input butthole\n");
			return STANDARD_ERROR;
		}
		}
		strcat(output, "\n");
		return SUCCESS;
}

//performs operation, pushes result onto stack
//returns result of push operation, success or fail
//doesnt do stack checking so DO THAT SHIT BEFORE CALLING
int operate(char operation, struct Stack stack){
	float value1, value2, result;
	//check there enough values to operate on
	if (StackPop(&stack, &value1) == STANDARD_ERROR ||
	StackPop(&stack, &value2) == STANDARD_ERROR) return STANDARD_ERROR;
	switch (operation) {
	    case '+':
		result = value1 + value2;
		break;
	    case'-':
		result = value1 - value2;
		break;
	    case '/':
		result = value1 / value2;
		break;
	    case '*':
		result = value1 * value2;
		break;
	    default:
		printf("no valid operation detected");
		return STANDARD_ERROR;
		break;
	    }
	return StackPush(&stack, result);
}

//pushes number onto stack
//returns success if stack has space
//you know wtf it returns if it fails
int parseNum(char *input, struct Stack stack){
	int i = 0, j = 0;
	char number[10];
	while(input[i] != '\0'){
		number[j++] = input[i++];//put number into hold string to convert into float
	}
		number[j] = '\0'; //append null bc atof sucks
		return StackPush(&stack, atof(number)); 
}

//perform operations of checked input string
int doShit(char *input, struct Stack stack){
	int i;
	for(i = 0; input[i] != '\n'; i++){
		if(isdigit(input[i])){//parse number
			if (parseNum(input, stack) == STANDARD_ERROR){
				printf("stack is too full buddy\n");
				return STANDARD_ERROR;
			}
		}
		else{//perform operation
			if(operate(input[i], stack) == STANDARD_ERROR){
				printf("not enough numbers on stack to do that operation my dude or wrong operation");
				return STANDARD_ERROR;
			}
		}
	}
}

//print result
//return error if not just one number
//YOU KNOW WHAT THE FUCK IT RETURNS IF IT WORKS
int done(struct Stack stack){
	if (StackGetSize(&stack) != 1){
		printf("Number error butthole! Thats not rpn format! PUT IT IN VALID RPN FORMAT!\n");
		return STANDARD_ERROR;
	}
	float result;
	StackPop(&stack, &result);
	printf("the answer to your query is %f", (double) result);
	return SUCCESS;
}
#define strLen 256
int main(void)
{
    


    /******************************** Your custom code goes below here *******************************/
    printf("Welcome to Gavin Chen's rpn calculator!\n");
    //begin unit testing
    struct Stack values;
	char input[strLen];
	testShit(values); //testing harness

	printf("Hello User! I welcome you to my rpn calculator program!\n");
	printf("now please input an operation in rpn notation: \n");
	
    /******************************** begin rpn code *******************************/
    while (1) {
	StackInit(&values);//initialize to empty
	getInput(input);//parse input is correct
	doShit(input, values); //perform calculations
	done(values); //output result
	/*************************************************************************************************/

	// You can never return from main() in an embedded system (one that lacks an operating system).
	// This will result in the processor restarting, which is almost certainly not what you want!
    }
}

/**
 * Extra Credit: Define ProcessBackspaces() here - This function should read through an array of
 * characters and when a backspace character is read it should replace the preceding character with
 * the following character. It should be able to handle multiple repeated backspaces and also
 * strings with more backspaces than characters. It should be able to handle strings that are at
 * least 256 characters in length.
 * @param rpn_sentence The string that will be processed for backspaces. This string is modified in
 *                     place.
 * @return Returns the size of the resultant string in `rpn_sentence`.
 */
int ProcessBackspaces(char *rpn_sentence)
{
	int i, j;
	for(i = 0, j = 0; rpn_sentence[i] != '\n'; i++){
		if(rpn_sentence[i] == '\b'){
			j--;
			continue;
		}
		if(j < 0) j = 0;
		rpn_sentence[j++] = rpn_sentence[i];
	}
	rpn_sentence[j++] = '\n';
    return j;
}
#endif // LAB4_TESTING