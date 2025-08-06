# Nuvla deployment on Kubernetes

[![BUILD](https://github.com/nuvla/deployment-k8s/actions/workflows/main.yml/badge.svg)](https://github.com/nuvla/deployment-k8s/actions/workflows/main.yml)

This repository contains Helm charts and deployment definitions for the Nuvla
platform on Kubernetes clusters.

## Deployment Options

- **[demo](https://github.com/nuvla/deployment-k8s/tree/master/demo)**: Contains
  a Helm chart for quick provisioning of Nuvla for demonstration or
  evaluation purposes. The deployment uses the latest released components of
  Nuvla and `emptyDir` volumes. **Data is not persisted** across pod restarts.

- **[test](https://github.com/nuvla/deployment-k8s/tree/master/test)**: Contains
  deployment definitions for testing and evaluation using development versions
  of Nuvla components from the master branch. Uses `emptyDir` volumes, so
  **data is not persisted** across pod restarts.

- **[prod](https://github.com/nuvla/deployment-k8s/tree/master/prod)**: Contains
  production-ready deployment definitions with persistent storage. Includes
  separate Helm charts for:
  - Elasticsearch (data persistence layer)
  - Zookeeper (coordination service)
  - Kafka (messaging/notifications via Strimzi operator)
  - Nuvla core services (API, UI, Jobs)

## Prerequisites

- Kubernetes cluster `>=1.23.1` (demo requires `>=1.29.1`)
- Helm 3.x
- kubectl configured to access your cluster

## Quick Start

For a quick evaluation, use the demo deployment:

```bash
helm repo add nuvla https://nuvla.github.io/deployment-k8s
helm install -n nuvla-demo --create-namespace nuvla-demo nuvla/nuvla-demo
```

For production deployments, see the [prod](prod/) directory for detailed
instructions.

## Test Infrastructure

The repository includes automated test infrastructure in the [test/cluster](test/cluster/)
directory that can provision a Kubernetes cluster on Exoscale cloud for testing purposes.
This includes:

- Scripts to deploy/terminate Kubernetes clusters
- End-to-end functional tests
- GitHub Actions workflows for continuous integration

## Repository Structure

```text
├── demo/                   # Demo Helm chart (single chart deployment)
├── test/                   # Test deployment and cluster provisioning
│   ├── cluster/            # Kubernetes cluster deployment scripts
│   └── e2e-tests/          # End-to-end functional tests
└── prod/                   # Production deployment (modular charts)
    ├── 01-elasticsearch/   # Elasticsearch Helm chart
    ├── 02-zookeeper/       # Zookeeper Helm chart
    ├── 03-kafka/           # Kafka deployment via Strimzi
    └── 04-core/            # Nuvla core services Helm chart
```

## Contributing

### Source Code Changes

To contribute code to this repository, please follow these steps:

 1. Create a branch from master with a descriptive, kebab-cased name
    to hold all your changes.

 2. Follow the developer guidelines concerning formatting, etc. when
    modifying the code.
   
 3. Once the changes are ready to be reviewed, create a GitHub pull
    request.  With the pull request, provide a description of the
    changes and links to any relevant issues (in this repository or
    others).
   
 4. Ensure that the triggered CI checks all pass.  These are triggered
    automatically with the results shown directly in the pull request.

 5. Once the checks pass, assign the pull request to the repository
    coordinator (who may then assign it to someone else).

 6. Interact with the reviewer to address any comments.

When the reviewer is happy with the pull request, they will "squash
& merge" the pull request and delete the corresponding branch.

### Testing

Add appropriate tests that verify the changes or additions you make to
the source code.

### Code Formatting

This repository contains Helm charts and bash scripts. When modifying a file,
keep the style of the existing code.

## Copyright

Copyright &copy; 2025, SixSq SA

## License

Licensed under the Apache License, Version 2.0 (the "License"); you
may not use this file except in compliance with the License.  You may
obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied.  See the License for the specific language governing
permissions and limitations under the License.
