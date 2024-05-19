#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

#define UPPER_LIMIT 50
#define LOWER_LIMIT 0
#define TWO_DIGITS_HEX_NUNMER 0x10

uint16_t* get_convolution(uint8_t *Y, uint8_t *H, uint8_t sizeY, uint8_t sizeH);
uint8_t* get_signal(uint8_t sizeSignal);
uint8_t get_random_number();
void printSignal(const char* signalName, uint16_t *signal, uint16_t sizeSignal);
void create_file(const char* fileName, uint16_t* signal, uint16_t sizeSignal);

uint16_t main(){
    uint16_t sizeY = 0xF;
    uint16_t sizeH = 5;
    uint16_t sizeZ = sizeY + sizeH - 1;
    uint16_t* y = NULL;
    uint16_t* h = NULL;
    uint16_t* z = NULL;

    // Initialize seed
    srand(time(0));
    // Get random signals
    // y = get_signal(sizeY);
    y = (uint8_t*) malloc(sizeof(uint8_t) * sizeY);
    y[0] = 0x2D;
    y[1] = 0x29;
    y[2] = 0xA6;
    y[3] = 0x2F;
    y[4] = 0x4A;
    y[5] = 0xEB;
    y[6] = 0x73;
    y[7] = 0x5B;
    y[8] = 0x02;
    y[9] = 0xFB;
    y[10] = 0x71;
    y[11] = 0x5F;
    y[12] = 0x61;
    y[13] = 0x09;
    y[14] = 0x13;
    /*y[15] = 0x5;
    y[16] = 0x6;
    y[17] = 0x7;
    y[18] = 0x8;
    y[19] = 0x9;*/
    /*for(uint16_t i = 0; i < sizeY; i++){
    	y[i] = i;
    }*/
    h = (uint8_t*) malloc(sizeof(uint8_t*) * sizeH);
    h[0] = 0x04;
    h[1] = 0x30;
    h[2] = 0x13;
    h[3] = 0x0A;
    h[4] = 0x26;
    // h = get_signal(sizeH);
    // Calculate convolution
    z = get_convolution(y, h, sizeY, sizeH);
    // Generate files
    create_file("MemoryY.txt", y, sizeY);
    create_file("MemoryH.txt", h, sizeH);
    // Pruint16_t Signals
    printSignal("Y", y, sizeY);
    printSignal("H", h, sizeH);
    printSignal("Z", z, sizeZ);
    // Free memory
    free(y);
    free(h);
    free(z);

    return 0;
}

uint16_t* get_convolution(uint8_t* *Y, uint8_t* *H, uint8_t* sizeY, uint8_t* sizeH){
    uint16_t i, j, currentZ;
    uint16_t* Z = (uint16_t*) malloc(sizeof(uint16_t) * (sizeY + sizeH - 1));

    i = 0;
    while(i < (sizeY + sizeH - 1)){
        currentZ = 0;
        j = 0;
        while(j < sizeY){
            if(((i - j) >= 0) && ((i - j) < sizeH)){
                currentZ += H[i - j] * Y[j];
            }
            j++;
        }
        Z[i] = currentZ;
        i++;
    }
    return Z;
}

uint8_t* get_signal(uint8_t* sizeSignal){
    uint8_t** signal = (uint8_t**) malloc(sizeof(uint8_t*) * sizeSignal);
    for(uint16_t i = 0; i < sizeSignal; i++){++++++++
        signal[i] = get_random_number();
    }
    return signal;
}

uint8_t* get_random_number(){
    return (rand() % (UPPER_LIMIT - LOWER_LIMIT + 1));
}

void printSignal(const char* signalName, uint16_t *signal, uint16_t sizeSignal){
    printf("%s = [", signalName);
    for(uint16_t i = 0; i < sizeSignal; i++){
        printf("%X ", signal[i]);
    }
    printf("]\n");
}

void create_file(const char* fileName, uint16_t* signal, uint16_t sizeSignal){
    FILE* file = fopen(fileName, "wb+");
    for(uint16_t i = 0; i < sizeSignal; i++){
        if(signal[i] < TWO_DIGITS_HEX_NUNMER){
            fprintf(file, "%X", 0);
        }
        fprintf(file, "%X\n", signal[i]);
    }
}
