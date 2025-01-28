# Copyright (c) 2023 Grinn sp. z o.o.
#
# These computer program listings and specifications, are the property of
# Grinn sp. z o.o. and shall not be reproduced or copied or used in
# whole or in part without written permission from Grinn sp. z o.o.

include makefiles/variables.mk
include makefiles/flutter.mk

#FIXME: should be moved to docker
setup:
	sudo chown -R $(shell whoami) $(FLUTTER_SDK_PATH)
	sudo chmod -R u+rw $(FLUTTER_SDK_PATH)
	sudo chown -R $(shell whoami) $(FLUTTER_SDK_PATH)/.git
	sudo chmod -R u+rw $(FLUTTER_SDK_PATH)/.git

build-mobile:
	(cd ${FLUTTER_APP_PATH} && ${FLUTTER_PATH} build apk)

build-web:
	(cd ${FLUTTER_APP_PATH} && ${FLUTTER_PATH} build web)
# then run e.g. ``http-server-spa ./build/web index.html 8080`` to host

run-mobile:
	@echo "Running on device: $(TEST_DEVICE_ID)"
	(cd $(FLUTTER_APP_PATH) && $(FLUTTER_PATH) run -d "$(TEST_DEVICE_ID)")

run-chrome:
	(cd ${FLUTTER_APP_PATH} && ${FLUTTER_PATH} run -d chrome --web-browser-flag "--disable-web-security")

run-web:
	(cd ${FLUTTER_APP_PATH} && ${FLUTTER_PATH} run -d web-server --web-browser-flag "--disable-web-security")

list-targets:
	${FLUTTER_PATH} devices

test:
	(cd ${FLUTTER_APP_PATH} && ${FLUTTER_PATH} test)

clean:
	(cd ${FLUTTER_APP_PATH} && ${FLUTTER_PATH} clean)

analyze:
	(cd ${FLUTTER_APP_PATH} && ${FLUTTER_PATH} analyze)

