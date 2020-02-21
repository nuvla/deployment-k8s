# Persistent volumes on CephFS for Nuvla

The following assumes [Rook](https://rook.io) storage orchestrator for
Kubernetes is used to manage Ceph on the cluster. The static volumes on CephFS
are used.

## Create CephFS file system

First, one needs to create file system on Ceph to be used to store Nuvla's
persistent data from Zookeeper and Elasticsearch.

***CSI secret***

A secret CSI to access CephFS should be pre-created using the `client.admin` key
from `ceph auth ls`. Use Rook Ceph `tools` container to get that value. Use
`echo -n <string> | base64` to encode ID and Key. For details on the creation of
the secret and troubleshooting see
https://gist.github.com/ShyamsundarR/f16d32e3edd5b38df50e90106674a943

To create the secret use `static-pv-csi-secret.yaml` as template, change
`CHANGE_ME_` values, and run

     kubectl create -f static-pv-csi-secret.yaml

The `name` of the secret will be referenced during creation of PVs below.

***Create CephFS***

Create a separate CephFS called `nuvla` to hold Nuvla data from DB tier. 

     kubectl create -f nuvla-cephfs.yaml

## Create Persistent Volumes for Zookeeper and Elasticsearch

    kubectl create -f zk-pv-data.yaml
    kubectl create -f zk-pv-datalog.yaml
    kubectl create -f es-pv-data.yaml
