#include "darts.h"
#include <math.h>

typdef struct {
	float x;
	float y;
} coordinate_t;

int score(coordinate_t coordinates) {
	float x = coordinates.x;
	float y = coordinates.y;
	float distance = sqrt(x*x + y*y);

	if (distance > 10) return 0;
	if (distance > 5) return 1;
	if (distance > 1) return 5;
	return 10;
}
