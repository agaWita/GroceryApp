# Copyright (c) 2023 Grinn sp. z o.o.
#
# These computer program listings and specifications, are the property of
# Grinn sp. z o.o. and shall not be reproduced or copied or used in
# whole or in part without written permission from Grinn sp. z o.o.

SHELL := /bin/bash
REPO_DIR := $(shell pwd)

FLUTTER_SDK_PATH=/usr/lib/flutter
FLUTTER_PATH := $(FLUTTER_SDK_PATH)/bin/flutter
FLUTTER_APP_PATH := app/grocery_app/
ANDROID_SDK_PATH := android_sdk
TEST_DEVICE_ID ?= 34HDU19A31000473

SUDO ?= sudo
