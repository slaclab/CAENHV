# Release notes

Release notes for the CAEN HV Power Supply IOC.

## Releases:
* __R3.1.0__: 2025-10-07 J. Mock (jmock)
  * B913 unit added back in
  * Complete rhel9 upgrade:
    * Update .so libraries for CAEM, asyn, autosave, ioc stats, pv, seq, seqCar
    * Add .so libraries for curses, readline, and tinfo

* __R3.1.0-b__: 2025-08-19 J. Mock (jmock)
  * -b in tag name means broken - the B913 unit is currently broken and
      commented out
  * Complete rhel9 upgrade:
    * Update .so libraries for CAEM, asyn, autosave, ioc stats, pv, seq, seqCar
    * Add .so libraries for curses, readline, and tinfo

* __R3.0.0__: 2025-06-24 K. Leleux (kleleux)
  * Building for rhel9
  * Changing PINI for VSET and ISET

* __R2.0.0__: 2024-10-22 J. Mock
  * Build against CAENHVAsyn R2.0.0
  * Build as rhel7 instead of rhel6
  * Add SXR CBLMs to B913 for LCLS-II-HE

* __R1.1.0__: 2021-09-18 J. Mock
  * Add PMTs to ch 21 and 22 of slot 2 in B921

* __R1.0.1__: 2020-04-06 J. Mock
  * Add folder containing missing libraries - this does not build statically
  * Add PVs to hv_channel.template file to be able to set and monitor
     Voltage, Current, and on/off, and a calc PV to calculate dynode resistance

* __R1.0.0__: 2019-09-06 J. Vasquez
  * Create specific DBs for the BLMs in addition to generic 
    autogen PVs.

* __R0.0.0__: 2019-09-06 J. Vasquez
  * First release candidate.
