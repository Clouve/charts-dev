#!/usr/bin/env bash
set -e

# Script location and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." &>/dev/null && pwd)"
CURRENT_DIR="$(pwd)"

# Default settings
IMAGE_NAME="charts-dev-builder"
IMAGE_TAG="latest"
PULL_ENABLED=false
OUTPUT_DIR="$PROJECT_ROOT"

# Help text
function show_help {
  echo "Usage: $0 [options]"
  echo ""
  echo "Run charts-dev builder in Docker container"
  echo ""
  echo "Options:"
  echo "  -h, --help              Show this help message"
  echo "  -p, --pull              Enable pulling charts before processing and packaging"
  echo "  -o, --output-dir DIR    Specify output directory (default: current directory)"
  echo "  -t, --tag TAG           Specify Docker image tag (default: latest)"
  echo ""
  echo "Example:"
  echo "  $0 --pull --output-dir /path/to/output"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      show_help
      exit 0
      ;;
    -p|--pull)
      PULL_ENABLED=true
      shift
      ;;
    -o|--output-dir)
      OUTPUT_DIR="$2"
      shift 2
      ;;
    -t|--tag)
      IMAGE_TAG="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
  esac
done

# Ensure output directory is absolute path
if [[ ! "$OUTPUT_DIR" = /* ]]; then
  OUTPUT_DIR="$CURRENT_DIR/$OUTPUT_DIR"
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR/repo"
mkdir -p "$OUTPUT_DIR/lib"

echo "Using output directory: $OUTPUT_DIR"

# Prepare Docker run arguments
DOCKER_ARGS=()

# Add pull argument if enabled
if [ "$PULL_ENABLED" = true ]; then
  DOCKER_ARGS+=("pull")
fi

# Run the container
echo "Running build process with image: $IMAGE_NAME:$IMAGE_TAG"
docker run --rm \
  -v "$OUTPUT_DIR:/charts-dev" \
  "$IMAGE_NAME:$IMAGE_TAG" "${DOCKER_ARGS[@]}"

echo ""
echo "Build complete!"
echo "Output directory: $OUTPUT_DIR"
