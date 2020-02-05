TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

# =====================================================
# Path to "NON EPICS" External PACKAGES: USER INCLUDES
# ======================================================
USR_INCLUDES = $(addprefix -I,$(CAENHVWRAPPER_INCLUDE))
# =====================================================

# ======================================================
# PATH TO "NON EPICS" EXTERNAL PACKAGES: USER LIBRARIES
# ======================================================
caenhvwrapper_DIR = $(CAENHVWRAPPER_LIB)
# =====================================================

# ======================================================
# LINK "NON EPICS" EXTERNAL PACKAGE LIBRARIES STATICALLY
# =======================================================
#USR_LIBS_Linux += CAENHVwrapper
USR_LIBS_Linux += caenhvwrapper
#USR_LDFLAGS += $(addprefix -L,$(CAENHVWRAPPER_LIB)) -lcaenhvwrapper
# ======================================================

#=============================
# Build the IOC application

PROD_IOC = CAENHV
# CAENHV.dbd will be created and installed
DBD += CAENHV.dbd


# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
   CAENHV_LIBS += qsrv
   CAENHV_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
   CAENHV_DBD += PVAServerRegister.dbd
   CAENHV_DBD += qsrv.dbd
endif

# Include dbd files from all support applications:
CAENHV_DBD += base.dbd
CAENHV_DBD += devIocStats.dbd
CAENHV_DBD += asSupport.dbd
CAENHV_DBD += asyn.dbd
CAENHV_DBD += CAENHVAsyn.dbd
CAENHV_DBD += devSeqCar.dbd

# Add all the support libraries needed by this IOC
CAENHV_LIBS += devIocStats
CAENHV_LIBS += autosave
CAENHV_LIBS += CAENHVAsyn
CAENHV_LIBS += asyn
CAENHV_LIBS += seqCar seq pv

# CAENHV_registerRecordDeviceDriver.cpp derives from CAENHV.dbd
CAENHV_SRCS += CAENHV_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
CAENHV_SRCS_DEFAULT += CAENHVMain.cpp
CAENHV_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#CAENHV_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
CAENHV_LIBS += $(EPICS_BASE_IOC_LIBS)

# Link QSRV (pvAccess Server) if available
#ifdef EPICS_QSRV_MAJOR_VERSION
#   CAENHV_LIBS +=git  qsrv
#   CAENHV_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
#   CAENHV_DBD += PVAServerRegister.dbd
#   CAENHV_DBD += qsrv.dbd
#endif

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

