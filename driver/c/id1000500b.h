#ifndef __id1000500b_H__
#define __id1000500b_H__

#include <stdint.h>

#define SizeH           5
#define Adjust          1

/** Global variables declaration (public) */
/* These variables must be declared "extern" to avoid repetitions. They are defined in the .c file*/
/******************************************/

/** Public functions declaration */

/* Driver initialization*/
int32_t id1000500b_init(const char *connector, uint8_t nic_addr, uint8_t port, const char *csv_file);

/* Write data*/
int32_t id1000500b_writeData(uint32_t *data, uint32_t data_size);

/* Read data*/
int32_t id1000500b_readData(uint32_t *data, uint32_t data_size);

/* Start processing*/
int32_t id1000500b_startIP(void);

/* Set the size of the input memory*/
int32_t id1000500b_setSize(uint32_t size);

/* Enable interruption notification "Done"*/
int32_t id1000500b_enableINT(void);

/* Disable interruption notification "Done"*/
int32_t id1000500b_disableINT(void);

/* Show status*/
int32_t id1000500b_status(void);

/* Execute convolution*/
uint32_t id1000500b_conv(uint8_t* X, uint8_t size, uint16_t* result);

/* Wait interruption*/
int32_t id1000500b_waitINT(void);

/* Finish*/
int32_t id1000500b_finish(void);

#endif // __id1000500b_H__

