# Docker Build for Charts Dev

This directory contains Docker configuration for building the charts-dev project in a containerized environment. This setup ensures consistent build environments and simplifies the build process.

## Contents

- `Dockerfile`: Defines the container image with all necessary dependencies
- `build.sh`: Shell script to build the Docker image
- `run.sh`: Shell script to run the build process in a container

## Prerequisites

- Docker installed and running on your system
- Bash shell (Linux, macOS, or Windows with Git Bash or WSL)

## How it Works

The containerized build process is split into two separate steps:

1. **Build Image**: Creates a Docker image with all required dependencies (Helm, yq, etc.)
2. **Run Container**: Executes the build script inside the container with mounted volumes to preserve artifacts

This split approach allows you to:
- Build the image once and run the container multiple times
- Avoid rebuilding the image when only configuration changes are needed
- Save time on subsequent builds

## Using the Docker Scripts

The process is split into two separate steps:

1. `build.sh`: Builds the Docker image (run once or when Dockerfile changes)
2. `run.sh`: Runs the container to process and package charts (run as needed)

These scripts can be run from any directory in the system by using their absolute path.

### Building the Docker Image

```bash
./dkr/build.sh
```

#### Options for build.sh

```
Usage: ./dkr/build.sh [options]

Build Docker image for charts-dev builder

Options:
  -h, --help              Show this help message
  -t, --tag TAG           Specify Docker image tag (default: latest)

Example:
  ./dkr/build.sh --tag 1.0.0
```

### Running the Build Process

```bash
./dkr/run.sh
```

#### Options for run.sh

```
Usage: ./dkr/run.sh [options]

Run charts-dev builder in Docker container

Options:
  -h, --help              Show this help message
  -p, --pull              Enable pulling charts before processing and packaging
  -o, --output-dir DIR    Specify output directory (default: current directory)
  -t, --tag TAG           Specify Docker image tag (default: latest)

Example:
  ./dkr/run.sh --pull --output-dir /path/to/output
```

### Common Use Cases

#### Complete Build Process

For a full build from scratch:

```bash
# Step 1: Build the Docker image (only needed once or when Dockerfile changes)
./dkr/build.sh

# Step 2: Run the build process
./dkr/run.sh
```

#### Pull and Build All Charts

To pull the latest charts before building:

```bash
./dkr/run.sh --pull
```

#### Specify Output Directory

To save build artifacts to a specific directory:

```bash
./dkr/run.sh --output-dir /path/to/output
```

#### Custom Docker Image Tag

To use a specific tag for both building and running:

```bash
# Build with custom tag
./dkr/build.sh --tag 1.0.0

# Run with the same custom tag
./dkr/run.sh --tag 1.0.0
```

## Alternative Docker Commands

If you prefer to run Docker commands directly:

### Build the Docker Image

```bash
docker build -t charts-dev-builder:latest .
```

### Run the Container

```bash
# Without pulling charts
docker run --rm -v "$(pwd)/repo:/charts-dev/repo" -v "$(pwd)/lib:/charts-dev/lib" charts-dev-builder:latest

# With pulling charts
docker run --rm -v "$(pwd)/repo:/charts-dev/repo" -v "$(pwd)/lib:/charts-dev/lib" charts-dev-builder:latest pull
```

## Troubleshooting

- **Permission Issues**: If you encounter permission problems with the output files, you may need to adjust the permissions in the container or run Docker with appropriate user mapping.

- **Volume Mounts**: Ensure the directories for volume mounts exist before running the container.

- **Network Issues**: If pulling charts fails, check your network connection and any proxy settings that might affect container network access.
