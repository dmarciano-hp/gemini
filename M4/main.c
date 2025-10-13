#include "stm32h745xx.h"
#include <stdint.h>

#define LOOP_ITERATIONS 1000

int main(void) {
    // Basic M4 core setup
    uint32_t tempVal = 0;
    while( tempVal < LOOP_ITERATIONS ) {

        tempVal++;
        if( LOOP_ITERATIONS == tempVal )
        {
            // Toggle an LED or increment a counter
#ifdef DEV_BUILD
            printf("Iteration count: %d iterations\n", tempVal);
#endif // DEV_BUILD
            tempVal = 0;
        }
    }
}