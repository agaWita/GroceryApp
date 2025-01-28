FROM debian:12

USER root

# Set non-interactive mode to suppress prompts
ENV DEBIAN_FRONTEND=noninteractive

# Define SDK paths
ENV SDK_ROOT=/usr/lib
ENV ANDROID_SDK_ROOT=${SDK_ROOT}/android-sdk
ENV FLUTTER_SDK_ROOT=${SDK_ROOT}/flutter
ENV FLUTTER_SDK_VERSION=3.27.3-stable

# Update and install required packages
RUN apt-get update && apt-get install -y --no-install-recommends sudo \
    && apt-get install -y \
       watchman openjdk-17-jdk android-sdk nano make wget unzip zip curl git-all \
       xz-utils libglu1-mesa libc6:amd64 libstdc++6:amd64 lib32z1 libbz2-1.0:amd64 \
       libgbm1 xdg-utils qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Android Command Line Tools
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
    wget -O commandlinetools.zip "https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip" && \
    unzip commandlinetools.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools && \
    mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest && \
    rm commandlinetools.zip

# Accept Android SDK licenses and install components
RUN yes | ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --licenses && \
    ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-34" "build-tools;33.0.0"

# Install Flutter SDK
RUN cd ${SDK_ROOT} && \
    curl -OL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_SDK_VERSION}.tar.xz && \
    tar -xf flutter_linux_${FLUTTER_SDK_VERSION}.tar.xz -C ${SDK_ROOT} && \
    rm -rf flutter_linux_${FLUTTER_SDK_VERSION}.tar.xz \
    cd ~

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create a user and set up permissions
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID \
               --gid $USER_GID \
               -m $USERNAME \
               -s /bin/bash \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Add the user to necessary groups
RUN usermod -aG sudo ${USERNAME} && \
    usermod -aG dialout ${USERNAME} && \
    usermod -aG plugdev ${USERNAME}

# Switch to the non-root user
USER ${USERNAME}

# Add Flutter and Android tools to path
ENV PATH="${FLUTTER_SDK_ROOT}/bin:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}"

# Change ownership of the Flutter and Android SDK to the non-root user
RUN sudo chown -R ${USERNAME}:${USERNAME} ${FLUTTER_SDK_ROOT} ${ANDROID_SDK_ROOT}
RUN sudo chmod -R u+rw ${FLUTTER_SDK_ROOT} ${ANDROID_SDK_ROOT}
RUN sudo chown -R ${USERNAME}:${USERNAME} ${FLUTTER_SDK_ROOT}/.git
RUN sudo chmod -R u+rw ${FLUTTER_SDK_ROOT}/.git

# Add Flutter to safe directory for git
RUN git config --global --add safe.directory ${FLUTTER_SDK_ROOT}

# Define the CHROME_URL variable for the Chrome package download
ENV CHROME_URL=https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Install Google Chrome
RUN sudo apt-get update && sudo apt-get install -y fonts-liberation
RUN wget ${CHROME_URL} -O /tmp/google-chrome-stable_current_amd64.deb && \
    sudo apt install -y /tmp/google-chrome-stable_current_amd64.deb && \
    rm -rf /tmp/google-chrome-stable_current_amd64.deb

# Disable Flutter telemetry
RUN flutter --disable-analytics

# Reset DEBIAN_FRONTEND to dialog for runtime interactions
ENV DEBIAN_FRONTEND=dialog

# Default shell to bash
SHELL ["/bin/bash", "-c"]
