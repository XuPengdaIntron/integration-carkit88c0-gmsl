#!/bin/bash

busybox devmem 0x0c302048
busybox devmem 0x0c302028
busybox devmem 0x0c302050
busybox devmem 0x0c302038
busybox devmem 0x02430048
busybox devmem 0x02440010

busybox devmem 0x0c302048 w 0x1408
busybox devmem 0x0c302028 w 0x408
busybox devmem 0x0c302050 w 0x458
busybox devmem 0x0c302038 w 0x9
busybox devmem 0x02430048 w 0x57
busybox devmem 0x02440010 w 0x57

busybox devmem 0x0c302048
busybox devmem 0x0c302028
busybox devmem 0x0c302050
busybox devmem 0x0c302038
busybox devmem 0x02430048
busybox devmem 0x02440010