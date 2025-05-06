# Technical Context

## Technology Stack

### Kubernetes and Helm
- **Helm**: Version 3.x - Package manager for Kubernetes
- **Kubernetes**: Target platform for all chart deployments
- **Helm Chart Structure**: Following Helm v3 standards and best practices

### Chart Development
- **YAML**: Primary configuration format for Kubernetes resources and Helm templates
- **Go Templates**: Used within Helm for template rendering
- **JSON Schema**: Used for values.schema.json validation files

### Chart Components
- **Bitnami Dependencies**: Many charts leverage Bitnami container images and chart dependencies
- **Common Chart Patterns**: Standardized approaches to configuration, deployment, services, etc.
- **OCI Repositories**: Charts reference OCI registries for dependencies

## Development Environment

### Requirements
- Kubernetes cluster (local or remote) for testing
- Helm CLI tool (v3.x+)
- kubectl for cluster interaction
- Container registry access (for testing with non-public images)
- Docker (for containerized build environment)

### Build Environment
- Docker-based containerized build system
- Alpine Linux container with all required dependencies
- Separation of build and run operations for efficiency

### Testing Setup
- Test scripts in `/test` directory
- Test configurations for validating chart functionality

## Project Structure

### Key Directories
- `/lib`: Contains source charts for various applications
  - Each application has its own directory (e.g., `/lib/drupal`, `/lib/ghost`)
- `/repo`: Packaged chart releases (.tgz files)
- `/src`: Contains additional source charts or development versions
- `/test`: Testing scripts and configurations
- `/dkr`: Docker-based build system configuration
  - `Dockerfile`: Defines the container image
  - `build.sh`: Script to build the Docker image
  - `run.sh`: Script to run the build process in a container
  - `README.md`: Documentation for the Docker build process

### Chart Directory Structure
Each application chart follows a standard structure:
```
<application>/
├── Chart.yaml           # Chart metadata, versions, dependencies
├── values.yaml          # Default configuration values
├── values.schema.json   # JSON schema for validation
├── README.md            # Chart documentation
├── charts/              # Chart dependencies
└── templates/           # Kubernetes manifest templates
    ├── deployment.yaml
    ├── service.yaml
    ├── ingress.yaml
    └── ...
```

## Dependencies and Integration

### Database Dependencies
- MariaDB/MySQL: Used by most CMS applications
- PostgreSQL: Alternative database for some applications
- MongoDB: Used by specific applications

### Container Images
- Official application images (e.g., WordPress, Drupal)
- Bitnami-maintained application images
- Supporting containers (databases, proxies, etc.)

### External Services
- Ingress controllers for external access
- Cert-manager for certificate handling (optional)
- Prometheus for monitoring (optional)

## Deployment Configuration

### Configuration Parameters
- Application-specific settings
- Database connection details
- Persistence configuration
- Ingress and TLS settings
- Resource allocation

### Security Considerations
- Pod security contexts
- Network policies
- Secret management
- Ingress protection
- Resource isolation

## Build and Release Process

### Chart Development Workflow
1. Create/update chart source in `/lib` directory
2. Update Chart.yaml with version info
3. Test chart functionality
4. Package chart to `/repo` directory
5. Update repository index

### Docker-based Build Process
1. Build Docker image with all required dependencies
   ```bash
   ./dkr/build.sh [--tag TAG]
   ```
2. Run container to process and package charts
   ```bash
   ./dkr/run.sh [--pull] [--output-dir DIR] [--tag TAG]
   ```
3. Optionally pull latest charts from upstream repositories using the `--pull` flag
4. Output packaged charts to the specified directory or current working directory

### Versioning Strategy
- Charts follow semantic versioning (MAJOR.MINOR.PATCH)
- Chart versions often track application versions
- Dependencies specify version ranges for compatibility
