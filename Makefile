THEOS_DEVICE_IP = 172.16.184.68

ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Ability
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard && killall -9 Preferences"
SUBPROJECTS += abilityprefs
include $(THEOS_MAKE_PATH)/aggregate.mk

