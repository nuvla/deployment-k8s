# Deploy Kubernetes cluster

Scripts in this folder deploy Kubernetes cluster on Exoscale cloud. 

Before provisioning the cluster first, copy `env.sh.template` to `env.sh` and
edit CHANGE_ME variables.

To provision cluster with 2 worker nodes, run

    ./k8s-deploy-exoscale.sh deploy 2

As a result the script will produce in the local directory the cluster
configuration file named `config.dockermachine-<timestamp>-k8s`. It can either
be used either

 * with `--kubeconfig` parameter to `kubectl`, or
 * exported as `export KUBECONFIG=/path/to/config`, or
 * added to user default configuration file `~/.kube/config` (for example using 
 `konfig` plugin).

Get nodes to check that the cluster of the requested version and size is up and
running.

    $ kubectl get node
    NAME                                       STATUS   ROLES    AGE   VERSION
    dockermachine-20200221145539-k8s-master    Ready    master   31m   v1.14.0
    dockermachine-20200221145539-k8s-worker1   Ready    <none>   26m   v1.14.0
    dockermachine-20200221145539-k8s-worker2   Ready    <none>   26m   v1.14.0
    $
