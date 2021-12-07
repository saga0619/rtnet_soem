# Simple Open EtherCAT Master Library (RTNET VERSION)

This RTNE-SOEM is rtnet patched SOEM!. RTNET specific socket configuration codes are added on SOEM.

SOEM is an EtherCAT master library written in c, developed by OpenEthercatSociety (https://openethercatsociety.github.io/doc/soem/)

RTnet is an Open Soure hard real-time network protocol stack for Xenomai and RTAI (real-time Linux extensions) 

RTnet_SOEM is RealTime EtherCAT master library. 

This library is recommended to implemented at ubuntu 20.04, Linux 5.4.124, xenomai-3.1.1

In Ubuntu 18.04, RTnet did not operate normally



# RTNET SOEM


Then test with Real 33DOF humanoid robot. It's working very well with almost no timeout!.

The stability test lasted for more than 20 hours(not in once), of which timeout occurred only once

Test Configuration 
- Ubuntu 20.04
- Linux 5.4.124, Xenomai-3.1.1.

Tested With Humanoid Robot [TOCABI](https://github.com/saga0619/dyros_tocabi_v2)

Tested Master PC : 
- CPU : i7-10700
- M/B : Gigabyte H470i
- NIC : Intel I340-T4 ( 4 Port PCI NIC )

- Slave : ELMO GOLD WHISTLE
- 18 slaves Redundant (2 Port) + 15 slaves Redundant (2 Port)



How to Use RTNET with SOEM?

You need to make your own Shell script files to start rtnet.

You can check example rtnet shell script at rtnet_script folder.

On example shell script, It contains, 

- load rtpacket kernel module with modprobe.
- unbind non-rt driver of nic, and bind rt driver.
- activate rt nic with rtifconfig.

other rtnet modules like rtcap, rtudp... rt.... are not essential.

you can test rtnet-soem with red_test!

red_test is build default with SOEM.

* ./red_test rteth0 rteth1 500



PROGRAMMING
===========

It is recommended to place rt-specific code(like communication codes of soem) in real-time thread!

Only `ec_init` or `ec_init_redundant` must be placed in main thread! 

When the `ec_init` or `ec_init_redundant` codes are in the real-time thread, the initialization process of ethercat communication does not proceed successfully.

Other communication codes except `ec_init`, `ec_init_redundant` must be placed on real-time thread. 

You can find our robot's RTNET-SOEM ethercat communication codes in here [Tocabi ECAT](https://github.com/saga0619/tocabi_ecat)



BUILDING
========

Prerequisites for all platforms
-------------------------------

 * CMake 3.9 or later

Linux (XENOMAI ONLY!)
-----

   * `mkdir build`
   * `cd build`
   * `cmake ..`
   * `make`

Documentation
-------------

See https://openethercatsociety.github.io/doc/soem/


Want to contribute to SOEM or SOES?
-----------------------------------

If you want to contribute to SOEM or SOES you will need to sign a Contributor
License Agreement and send it to us either by e-mail or by physical mail. More
information is available in the [PDF](http://openethercatsociety.github.io/cla/cla_soem_soes.pdf).
