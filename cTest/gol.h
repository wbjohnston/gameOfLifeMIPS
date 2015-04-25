#ifndef _GOL_H_
#define _GOL_H_

#include <stdlib.h>

#define STARVE_POP 1
#define OVERCROWD_POP 4

#define DEAD_SYM "X"
#define ALIVE_SYM "O"

//border stuff
#define BORDER_CORNER "+"
#define BORDER_SIDE "|"
#define BORDER_TOP "-"

#define min(a,b) ((a) < (b) ? (a) : (b))
#define max(a,b) ((a) > (b) ? (a) : (b))
#define clamp(a, mi, ma) min(max(mi, a), ma)

/*
 * A generation for "conways game of life
 */
typedef struct Generation_S{
	int**		world;
	size_t		size_x;
	size_t		size_y;
	unsigned 	generation;

}Generation;

/*
 * an X,Y cartesian coordinate
 */
typedef struct xy_s{
	unsigned x;
	unsigned y;

}xy;

/*
 * initialize a new generation
 * @param size_x: x dimension of the world
 * @param size_y: y dimension of the world
 * @return: a generation with the world initialized as a wasteland: no life
 */
Generation gen_create(size_t size_x, size_t size_y);

/*
 * display the generation g to stdout
 * @param g: generation to display
 * @return: void
 */
void gen_dump(Generation g);

/*
 * advance a generation to the next generation of conways game of life
 * @param g: generation to advance
 * @return: void
 */
void gen_advance(Generation g);

/*
 * populate the map of a generation. typically done on the first generation
 * if the coordinates are outside of the board, they will be "wrapped around"
 * and placed within bounds of the board, however not where intended
 * @param g: generation to populate
 * @param coords: coordinates to populate
 */
void gen_populate(Generation g, xy** coords);
#endif
