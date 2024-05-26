#include <stdio.h>
#include <stdlib.h>
#include <stdlib.h>
//#include <conio.h> // getch
#include "id1000500b.h"

void get_convolution(uint8_t* X, uint8_t size, uint16_t* rExpected);
void compare_results(uint16_t* result, uint8_t size, uint16_t* rExpected);

int main() 
{
    uint8_t nic_addr  = 1;
    uint8_t port = 0;
    uint8_t aip_mem_size = 10; //Size of the input and output memories

    id1000500b_init("/dev/ttyACM0", nic_addr, port, "/home/patricio/Descargas/conv_temp/ID1000500B_config.csv");

    srand(time(0));

    //uint8_t WR[10] = {0,1,2,3,4,5,6,7,8,9};
    uint16_t* RD = (uint16_t*) malloc(sizeof(uint16_t)*(aip_mem_size+SizeH-Adjust));
    uint8_t* WR = (uint8_t*) malloc(sizeof(uint8_t)*(aip_mem_size));

    printf("\nData generated with %i\n",aip_mem_size);
    printf("\nTX Data\n");

    for(uint32_t i=0; i<aip_mem_size; i++){
        WR[i] = rand() %0XFFFFFFF;
        printf("%08X\n", WR[i]);
    }

    uint16_t* Expected = (uint16_t*) malloc(sizeof(uint16_t)*(aip_mem_size+SizeH-Adjust));
    
    id1000500b_conv(WR, aip_mem_size, RD);

    printf("\n");
    //for(uint32_t i=0; i<(aip_mem_size+4); i++){
    //    printf("TX: %08X \t | RX: %08X \t %s \n", WR[i], RD[i], (WR[i]==RD[i])?"YES":"NO" );
    //}

    get_convolution(WR, aip_mem_size, Expected);
    compare_results(RD, aip_mem_size, Expected);

    printf("\n\nPress key to close ... ");
    // getch();
    free(RD);
    return 0;

}


void get_convolution(uint8_t* X, uint8_t size, uint16_t* rExpected){
    const int sizeH = SizeH;
    const uint8_t H[5] = {0x04, 0x30, 0x13, 0x0A, 0x26};
    int i, j, currentZ;
 
    i = 0;
    while(i < (size + sizeH - Adjust)){
        currentZ = 0;
        j = 0;
        while(j < size){
            if(((i - j) >= 0) && ((i - j) < sizeH)){
                currentZ += H[i - j] * X[j];
            }
            j++;
        }
        rExpected[i] = currentZ;
        i++;
    }
}
 
void compare_results(uint16_t* result, uint8_t size, uint16_t* rExpected){
    printf("Memory \t Expected \t Got \t\t Status\n");
    for(int i = 0; i < (size + SizeH - Adjust); i++){
        printf("%i \t %08X \t %08X \t %s \n", i, rExpected[i], result[i], (result[i]==rExpected[i])?"OK":"ERROR" );
    }
}
