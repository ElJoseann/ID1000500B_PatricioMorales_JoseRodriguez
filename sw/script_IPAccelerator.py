from ipdi.ip.pyaip import pyaip, pyaip_init

import sys

try:
    connector = '/dev/ttyACM0'
    nic_addr = 1
    port = 0
    csv_file = '/home/patricio/Descargas/conv_temp/ID1000500B_config.csv'

    aip = pyaip_init(connector, nic_addr, port, csv_file)

    aip.reset()

    #==========================================
    # Code generated with IPAccelerator 

    ID = aip.getID()
    print(f'Read ID: {ID:08X}\n')

    STATUS = aip.getStatus()
    print(f'Read STATUS: {STATUS:08X}\n')

    SIZEY = [0x0000000A]

    print('Write configuration register: CSIZE_Y')
    aip.writeConfReg('CSIZE_Y', SIZEY, 1, 0)
    print(f'SIZEY Data: {[f"{x:08X}" for x in SIZEY]}\n')

    DATA_INPUT = [0x00000000, 0x00000001, 0x00000002, 0x00000003, 0x00000004, 0x00000005, 0x00000006, 0x00000007, 0x00000008, 0x00000009]

    print('Write memory: MMEM_Y')
    aip.writeMem('MMEM_Y', DATA_INPUT, 10, 0)
    print(f'DATA_INPUT Data: {[f"{x:08X}" for x in DATA_INPUT]}\n')

    print('Start IP\n')
    aip.start()

    print('Read memory: MMEM_Z')
    OUTPUT = aip.readMem('MMEM_Z', 64, 0)
    print(f'OUTPUT Data: {[f"{x:08X}" for x in OUTPUT]}\n')

    STATUS = aip.getStatus()
    print(f'Read STATUS: {STATUS:08X}\n')

    print('Clear INT: 0')
    aip.clearINT(0)

    STATUS = aip.getStatus()
    print(f'Read STATUS: {STATUS:08X}\n')

    #==========================================

    aip.finish()

except:
    e = sys.exc_info()
    print('ERROR: ', e)

    aip.finish()
    raise
