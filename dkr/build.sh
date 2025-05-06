#!/usr/bin/env bash
set -e

# Script location and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." &>/dev/null && pwd)"

# Remain in the script directory for correct Dockerfile reference
cd "$SCRIPT_DIR"

# Default settings
IMAGE_NAME="charts-dev-builder"
IMAGE_TAG="latest"

# Help text
function show_help {
  echo "Usage: $0 [options]"
  echo ""
  echo "Build Docker image for charts-dev builder"
  echo ""
  echo "Options:"
  echo "  -h, --help              Show this help message"
  echo "  -t, --tag TAG           Specify Docker image tag (default: latest)"
  echo ""
  echo "Example:"
  echo "  $0 --tag 1.0.0"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      show_help
      exit 0
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

# Build Docker image
echo "Building Docker image: $IMAGE_NAME:$IMAGE_TAG"
docker build -t "$IMAGE_NAME:$IMAGE_TAG" -f "$SCRIPT_DIR/Dockerfile" "$PROJECT_ROOT"

echo ""
echo "Docker image build complete: $IMAGE_NAME:$IMAGE_TAG"
echo "You can now use ./dkr/run.sh to run the build process"
