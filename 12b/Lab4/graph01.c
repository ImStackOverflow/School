#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "intVec.h"

#define debug 1

int main(int argc, char*argv[]){
	if (argc != 2){
		printf("the correct usage is ./graph01 <inputfile>\n");
		exit(0);
	}
	FILE *in = fopen(argv[1], 'r');
	if(in){
		doShit(in);
	}
	else printf("file %s doesnt exist\n", argv[1]);
	return(0);
}

void doShit(FILE *in){
	int v1, v2, weight;
	IntVec *shit;
	int args = fscanf(in, "%d %d %f", &v1, &v2, &weight);
	switch args{
		case 1://first line
		  shit = create(v1);
			break;
		case 2://2 vertecies
			//add v2 into v1 data
			break;
		case 3://2 verticies with weight
			//add v2 into v1 data
			//store weight somewhere
			break;
		default:
			error("there was a formating error in the input file");
			break;
		
	}
}
int* create (int nodes){
  IntVec shit[nodes];
  for(int i = 0; i <= nodes; i++){
    shit[i] =  intMakeEmptyVec();
  }
  return shit;
}

void addVert(IntVec *penis, int v1, int v2, int weight){
  if(penis){
    penis += v1;
    intVecPush(*penis, v2);
  }
  else{
    error(__func__);
  }
}
