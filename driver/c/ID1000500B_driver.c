#include "ID1000500B_driver.h"
#include "caip.h"
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

#ifdef _WIN32
#include <windows.h>
#else
#include <unistd.h>
#endif // _WIN32

//Defines
#define INT_DONE        0
#define ONE_FLIT        1
#define ZERO_OFFSET     0
#define STATUS_BITS     8
#define INT_DONE_BIT    0x00000001



/** Global variables declaration (private) */
caip_t      *id1000500b_aip;
uint32_t    id1000500b_id = 0;
/*********************************************************************/

/** Private functions declaration */
static uint32_t id1000500b_getID(uint32_t* id);
static uint32_t id1000500b_clearStatus(void);
/*********************************************************************/

/** Global variables declaration (public)*/

/*********************************************************************/

/**Functions*/

/* Driver initialization*/
int32_t id1000500b_init(const char *connector, uint8_t nic_addr, uint8_t port, const char *csv_file)
{
    id1000500b_aip = caip_init(connector, nic_addr, port, csv_file);

    if(id1000500b_aip == NULL){
        printf("CAIP Object not created");
        return -1;
    }
    id1000500b_aip->reset();

    id1000500b_getID(&id1000500b_id);
    id1000500b_clearStatus();

    printf("\nIP Dummy controller created with IP ID: %08X\n\n", id1000500b_id);
    return 0;
}

/* Write data*/
int32_t id1000500b_writeData(uint32_t *data, uint32_t data_size)
{
    id1000500b_aip->writeMem("MMEM_Y", data, data_size, ZERO_OFFSET);
    return 0;
}

/* Read data*/
int32_t id1000500b_readData(uint32_t *data, uint32_t data_size)
{
    id1000500b_aip->readMem("MMEM_Z", data, data_size, ZERO_OFFSET);
    return 0;
}

/* Start processing*/
int32_t id1000500b_startIP(void)
{
    id1000500b_aip->start();
    return 0;
}

int32_t id1000500b_setSize(uint32_t size){
    uint32_t time_delay[] = {size};
    id1000500b_aip->writeConfReg("CSIZE_Y", time_delay, ONE_FLIT, ZERO_OFFSET);
    return 0;
}

/* Enable interruption notification "Done"*/
int32_t id1000500b_enableINT(void)
{
    id1000500b_aip->enableINT(INT_DONE, NULL);
    printf("\nINT Done enabled");
    return 0;
}

/* Disable interruption notification "Done"*/
int32_t id1000500b_disableINT(void)
{
    id1000500b_aip->disableINT(INT_DONE);
    printf("\nINT Done disabled");
    return 0;
}

/* Show status*/
int32_t id1000500b_status(void)
{
    uint32_t status;
    id1000500b_aip->getStatus(&status);
    printf("\nStatus: %08X",status);
    return 0;
}

/* Wait interruption*/
int32_t id1000500b_waitINT(void)
{
    bool waiting = true;
    uint32_t status;

    while(waiting)
    {
        id1000500b_aip->getStatus(&status);

        if((status & INT_DONE_BIT)>0)
            waiting = false;

        #ifdef _WIN32
        Sleep(500); // ms
        #else
        sleep(0.1); // segs
        #endif
    }

    id1000500b_aip->clearINT(INT_DONE);

    return 0;
}

/* Execute convolution*/
uint32_t id1000500b_conv(uint8_t* X, uint8_t size, uint16_t* result){

    uint32_t sizeCast = (uint32_t)size;

    if(sizeCast >= maxSize){
        printf("\n Size of the input signal must be maximum 32 \n");
        return -1;
    }

    uint32_t sizeZ = sizeCast+SizeH-Adjust; 
    
    id1000500b_setSize(sizeCast);

    //Cast to uint32_t
    uint32_t* Xdata32 = (uint32_t*) malloc(sizeof(uint32_t)*sizeCast);
    for (uint32_t i = 0; i < sizeCast; i++){
        Xdata32[i]=(uint32_t)X[i];
    }

    id1000500b_writeData(Xdata32, sizeCast);

    id1000500b_startIP();

    id1000500b_waitINT();

    printf("\n\n Done detected \n\n");

    uint32_t* RD = (uint32_t*) malloc(sizeof(uint32_t)*(sizeZ));
    id1000500b_readData(RD, sizeZ);

    id1000500b_status();
    id1000500b_clearStatus();
    id1000500b_status();
    id1000500b_finish();

    //Cast to uint16_t
    for (uint32_t i = 0; i < sizeZ; i++){
        result[i]=(uint16_t)RD[i];
    }
    free(RD);
    free(Xdata32);

    return 0;
}

/* Finish*/
int32_t id1000500b_finish(void)
{
    id1000500b_aip->finish();
    return 0;
}

//PRIVATE FUNCTIONS
uint32_t id1000500b_getID(uint32_t* id)
{
    id1000500b_aip->getID(id);

    return 0;
}

uint32_t id1000500b_clearStatus(void)
{
    for(uint8_t i = 0; i < STATUS_BITS; i++)
        id1000500b_aip->clearINT(i);

    return 0;
}



