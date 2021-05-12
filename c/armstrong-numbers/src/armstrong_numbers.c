#include "armstrong_numbers.h"
#include <math.h>

static int armstrong_sum(int *digits, int digit_count) {
	int sum = 0;

	for (int i = 0; i < digit_count; ++i) {
		sum += (int) powf((float) digits[i], (float) digit_count);
	}

	return sum;
}

static int get_last_digit(int number) {
	return number % 10;
}


bool is_armstrong_number(int candidate) {
	int digit_count = 0;
	int digits[7];
	int candidate_copy = candidate;

	while (candidate > 0) {
		digits[digit_count++] = get_last_digit(candidate);
		candidate = candidate / 10;
	}

	return armstrong_sum(digits, digit_count) == candidate_copy;
}
