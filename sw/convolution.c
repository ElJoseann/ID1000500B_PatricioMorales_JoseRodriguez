#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

#define UPPER_LIMIT 50
#define LOWER_LIMIT 0
#define TWO_DIGITS_HEX_NUNMER 0x10
#define THREE_DIGITS_HEX_NUNMER 0x100
#define FORTH_DIGITS_HEX_NUNMER 0x1000

int* get_convolution(int *Y, int *H, int sizeY, int sizeH);
int* get_signal(int sizeSignal);
int get_random_number();
void printSignal(const char* signalName, int *signal, int sizeSignal);
void create_file(const char* fileName, int* signal, int sizeSignal, int width);

int main(){
    int sizeY = 10;
    int sizeH = 5;
    int sizeZ = sizeY + sizeH - 1;
    int* y = NULL;
    int* h = NULL;
    int* z = NULL;

    // Initialize seed
    srand(time(0));
    // Get random signals
    y = get_signal(sizeY);
    /*for(int i = 0; i < sizeY; i++){
    	y[i] = i;
    }*/
    h = (int*) malloc(sizeof(int) * sizeH);
    h[0] = 0x04;
    h[1] = 0x30;
    h[2] = 0x13;
    h[3] = 0x0A;
    h[4] = 0x26;
    // h = get_signal(sizeH);
    // Calculate convolution
    z = get_convolution(y, h, sizeY, sizeH);
    // Generate files
    create_file("MemoryY.txt", y, sizeY, 8);
    create_file("MemoryH.txt", h, sizeH, 8);
    create_file("MemoryZ.txt", z, sizeZ, 16);
    // Print Signals
    printSignal("Y", y, sizeY);
    printSignal("H", h, sizeH);
    printSignal("Z", z, sizeZ);
    // Free memory
    free(y);
    free(h);
    free(z);

    return 0;
}

int* get_convolution(int *Y, int *H, int sizeY, int sizeH){
    int i, j, currentZ;
    int* Z = (int*) malloc(sizeof(int) * (sizeY + sizeH - 1));

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

int* get_signal(int sizeSignal){
    int* signal = (int*) malloc(sizeof(int) * sizeSignal);
    for(int i = 0; i < sizeSignal; i++){
        signal[i] = get_random_number();
    }
    return signal;
}

int get_random_number(){
    return (rand() % (UPPER_LIMIT - LOWER_LIMIT + 1));
}

void printSignal(const char* signalName, int *signal, int sizeSignal){
    printf("%s = [", signalName);
    for(int i = 0; i < sizeSignal; i++){
        printf("%X ", signal[i]);
    }
    printf("]\n");
}

void create_file(const char* fileName, int* signal, int sizeSignal, int width){
    FILE* file = fopen(fileName, "wb+");
    for(int i = 0; i < sizeSignal; i++){
   	if (width == 16){
	    	if(signal[i] < FORTH_DIGITS_HEX_NUNMER){
		    fprintf(file, "%X", 0);
		}
		if(signal[i] < TWO_DIGITS_HEX_NUNMER){
		    fprintf(file, "%X", 0);
		}
	}
        if(signal[i] < TWO_DIGITS_HEX_NUNMER){
            fprintf(file, "%X", 0);
        }
        fprintf(file, "%X\n", signal[i]);
    }
}
