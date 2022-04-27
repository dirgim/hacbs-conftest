FROM registry.access.redhat.com/ubi8/ubi

ARG conftest_version=0.30.0
ARG go_version=1.18.1
ARG gosec_version=2.11.0

RUN curl -L https://github.com/open-policy-agent/conftest/releases/download/v"${conftest_version}"/conftest_"${conftest_version}"_Linux_x86_64.tar.gz | tar -xz --no-same-owner -C /usr/bin/ && \
    curl -L https://go.dev/dl/go"${go_version}".linux-amd64.tar.gz | tar -xz --no-same-owner -C /usr/local/ && \
    curl -sfL https://raw.githubusercontent.com/securego/gosec/master/install.sh | sh -s -- -b /usr/local/go/bin v"${gosec_version}" && \
    dnf -y --setopt=tsflags=nodocs install \
    jq \
    git \
    skopeo

ENV PATH $PATH:/usr/local/go/bin

COPY policies /project