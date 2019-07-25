#!../../bin/linuxRT-i686/CAENHV

## You may have to change CAENHV to something else
## everywhere it appears in this file

< envPaths

# ===========================================
#            ENVIRONMENT VARIABLES
# ===========================================

# Asyn port name
epicsEnvSet("CAENHVASYN_PORT", "CAENHVASYN_PORT")

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

# CAENHVAsynConfig(
#     portName,     # Asyn port name
#     systemType,   # Type of system
#     ipAddr,       # Power supply IP address 
#     userName,     # User name 
#     password)     # Password
CAENHVAsynConfig("${CAENHVASYN_PORT}",3,"134.79.219.251","admin","admin")
#CAENHVAsynConfig("${CAENHVASYN_PORT}",3,"hvps-b084-mp01","admin","admin")

# ===========================================
#               ASYN MASKS
# ===========================================
asynSetTraceMask("${CAENHVASYN_PORT}",, -1, 0)

# ===========================================
#               DB LOADING
# ===========================================
## Load record instances
#dbLoadRecords("db/CAENHV.db","user=jvasquez")

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
save_restoreSet_status_prefix("${PREFIX_MPS_BASE}:")

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
