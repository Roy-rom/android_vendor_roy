# Versioning System
ROY_CODENAME := royal
ROY_MAJOR_VERSION := v1.0
ROY_RELEASE_VERSION := Alpha
ROY_BUILD_TYPE ?= UNOFFICIAL
ROY_BUILD_VARIANT := VANILLA

# Gapps
ifeq ($(WITH_GAPPS),true)
ROY_BUILD_VARIANT := GAPPS
endif

# RoyOS Release
ifeq ($(ROY_BUILD_TYPE), OFFICIAL)
  OFFICIAL_DEVICES = $(shell cat vendor/roy/roy.devices)
  FOUND_DEVICE =  $(filter $(ROY_BUILD), $(OFFICIAL_DEVICES))
    ifeq ($(FOUND_DEVICE),$(ROY_BUILD))
      ROY_BUILD_TYPE := OFFICIAL
    else
      ROY_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(ROY_BUILD)")
    endif
endif

# System version
TARGET_PRODUCT_SHORT := $(subst roy_,,$(ROY_BUILD_TYPE))

ROY_DATE_YEAR := $(shell date -u +%Y)
ROY_DATE_MONTH := $(shell date -u +%m)
ROY_DATE_DAY := $(shell date -u +%d)
ROY_DATE_HOUR := $(shell date -u +%H)
ROY_DATE_MINUTE := $(shell date -u +%M)

ROY_BUILD_DATE := $(ROY_DATE_YEAR)$(ROY_DATE_MONTH)$(ROY_DATE_DAY)-$(ROY_DATE_HOUR)$(ROY_DATE_MINUTE)
ROY_BUILD_VERSION := $(ROY_MAJOR_VERSION)-$(ROY_RELEASE_VERSION)
ROY_BUILD_FINGERPRINT := RoyOS/$(ROY_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(ROY_BUILD_DATE)
ROY_VERSION := RoyOS-$(ROY_CODENAME)-$(ROY_BUILD_VERSION)-$(ROY_BUILD)-$(ROY_BUILD_TYPE)-$(ROY_BUILD_DATE)
ROY_RELEASE := RoyOS-$(ROY_CODENAME)-$(ROY_BUILD_VERSION)-$(ROY_BUILD)-$(ROY_BUILD_TYPE)-$(ROY_BUILD_VARIANT)-$(ROY_BUILD_DATE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.roy.device=$(ROY_BUILD) \
  ro.roy.version=$(ROY_VERSION) \
  ro.roy.build.version=$(ROY_BUILD_VERSION) \
  ro.roy.build.type=$(ROY_BUILD_TYPE) \
  ro.roy.build.variant=$(ROY_BUILD_VARIANT) \
  ro.roy.build.date=$(ROY_BUILD_DATE) \
  ro.roy.build.fingerprint=$(ROY_BUILD_FINGERPRINT)