#include "stm32h745xx.h"

#include <stdint.h>

#define LOOP_ITERATIONS 2000

int main(void) {
    // Basic M4 core setup
    uint32_t tempVal = 0;
    while( tempVal < LOOP_ITERATIONS ) {

        tempVal++;
        if( LOOP_ITERATIONS == tempVal )
        {
            printf("Running on M7 core\n");
            // Toggle an LED or increment a counter
            tempVal = 0;
        }
    }
}