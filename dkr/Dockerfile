FROM alpine:3.19

# Install required dependencies
RUN apk add --no-cache \
    bash \
    curl \
    git \
    jq \
    openssl \
    && curl -fsSL -o /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 \
    && chmod +x /usr/local/bin/yq

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh \
    && rm get_helm.sh

# Set working directory
WORKDIR /charts-dev

# Copy project files
COPY . .

# Make scripts executable
RUN chmod +x build pull process process_file package

# Set the build script as entry point
ENTRYPOINT ["/charts-dev/build"]
