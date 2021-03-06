#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END

#
# Copyright (c) 2015, 2018, Oracle and/or its affiliates. All rights reserved.
#

include ../../../make-rules/shared-macros.mk
RUBY_VERSION=2.1
RUBY_LIB_VERSION=2.1.0
RUBY_VERSIONS=2.1.0

COMPONENT_NAME=		ruby-augeas
COMPONENT_VERSION=	0.5.0
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).gem
COMPONENT_ARCHIVE_HASH=	\
    sha256:42b0973c8ff88c5a903a1b126f1418a69eb3c8f4d45999055bfdce9b70e57101
COMPONENT_ARCHIVE_URL=	https://rubygems.org/gems/$(COMPONENT_SRC).gem
COMPONENT_PROJECT_URL=  https://github.com/hercules-team/ruby-augeas
COMPONENT_BUGDB=	utility/augeas
COMPONENT_ANITYA_ID=	17146

TPNO=                   21871

# No gemspec is shipped with the gem. Create one
COMPONENT_POST_UNPACK_ACTION= \
    $(GEM) spec $(COMPONENT_ARCHIVE) --ruby > $(SOURCE_DIR)/$(GEMSPEC)

# Copy files instead making symlinks. GEM does not handle symlinks.
CLONEY = true
COMPONENT_PRE_BUILD_ACTION += $(CP) -rp $(SOURCE_DIR)/* $(@D);

include $(WS_MAKE_RULES)/prep.mk
include $(WS_MAKE_RULES)/ips.mk
include $(WS_MAKE_RULES)/gem.mk
include $(WS_MAKE_RULES)/ruby.mk

# Before the 12 -> 11.4 rename, RUBY_DIR_VERS would always be the same as
# SOLARIS_VERSION (minus the leading "2.").  After the rename, there is a
# potential mismatch, because the triple $(MACH64)-solaris-$(SOLARIS_VERSION)
# is embedded in ruby, so we need to handle both the before and after cases.
# Once the transition is complete and build machines are running 11.4, these
# lines can be removed and the corresponding .p5m file changes can be reverted.
RUBY_DIR_VERS=$(shell $(RUBY) --version | $(GSED) -e 's/^.*solaris2.//' -e 's/]//')
PKG_PROTO_DIRS += $(PROTO_DIR)/$(VENDOR_GEM_DIR)/extensions/$(MACH64)-solaris-2.$(RUBY_DIR_VERS)/$(RUBY_LIB_VERSION)/ruby-augeas-$(COMPONENT_VERSION)

COMPONENT_TEST_CMD=	/usr/bin/rake
COMPONENT_TEST_DIR=	$(SOURCE_DIR)
COMPONENT_TEST_ARGS+=	test
COMPONENT_TEST_TRANSFORMS += \
        '-n ' \
	'-e "/failures/p" '

ASLR_MODE = $(ASLR_NOT_APPLICABLE)

build:		$(BUILD_64)

install:	$(INSTALL_64)

test:		$(TEST_64)

system-test:	$(SYSTEM_TESTS_NOT_IMPLEMENTED)

REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += runtime/ruby-21
REQUIRED_PACKAGES += system/core-os
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += system/linker
REQUIRED_PACKAGES += system/management/augeas

new-files:
	$(PKGSEND) generate $(PROTO_DIR) | \
		$(GSED) -e 's|group=.*||' -e s'|^file |file path=|' | \
		$(CAT) *.p5m - | $(PKGFMT) -u |\
		$(GSED) \
		  -e '/~[0-9]\+~$$/d' \
		  -e 's|$(VENDOR_RUBY)|$$(VENDOR_RUBY)|' | \
		sort | uniq -c | \
		$(GSED) -e '/ 2 /d' -e 's/   1 //' -e '/^file/!d'
