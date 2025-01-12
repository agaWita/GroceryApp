# Copyright (c) 2023 Grinn sp. z o.o.
#
# These computer program listings and specifications, are the property of
# Grinn sp. z o.o. and shall not be reproduced or copied or used in
# whole or in part without written permission from Grinn sp. z o.o.

get-app-path:
	echo ${FLUTTER_APP_PATH}

flutter-pub-get:
	(cd ${FLUTTER_APP_PATH} && ${FLUTTER_PATH} pub get)

flutter-pub-upgrade:
	(cd ${FLUTTER_APP_PATH} && ${FLUTTER_PATH} pub upgrade)

web-config:
	cd ${FLUTTER_APP_PATH} && \
	${FLUTTER_PATH} channel stable && \
	${FLUTTER_PATH} upgrade && \
	${FLUTTER_PATH} config --enable-web

