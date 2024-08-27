include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk
 
PKG_NAME:=CAPWAP
PKG_VERSION=1
PKG_RELEASE:=1.0
 
PKG_BUILD_DIR := $(KERNEL_BUILD_DIR)/$(PKG_NAME)
 
include $(INCLUDE_DIR)/package.mk
 
define Package/CAPWAP
	SECTION:=utils
	CATEGORY:=CAPWAP_ac_wtp
	TITLE:=ac and WTP in CAPWAP
endef
 
define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./openCAPWAP/* $(PKG_BUILD_DIR)
endef
 
define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
	$(TARGET_CONFIGURE_OPTS) \
	#CFLAGS="$(TARGET_CFLAGS)" \
	#CPPFLAGS="$(TARGET_CPPFLAGS)" \
	#LDFLAGS="$(TARGET_LDFLAGS)"
endef
 
define Package/CAPWAP/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/AC $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/WTP $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) /opt/openssl098e/openssl-0.9.8e/build_arm/lib/libssl* $(1)/usr/lib/
	$(INSTALL_BIN) /opt/openssl098e/openssl-0.9.8e/build_arm/lib/libcrypto* $(1)/usr/lib/
	$(INSTALL_BIN) /opt/libnl3/libnl-3.0/lib/.libs/libnl* $(1)/usr/lib/
endef
 
$(eval $(call BuildPackage,CAPWAP))
