Convolution coprocessor interface.

In this project an AIP interface is used to connect, test and validate a hardware accelerrator that performs the 1D convolution between two signals. 

First signal is embedded at hdl level, and can be manipulated in the synthesis of the design. 

Second signal can be manipulated by the user by writing its values on an external memory, using the IP module, accessing it with the provided drivers (in C and python) or with testing tools (IPAccelerator).

A RTL verilog simulation of the interface is provided, as well as the C and Python drivers to use the convolution coprocessor.

Documentation of the interface and coprocessor design can be found on folder docs. 

For further information, please contact: 
	- moralesdiazpatricioemiliano@gmail.com
	- joseantoniorodriguezvel@gmail.com
