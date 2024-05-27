import logging, time
from ipdi.ip.pyaip import pyaip, pyaip_init

## IP convoution_coprocessor driver class
class convoution_coprocessor:
    ## Class constructor of IP convoution_coprocessor driver
    #
    # @param self Object pointer
    # @param targetConn Middleware object
    # @param config Dictionary with IP convoution_coprocessor configs
    # @param addrs Network address IP
    def __init__(self, connector, nic_addr, port, csv_file):
        ## Pyaip object
        self.__pyaip = pyaip_init(connector, nic_addr, port, csv_file)

        if self.__pyaip is None:
            logging.debug(error)

        ## Array of strings with information read
        self.dataRX = []

        ## IP convoution_coprocessor IP-ID
        self.IPID = 0

        self.__getID()

        self.__clearStatus()

        logging.debug(f"IP convoution_coprocessor controller created with IP ID {self.IPID:08x}")

    ## Write data in the IP convoution_coprocessor input memory
    #
    # @param self Object pointer
    # @param data String array with the data to write
    def writeData(self, data):
        self.__pyaip.writeMem('MMEM_Y', data, len(data), 0)

        logging.debug("Data captured in Mem Data In")


    def setSize(self, size):
        sizeY = []
        sizeY.append(size)
        self.__pyaip.writeConfReg('CSIZE_Y', sizeY, 1, 0)

        logging.debug("Data captured in Mem Data In")

    ## Read data from the IP convoution_coprocessor output memory
    #
    # @param self Object pointer
    # @param size Amount of data to read
    def readData(self, size):
        data = self.__pyaip.readMem('MMEM_Z', size, 0)
        logging.debug("Data obtained from Mem Data Out")
        return data

    ## Start processing in IP convoution_coprocessor
    #
    # @param self Object pointer
    def startIP(self):
        self.__pyaip.start()

        logging.debug("Start sent")

    ## Enable IP convoution_coprocessor interruptions
    #
    # @param self Object pointer
    def enableINT(self):
        self.__pyaip.enableINT(0,None)

        logging.debug("Int enabled")

    ## Disable IP convoution_coprocessor interruptions
    #
    # @param self Object pointer
    def disableINT(self):
        self.__pyaip.disableINT(0)

        logging.debug("Int disabled")
    
    ## Show IP convoution_coprocessor status
    #
    # @param self Object pointer
    def status(self):
        status = self.__pyaip.getStatus()
        logging.info(f"{status:08x}")

        ## Show IP convoution_coprocessor status
        #
        # @param self Object pointer
        def status(self):
            status = self.__pyaip.getStatus()
            logging.info(f"{status:08x}")

    ## Finish connection
    #
    # @param self Object pointer
    def finish(self):
        self.__pyaip.finish()

    ## Wait for the completion of the process
    #
    # @param self Object pointer
    def waitInt(self):
        waiting = True
        
        while waiting:

            status = self.__pyaip.getStatus()

            logging.debug(f"status {status:08x}")
            
            if status & 0x1:
                waiting = False
            
            time.sleep(0.1)




    ## Get IP ID
    #
    # @param self Object pointer
    def __getID(self):
        self.IPID = self.__pyaip.getID()

    ## Clear status register of IP convoution_coprocessor
    #
    # @param self Object pointer
    def __clearStatus(self):
        for i in range(8):
            self.__pyaip.clearINT(i)

    def conv(self, X):

        if(len(X) >= 32):
            logging.info(f"Size of the input memory must be maximum of 31")
            return None

        conv_cop.setSize(len(X))

        conv_cop.writeData(X)
        logging.info(f"Data generated with {len(X):d}")
        logging.info(f'TX Data {[f"{x:08X}" for x in X]}')

        conv_cop.startIP()

        conv_cop.waitInt()

        RD = conv_cop.readData(len(X)+4)

        conv_cop.status()
        conv_cop.__clearStatus()
        conv_cop.status()

        conv_cop.finish()
        return RD

# gets convolution from the golden model to get expected results
def get_convolution(X):
    sizeH = 5
    size  = len(X)
    H = [0x04, 0x30, 0x13, 0x0A, 0x26]
    Z = []
    i = 0
    while i < (size + sizeH - 1):
        currentZ = 0
        j = 0
        while j < size:
            if (i-j) >= 0 and (i-j) < sizeH:
                currentZ += H[i-j] * X[j]
            j += 1
        Z.append(currentZ)
        i += 1
    return Z


# compares results between the results gotten by the hw accelerator
# and the expected results
def compare_results(result, rExpected):
    for x, y in zip(result, rExpected):
         logging.info(f"Got: {x:08x} | Expected: {y:08x} | {'TRUE' if x == y else 'FALSE'}")


if __name__=="__main__":
    import sys, random, time, os

    logging.basicConfig(level=logging.DEBUG)
    connector = '/dev/ttyACM0'
    csv_file = '/home/patricio/Descargas/conv_temp/ID1000500B_config.csv'
    aip_mem_size = 10
    addr = 1
    port = 0

    try:
        conv_cop = convoution_coprocessor(connector, addr, port, csv_file)
        logging.info("Test convoution_coprocessor: Driver created")
    except:
        logging.error("Test convoution_coprocessor: Driver not created")
        sys.exit()

    random.seed(time.time())

    WR = [random.randrange(2 ** 8) for i in range(0, aip_mem_size)]

    #WR = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    result = conv_cop.conv(WR)

    expected = get_convolution(WR)
    compare_results(result, expected)


    logging.info("The End")
