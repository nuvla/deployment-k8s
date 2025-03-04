# Nuvla deployment on Kubernetes

[![BUILD](https://github.com/nuvla/deployment-k8s/actions/workflows/main.yml/badge.svg)](https://github.com/nuvla/deployment-k8s/actions/workflows/main.yml)

This repository contains the definitions for the deployment of the Nuvla
platform on Kubernetes cluster.

 - [demo](https://github.com/nuvla/deployment-k8s/tree/master/demo): contains
 deployment definitions for quick provisioning of Nuvla for a demo or 
 evaluation. The deployment uses the latest released components of Nuvla. 
 Data is not persisted across restarts of the Nuvla DB layer.
 
 - [test](https://github.com/nuvla/deployment-k8s/tree/master/test): contains
 deployment definitions for quick provisioning of Nuvla for testing or
 evaluation. The deployment is done using latest Nuvla artifacts from the master
 branch. Data is not persisted across restarts of the Nuvla DB layer.
 
 - [prod](https://github.com/nuvla/deployment-k8s/tree/master/prod): contains
 deployment definitions suitable for deploying Nuvla for production usage.

# Contributing

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

When the reviewer is happy with the pull request, he/she will "squash
& merge" the pull request and delete the corresponding branch.

### Testing

Add appropriate tests that verify the changes or additions you make to
the source code.

### Code Formatting

This repository contains mostly Docker container descriptions and bash
scripts. When modifying a file, keep the style of the existing code.

## Copyright

Copyright &copy; 2025, SixSq SA

## License

Licensed under the Apache License, Version 2.0 (the "License"); you
may not use this file except in compliance with the License.  You may
obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied.  See the License for the specific language governing
permissions and limitations under the License.
