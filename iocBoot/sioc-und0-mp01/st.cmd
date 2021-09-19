#!../../bin/rhel6-x86_64/CAENHV

## You may have to change CAENHV to something else
## everywhere it appears in this file

< envPaths

# ===========================================
#            ENVIRONMENT VARIABLES
# ===========================================

# iocAdmin variables
epicsEnvSet("ENGINEER", "J.Mock")
epicsEnvSet("STARTUP", "/usr/local/lcls/epics/iocCommon/${IOC}")
epicsEnvSet("ST_CMD", "st.cmd")
epicsEnvSet("IOC_NAME","SIOC:UND0:MP01")

# Asyn port name
epicsEnvSet("CAENHVASYN_PORT_B921", "CAEN_HVPS_B921")
epicsEnvSet("CAENHVASYN_PORT_B913", "CAEN_HVPS_B913")

# ======================================
# Start from TOP
# ======================================
cd ${TOP}

# ===========================================
#               DBD LOADING
# ===========================================
## Register all support components
dbLoadDatabase("dbd/CAENHV.dbd",0,0)
CAENHV_registerRecordDeviceDriver(pdbbase)

# ===========================================
#              DRIVER SETUP
# ===========================================

# Set EPICS prefix for autogenerated PVs
## You can comment out this line if to disable
## autogeneration of PVs.

# CAENHVAsynConfig(
#     portName,     # Asyn port name
#     systemType,   # Type of system
#     ipAddr,       # Power supply IP address
#     userName,     # User name
#     password)     # Password

CAENHVAsynSetEpicsPrefix("HVPS:UND0:MP01:")
# Crate located in B913 (node name: hvps-und0-mp01)
CAENHVAsynConfig("${CAENHVASYN_PORT_B913}",3,"172.27.13.34","admin","admin")

CAENHVAsynSetEpicsPrefix("HVPS:UND0:MP02:")
# Crate located in B921 (node name: hvps-und0-mp02)
CAENHVAsynConfig("${CAENHVASYN_PORT_B921}",3,"172.27.13.35","admin","admin")

# ===========================================
#               ASYN MASKS
# ===========================================

# Masks values:
## ASYN_TRACE_ERROR     0x01
## ASYN_TRACEIO_DEVICE  0x02
## ASYN_TRACEIO_FILTER  0x04
## ASYN_TRACEIO_DRIVER  0x08
## ASYN_TRACE_FLOW      0x10
asynSetTraceMask("${CAENHVASYN_PORT_B921}",0, 0)
asynSetTraceMask("${CAENHVASYN_PORT_B913}",0, 0)

# ===========================================
#               DB LOADING
# ===========================================

# Database examples, you normally should use only one of these
# at a given time, and without autogeneration of PV (even though
# it is possible to use it at the same time)

## System in B921
dbLoadRecords("db/b921.db","P=CBLM,PORT=${CAENHVASYN_PORT_B921}")
dbLoadRecords("db/b921_pmt.db","P=PMT,PORT=${CAENHVASYN_PORT_B921}")

## System in B913
dbLoadRecords("db/b913.db","P=CBLM,PORT=${CAENHVASYN_PORT_B913}")

dbLoadRecords("db/iocAdminSoft.db", "IOC=$(IOC_NAME)")
dbLoadRecords("db/iocRelease.db"   ,"IOC=$(IOC_NAME)")
dbLoadRecords("db/devSeqCar.db"    ,"SIOC=$(IOC_NAME)")
dbLoadRecords("db/save_restoreStatus.db","P=${IOC_NAME}:")

# ===========================================
#           SETUP AUTOSAVE/RESTORE
# ===========================================

# If all PVs don't connect continue anyway
save_restoreSet_IncompleteSetsOk(1)

# created save/restore backup files with date string
# useful for recovery.
save_restoreSet_DatedBackupFiles(1)

# Where to find the list of PVs to save
# Where "/data" is an NFS mount point setup when linuxRT target
# boots up.
set_requestfile_path("${IOC_DATA}/${IOC}/autosave-req")

# Where to write the save files that will be used to restore
set_savefile_path("${IOC_DATA}/${IOC}/autosave")

# Prefix that is use to update save/restore status database
# records
save_restoreSet_UseStatusPVs(1)
save_restoreSet_status_prefix("CBLM:UND0:MP01")

## Restore datasets
set_pass0_restoreFile("info_positions.sav")
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")
set_pass1_restoreFile("manual_settings.sav")

# ===========================================
#          CHANNEL ACESS SECURITY
# ===========================================
# This is required if you use caPutLog.
# Set access security filea
# Load common LCLS Access Configuration File
< ${ACF_INIT}

# ===========================================
#               IOC INIT
# ===========================================
iocInit()

# ===========================================
#           AUTOSAVE TASKS
# ===========================================

# Wait before building autosave files
epicsThreadSleep(1)

# Generate the autosave PV list
# Note we need change directory to
# where we are saving the restore
# request file, and then we go back
# ${TOP}.
cd ${IOC_DATA}/${IOC}/autosave-req
makeAutosaveFiles()
cd ${TOP}

# Start the save_restore task
# save changes on change, but no faster
# than every 5 seconds.
# Note: the last arg cannot be set to 0
create_monitor_set("info_positions.req", 5 )
create_monitor_set("info_settings.req" , 5 )
create_monitor_set("manual_settings.req" , 5 )
