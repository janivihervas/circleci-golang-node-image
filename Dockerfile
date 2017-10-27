# Docker image for adding Node 6.11.2 to circleci/golang:1.9.1

# FROM https://github.com/circleci/circleci-images/blob/master/shared/images/Dockerfile-basic.template
FROM golang:1.9.2

# make Apt non-interactive
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90circleci \
  && echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/90circleci

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y \
    git mercurial xvfb \
    locales sudo openssh-client ca-certificates tar gzip parallel \
    net-tools netcat unzip zip bzip2


# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Use unicode
RUN locale-gen C.UTF-8 || true
ENV LANG=C.UTF-8

# install jq
RUN JQ_URL="https://circle-downloads.s3.amazonaws.com/circleci-images/cache/linux-amd64/jq-latest" \
  && curl --silent --show-error --location --fail --retry 3 --output /usr/bin/jq $JQ_URL \
  && chmod +x /usr/bin/jq \
  && jq --version

# END https://github.com/circleci/circleci-images/blob/master/shared/images/Dockerfile-basic.template

RUN apt-get update && apt-get install -y \
    xz-utils

# Install node
ENV NODE_VERSION="6.11.2"
ENV NODE_ZIP="node-v$NODE_VERSION-linux-x64.tar.xz"

RUN wget -P downloads https://nodejs.org/dist/v$NODE_VERSION/$NODE_ZIP && \
    tar -C /usr/local --strip-components 1 -xJf downloads/$NODE_ZIP && \
    rm -rf downloads

# FROM https://github.com/circleci/circleci-images/blob/master/shared/images/Dockerfile-basic.template
RUN groupadd --gid 3434 circleci \
  && useradd --uid 3434 --gid circleci --shell /bin/bash --create-home circleci \
  && echo 'circleci ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-circleci \
  && echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep

USER circleci

CMD ["/bin/sh"]
# END https://github.com/circleci/circleci-images/blob/master/shared/images/Dockerfile-basic.template
