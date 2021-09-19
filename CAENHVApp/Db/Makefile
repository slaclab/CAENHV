TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
# Create and install (or just install) into <top>/db
# databases, templates, substitutions like this

# These records are used when the auto-generation of PVs
# is enabled.
DB_INSTALLS += $(CAENHVASYN)/db/ai.template
DB_INSTALLS += $(CAENHVASYN)/db/ao.template
DB_INSTALLS += $(CAENHVASYN)/db/bi.template
DB_INSTALLS += $(CAENHVASYN)/db/bo.template
DB_INSTALLS += $(CAENHVASYN)/db/stringin.template
DB_INSTALLS += $(CAENHVASYN)/db/stringout.template
DB_INSTALLS += $(CAENHVASYN)/db/longin.template
DB_INSTALLS += $(CAENHVASYN)/db/longout.template

# These are application specific PV definitions
DB += b921.db
DB += b921_pmt.db
DB += b913.db

# ========================================================
# Install databases from iocAdmin package
# These databases support IOC Health and Monitoring
# ========================================================
DB_INSTALLS += $(IOCADMIN)/db/iocAdminSoft.db
DB_INSTALLS += $(IOCADMIN)/db/iocAdminScanMon.db
DB_INSTALLS += $(IOCADMIN)/db/iocScanMonSum.db
DB_INSTALLS += $(IOCADMIN)/db/iocScanMon.db
DB_INSTALLS += $(SNCSEQ)/db/devSeqCar.db
DB_INSTALLS += $(AUTOSAVE)/db/save_restoreStatus.db
IOCRELEASE_DB += iocRelease.db

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_template = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

