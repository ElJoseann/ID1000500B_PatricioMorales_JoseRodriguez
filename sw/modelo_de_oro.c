#include <stdio.h>


int main(){
    int i, j, currentZ;
    // Memoria Y
    int MemY[] = {5, 4, 3, 2, 1};
    int sizeY = sizeof(MemY) / sizeof(int);
    // Memoria H
    int MemH[] = {2, 4, 7};
    int sizeH = sizeof(MemH) / sizeof(int);
    // Memoria Z
    int MemZ[sizeH + sizeY - 1];

    i = 0;
    while(i < (sizeY + sizeH - 1)){
        currentZ = 0;
        j = 0;
        while(j < sizeY){
            if(((i - j) >= 0) && ((i - j) < sizeH)){
                currentZ += MemH[i - j] * MemY[j];
            }
            j++;
        }
        MemZ[i] = currentZ;
        i++;
    }

    // Imprime resultado
    printf("Z = ");
    for (int i = 0; i < sizeH + sizeY - 1; i++){
        printf("%d ", MemZ[i]);
    }

    return 0;
}

