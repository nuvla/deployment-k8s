# System tests

This directory contains several system level tests for running 
against Nuvla installation.

## Prerequisites

For connection to the Nuvla instance the following environment variable are required.
The defaults are provided below.

```shell script
NUVLA_USERNAME=super
NUVLA_PASSWORD=supeR8-supeR8
NUVLA_HOST=nuvla.io # <IP or DNS name>[:port]
NUVLA_INSECURE=TRUE
```

A Docker swarm cluster with the endpoint exposed via `https://$DOCKER_HOST:2376`. 
The following environment variables must be set.

```shell script
DOCKER_CERT_PATH # location of the .pem files
DOCKER_HOST # IP of the Docker host
```

## Running tests

Tests must be run using `lein`. The tests can be run via `test`

```shell script
lein do clean, test
```

or via `test2junit`

```shell script
lein do clean, test2junit
```

In this case the JUnit test reports in XML format will be available under 
`test2junit/xml` folder.
