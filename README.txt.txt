The files on this drive are NOT to be distributed without permission from Lockheed Martin Corporation.
------------------------------------------------------------------------------------------------------

The included data was recorded in an RF iso-box using a Rohde & Schwarz spectrum analyzer.  The dataset contains:

README.txt
read_complex_binary.m
Data/
    802154/
    Ambient/
    GooglePixelDaydreamBluetooth/
    Iphone6Wifi/
    IsoBoxAmbient/

Each Data subdirectory contains ten data files, with a .iq.tar extension.  To access the iq data, untar each data file archive (on a Windows machine, you may need to install 7-Zip, available at http://www.7-zip.org/).  The contents of each .tar archive are a .1ch.float32 file, a .xml file, and a .xslt file.  The .1ch.float32 file contains the raw iq data.  The included Matlab function "read_complex_binary.m" can be used to access this raw iq data.  Each data record has the following parameters:

Sample Rate: 100 MHz
Center Frequency: 2450 MHz
Duration: 4 seconds

Data descriptions:
------------------

802154 - A device utilizing the IEEE 802.15.4 protocol (the Zigbee physical layer).  Device was placed in the iso-box and recorded.  

Ambient - The ambient spectrum of the laboratory space.  This spectrum includes dense WiFi, Bluetooth, and other 2.4 GHz signalling.

GooglePixelDaydreamBluetooth - A Google Pixel smartphone communicating with the Daydream VR device via Bluetooth.  Both devices were placed in the iso-box and recorded.

Iphone6Wifi - An Iphone was set up to view streming video via Wifi. While the stream was active, the Iphone was placed in the iso-box.  Spectrum was captured during the period in which the Iphone attempted (unsuccessfully) to regain video link, generating a good deal of bursty WiFi traffic.

IsoBoxAmbient - A series of recordings of the ambient spectrum within the iso-box.  This data reveals that the RF isolation of the recording box is not perfect, as expected, and some weak signalling can be detected.


Please contact Tom Chatt at thomas.j.chatt@lmco.com with any questions regarding this data set.
