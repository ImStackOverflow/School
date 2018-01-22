
#include "LinkedList.h"
#include "BOARD.h"
#include <stdlib.h>
#include <ctype.h>

ListItem *LinkedListNew(char *data)
{
    ListItem *NewList = malloc(sizeof (ListItem));
    if (NewList) { //check that malloc worked
	NewList->data = data;
	NewList->nextItem = NULL;
	NewList->previousItem = NULL;
	return NewList;
    } else {//if malloc didnt work then throw error
	return STANDARD_ERROR;
    }
}

char *LinkedListRemove(ListItem *item)
{
    if (item) { //if item isnt null
	ListItem *hold2 = item->nextItem;
	ListItem *hold1 = item->previousItem;
	if (hold1 != NULL) hold1->nextItem = hold2;
	if (hold2 != NULL) hold2->previousItem = hold1;
	char *data = item->data;
	free(item);
	return data;
    } else {
	return NULL;
    }
}

int LinkedListSize(ListItem *list)
{
    int elements = 1;
    LinkedListGetFirst(list);
    while (list->nextItem != NULL) {//iterate through 
	elements++;
	list = list->nextItem;
    }
    return elements;

}

ListItem *LinkedListGetFirst(ListItem *list) //returns pointer
{
    if (list) {
	while (list->previousItem != NULL) {//set list to beginning
	    list = list->previousItem;
	}
    }
    return list;
}

ListItem *LinkedListCreateAfter(ListItem *item, char *data)
{
    ListItem *NewList = LinkedListNew(data);
	ListItem *ass = item->nextItem;
    if (NewList) {
	if(ass !=  NULL) ass->previousItem = NewList;
		NewList->nextItem = ass;
		NewList->previousItem = item;
		item->nextItem = NewList;	
	return NewList;
    } else {
	return NULL;
    }

}

int LinkedListSwapData(ListItem *firstItem, ListItem *secondItem)
{
    if (firstItem && secondItem) {//make sure both items are valid
	char *hold = firstItem->data;
	firstItem->data = secondItem->data;
	secondItem->data = hold;
	return SUCCESS;
    } else {
	return STANDARD_ERROR;
    }

}

int LinkedListSort(ListItem *list)
{
	if (list) {
    ListItem *penis = LinkedListGetFirst(list);
    //make temporary list for sorting
    ListItem *tits;
		for(;penis != NULL; penis = penis->nextItem){
			for(tits = penis; tits != NULL; tits = tits->nextItem){
			    if(tits->data == NULL){
				LinkedListSwapData(penis, tits);
				break;
			    }
				if(strcmp(penis->data, tits->data) > 0) LinkedListSwapData(penis, tits);
			}
			}return SUCCESS;
		}
		else return STANDARD_ERROR;
}

int LinkedListPrint(ListItem *list)
{
	if (list){
		ListItem *poop = LinkedListGetFirst(list);
		printf("[%s", poop->data);
		for(poop = poop->nextItem; poop != NULL; poop = poop->nextItem){
			printf(", %s", poop->data);
		}
		printf("]\n");
		return SUCCESS;
	}
	else return STANDARD_ERROR;

	
}