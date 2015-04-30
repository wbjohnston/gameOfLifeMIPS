#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ncurses.h>

#define LONE_POP 1
#define CROWD_POP 4

#define DEAD_SYM "X"
#define ALIVE_SYM "O"

//border stuff
#define BORDER_CORNER "+"
#define BORDER_SIDE "|"
#define BORDER_TOP "-"

#define min(a,b) ((a) < (b) ? (a) : (b))
#define max(a,b) ((a) > (b) ? (a) : (b))
#define clamp(a, mi, ma) min(max(mi, a), ma)

#define GET_MACRO(_2, _3, loop, ...) loop
#define loop(...) GET_MACRO(__VA_ARGS__, loop2, loop3) (__VA_ARGS__)


#define loop3(var, mi, ma) for(int var = mi; var < ma; var++)
#define loop2(var, ma) for(int var = 0; var < ma; var++) 

//loops

#include "gol.h"

#define MAX_COORDS 256

static xy** get_coords(){
	int x, y;
	xy** coords = (xy**)calloc( MAX_COORDS, sizeof(xy*) );
	
	printf("Please start inputting coordinates between 0 and %d in the"
		       " format X,Y ie: 1,3\n"
		       "enter anything else to continue\n",x);	
	//get coordinates until the user fucks up the input(intentionally or not)
	for(size_t i = 0; printf("coordinate(x,y): "), scanf("%d, %d", &x, &y); i++ ){
		//create new coord and put it in our list of coords
		xy* temp = (xy*)malloc(sizeof(xy));
		temp->x = x;
		temp->y = y;
		coords[i] = temp;
	}

	printf("inputting finished\n");
	return coords;
}	

Generation gen_create(size_t size_x, size_t size_y){
	Generation temp;
	temp.size_x = size_x;
	temp.size_y = size_y;
	temp.generation = 0; //first generation
	//create the world
	temp.world = calloc(size_x, sizeof(int*));
	for( size_t i = 0; i < size_x; i++ )
		temp.world[i] = calloc(size_y, sizeof(int));

	return temp;
}

void gen_dump(Generation g){
	printf("====    GENERATION %d    ====\n\n", g.generation ); //header	
	loop(i, g.size_x){
		printf(BORDER_SIDE);
		loop(j, g.size_y){
			printf( (g.world[i][j]) ? ALIVE_SYM : DEAD_SYM ); 
		}
		printf(BORDER_SIDE"\n");
	}
	printf("\n");	

}

void gen_populate(Generation g, xy** coords){	
	//put 
	for( size_t i = 0; coords[i]; i++ ){
		/*
		 * to prevent the user from putting coordinates that are out of
		 * bounds, coordinates wrap around the world
		 */
		unsigned x = coords[i]->x % g.size_x;
		unsigned y = coords[i]->y % g.size_y;
		g.world[x][y] = !g.world[x][y]; //toggle cell  	
	}

}

unsigned gen_get_neighbors(Generation g, unsigned x, unsigned y){
	unsigned adj = 0;
	loop3(x_off, -1, 2){
		loop3(y_off, -1, 2){
			adj += (g.world[(x + x_off) % g.size_x][(y + y_off) % g.size_y]) ? 1: 0;
		}
	}
	return adj;	

}

void gen_advance(Generation* g){
	//create new world
	int** nextGen = (int**)calloc(g->size_x, sizeof(int*));
	for(size_t i = 0; i < g->size_x; i++)
		nextGen[i] = (int*)calloc(g->size_y, sizeof(int));


	loop(x, g->size_x){
		loop(y, g->size_y){	
			unsigned adj = gen_get_neighbors(*g, x, y);
			//if the cell is overcrowded or starving
			if( adj <= LONE_POP || adj >= CROWD_POP )
				nextGen[x][y] = 0;
			else if( adj == 3 )
				nextGen[x][y] = 1;
			else //age up
				nextGen[x][y] = g->world[x][y];
		}
	}
	g->world = nextGen;
	g->generation++;
}


int main(int argc, char** argv){
	if( argc < 3 ){
		printf("usage: gol <x> <y>\n");
		return EXIT_FAILURE;
	}
	int x = atoi(argv[1]);
	int y = atoi(argv[2]);
	
	xy** coords = get_coords();
	Generation gen_x = gen_create(x, y);
	gen_populate(gen_x, coords);
	gen_dump(gen_x);
	char c = getchar();
	while((c = getchar()) != 'q'){
		gen_advance(&gen_x);
		gen_dump(gen_x);
		printf("Hit enter to advance or hit q to quit...\n");
	}

	return EXIT_SUCCESS;
}
