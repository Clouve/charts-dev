# Active Context

## Current Work Focus

The current focus of the charts-dev project is maintaining and updating Helm charts for various popular web applications and content management systems. The repository houses charts for well-established platforms such as:

- Content Management Systems (CMS): WordPress, Drupal, Joomla, Ghost
- Wikis: MediaWiki, DokuWiki
- Learning Management Systems: Moodle, Canvas
- Customer Relationship Management (CRM): SuiteCRM, Odoo
- Other specialized applications: Osclass, BlueSky PDS, Gibbon

The primary tasks include:
- Keeping charts updated with the latest application versions
- Ensuring compatibility with current Kubernetes/Helm standards
- Maintaining consistency across chart implementations
- Testing and validating chart functionality

## Recent Changes

Based on the repository index and chart versions, recent activity includes:

1. **Docker-based build system**: Implementation of a containerized build system for consistent and isolated chart building
2. **WordPress chart updates**: Current version at 24.1.2 supporting WordPress 6.7.1
3. **Drupal chart updates**: Current version at 21.1.0 supporting Drupal 11.0.9
4. **Ghost chart updates**: Current version at 22.1.1 supporting Ghost 5.104.2
5. **Moodle chart updates**: Current version at 25.1.0 supporting Moodle 4.5.1
6. **Odoo chart updates**: Current version at 28.1.0 supporting Odoo 18.0.20241205

Many charts have been updated to leverage Bitnami container images and have transitioned to using OCI registry references for dependencies.

## Build System

A new Docker-based build system has been implemented to ensure consistent build environments and simplify the chart build process:

1. **Directory Structure**:
   - `/dkr` directory contains all Docker-related files
   - Key files include `Dockerfile`, `build.sh`, and `run.sh`
   - Comprehensive documentation in `/dkr/README.md`

2. **Build Process**:
   - Two-step process: image building and container execution
   - Build step (`./dkr/build.sh`) creates a Docker image with all dependencies
   - Run step (`./dkr/run.sh`) executes the container to process and package charts
   - Scripts can be run from any directory with correct path resolution

3. **Key Features**:
   - Containerized environment with all necessary dependencies
   - Volume mounting for preserving build artifacts
   - Support for pulling latest chart sources
   - Configurable output directories
   - Custom image tagging

4. **Integration**:
   - Leverages existing build scripts (`build`, `pull`, `process`, `process_file`, `package`)
   - Maintains the same output structure (`/lib` and `/repo` directories)
   - Preserves all chart packaging conventions and standards

## Implementation Patterns

Several key patterns have emerged in chart implementation:

1. **Dependency Management**:
   - Common use of MariaDB/MySQL charts as dependencies
   - Migration to OCI repository references (e.g., `oci://registry-1.docker.io/bitnamicharts`)
   - Standardized dependency versioning using semver ranges (e.g., `20.x.x`)

2. **Chart Structure**:
   - Consistent implementation of Chart.yaml, values.yaml, and values.schema.json
   - Standard template organization
   - Common approach to configuration options

3. **Container Images**:
   - Heavy use of Bitnami-maintained application images
   - Consistent image versioning patterns
   - Apache exporter and OS shell containers for monitoring and maintenance

4. **Versioning Approach**:
   - Chart versions typically increment with application versions
   - Major chart version bumps with significant application updates
   - Minor version bumps for chart improvements and fixes

## Active Decisions and Considerations

Several active considerations appear to be guiding development:

1. **Dependency Management**:
   - Transitioning from traditional Helm repository references to OCI registry references
   - Keeping dependencies within compatible version ranges
   - Standardizing common chart dependencies

2. **Maintainer Transition**:
   - Transition in maintainer attribution from individual entities (Bitnami, VMware) to "Broadcom, Inc. All Rights Reserved"
   - This suggests a corporate ownership or maintenance transition

3. **Security Considerations**:
   - Implementation of pod security contexts
   - Network policy configurations
   - Resource constraints and limits

4. **User Experience**:
   - Comprehensive default values
   - Detailed schema validation for configuration
   - Thorough documentation

## Important Patterns and Preferences

1. **Chart Packaging**:
   - Source charts maintained in `/lib` directory
   - Packaged charts stored in `/repo` directory
   - Consistent naming patterns: `<application>-<version>.tgz`

2. **Documentation**:
   - Each chart includes a README.md
   - Consistent annotation of supported application versions
   - Clear licensing information (primarily Apache-2.0)

3. **Testing**:
   - Test scripts in `/test` directory
   - JSON-based test configurations

4. **Deployment Configuration**:
   - Support for both Ingress and LoadBalancer services
   - TLS configuration options
   - Persistence configuration with fallbacks

## Next Steps and Priorities

Based on observed patterns and chart versions, likely priorities include:

1. Keep charts updated with latest application versions
2. Continue standardization of chart implementations
3. Address any security or compatibility issues with Kubernetes versions
4. Enhance monitoring and metrics capabilities
5. Improve documentation and usage examples
6. Consider adding new application charts based on user demand
