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
#DB += xxx.db
DB_INSTALLS += $(CAENHVASYN)/db/ai.template
DB_INSTALLS += $(CAENHVASYN)/db/ao.template
DB_INSTALLS += $(CAENHVASYN)/db/bi.template
DB_INSTALLS += $(CAENHVASYN)/db/bo.template
DB_INSTALLS += $(CAENHVASYN)/db/stringin.template
DB_INSTALLS += $(CAENHVASYN)/db/stringout.template
DB_INSTALLS += $(CAENHVASYN)/db/longin.template
DB_INSTALLS += $(CAENHVASYN)/db/longout.template

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_template = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

