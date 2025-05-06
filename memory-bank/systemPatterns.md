# System Patterns

## Overall Architecture
The Charts Development project follows a standard Helm chart repository architecture with Docker-based build support:

```
charts-dev/
├── lib/             # Source charts organized by application
│   ├── drupal/      # Individual application chart
│   │   ├── Chart.yaml          # Chart metadata
│   │   ├── values.yaml         # Default configuration values
│   │   ├── values.schema.json  # JSON schema for validation
│   │   ├── README.md           # Chart documentation
│   │   ├── charts/             # Chart dependencies
│   │   └── templates/          # Kubernetes template files
│   ├── ghost/       # Similar structure for other applications
│   ├── joomla/
│   └── ...
├── dkr/             # Docker build system
│   ├── Dockerfile            # Container image definition
│   ├── build.sh              # Script to build Docker image
│   ├── run.sh                # Script to run build container
│   └── README.md             # Build system documentation
├── src/             # Additional source charts or development versions
├── repo/            # Packaged chart releases (.tgz files)
│   ├── drupal-21.1.0.tgz
│   ├── ghost-22.1.1.tgz
│   └── ...
└── test/            # Testing scripts and configurations
```

## Design Patterns

### 1. Containerized Build Environment
- Docker-based build system for consistent environments
- Separation of image building and container execution
- Location-independent script execution
- Volume mounting for preserving build artifacts
- Configurable output directories and chart sources

### 2. Chart Standardization
- Consistent structure across all application charts
- Common naming conventions for resources
- Standardized approach to configuration parameters
- Reusable patterns for similar application types

### 3. Dependency Management
- Common dependencies are managed consistently
- Charts reference specific versions of dependencies
- Chart.lock files maintain dependency integrity

### 4. Template Organization
- Templates follow a logical grouping
- Standard template files for common Kubernetes objects
- Consistent usage of Helm template functions
- Helper templates for reusable components

### 5. Configuration Management
- Hierarchical configuration structure
- Sensible defaults with override capabilities
- Clear schema validation for configuration values
- Documentation for all configurable options

## Component Relationships

### Chart Dependencies
- Many charts depend on database backends (MySQL, PostgreSQL)
- Infrastructure components (Ingress, TLS, persistence) are integrated consistently
- Version compatibility is maintained between components

### Resource Relationships
- Application deployments connect to their respective databases
- Ingress resources route to appropriate services
- Persistent volumes attach to stateful components
- Secrets management follows consistent patterns

## Critical Implementation Paths

### Chart Creation Process
1. Define Chart.yaml with proper metadata
2. Create standardized templates for Kubernetes resources
3. Establish sensible default values
4. Implement value schema validation
5. Document usage and configuration options
6. Package chart for distribution

### Chart Update Process
1. Update application version references
2. Test compatibility with new versions
3. Update dependencies if necessary
4. Update documentation for version-specific changes
5. Package and publish new chart version

### Docker Build Process
1. Build Docker image with all dependencies
   ```bash
   ./dkr/build.sh [--tag TAG]
   ```
2. Run container for chart processing
   ```bash
   ./dkr/run.sh [--pull] [--output-dir DIR] [--tag TAG]
   ```
3. Optional chart pulling from upstream repositories
4. Automated chart processing via mounted volumes
5. Packaged chart output to specified directories

### Testing Methodology
1. Validate chart against schema
2. Lint chart for best practices
3. Test deployment in isolated environments
4. Verify functionality of deployed application
5. Test upgrade paths from previous versions
