#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "gol.h"

#define min(a,b) ((a) < (b) ? (a) : (b))
#define max(a,b) ((a) > (b) ? (a) : (b))
#define clamp(a, mi, ma) min(max(mi, a), ma)

#define MAX_COORDS 256
#define BOARDSIZE_X 24
#define BOARDSIZE_Y 24

static xy** get_coords(){
	int x, y;
	xy** coords = (xy**)calloc( MAX_COORDS, sizeof(xy*) );
	
	printf("Please start inputting coordinates between 0 and %d in the"
		       " format X,Y ie: 1,3\n"
		       "enter anything else to continue\n", BOARDSIZE_X);	
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
	//TODO: I have absolutely no idea why generation isn't incrementing. fix it
	printf("====    GENERATION %d    ====\n\n", g.generation ); //header
	printf(""); //top border

	for(size_t i = 0; i < g.size_x; i++){ //print out board
		printf(BORDER_SIDE);
		for(size_t j = 0; j < g.size_y; j++)
			printf( (g.world[i][j]) ? ALIVE_SYM : DEAD_SYM ); 
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

void gen_advance(Generation g){
	//create new world
	int** nextGen = (int**)calloc(g.size_x, sizeof(int*));
	for(size_t i = 0; i < g.size_x; i++)
		nextGen[i] = (int*)calloc(g.size_y, sizeof(int));


	for(size_t x = 0; x < g.size_x; x++){
		for(size_t y = 0; y < g.size_y; y++){
		
			unsigned adj = 0; //calculate neighbords
			for( int x_off = -1; x_off <= 1; x_off++){
				for( int y_off = -1; y_off <= 1; y_off++){
					if(x_off != 0 && y_off != 0)
						adj += (g.world[(x + x_off) % g.size_x][(y + y_off) % g.size_y]) ? 1: 0;
				}
			}
	
			//if the cell is overcrowded or starving
			if( adj <= STARVE_POP || adj >= OVERCROWD_POP )
				nextGen[x][y] = 0;
			else if( adj == 3 )
				nextGen[x][y] = 1;
			else //age up
				nextGen[x][y] = g.world[x][y] + 1;
		}	
	}
	//free old world
//	for(size_t i = 0; i < g.size_x; i++)
//		free(g.world[i]);
//	free(g.world);
	g.world = nextGen;
	g.generation++;
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
	for(unsigned i = 0; i < 2; i++){
//		gen_dump(gen_x);
		gen_advance(gen_x);
		gen_dump(gen_x);

	}

	return EXIT_SUCCESS;
}
