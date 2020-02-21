#!/bin/bash
set -ex

ROLE=${1:?"Role: master or worker"}

K8S_VER=${K8S_VER:-1.14.0-00}

sudo apt-get update
sudo sudo apt-get install -y apt-transport-https
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6A030B21BA07F4FB
sudo apt-get update
sudo apt-get install -y kubelet=$K8S_VER kubeadm=$K8S_VER
if [ "$ROLE" == "master" ]; then
    sudo apt-get install -y --allow-downgrades kubectl=$K8S_VER
    sudo kubeadm init --pod-network-cidr=10.244.0.0/16
    mkdir $HOME/.kube
    sudo cp /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
    sudo chown ubuntu. .kube/config
    kubectl cluster-info
    KF=https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    kubectl apply -f $KF | tee pod_network_setup.txt
    sudo sed -i -e '/service-cluster-ip-range/a\' -e '    - --service-node-port-range=80-9000' /etc/kubernetes/manifests/kube-apiserver.yaml
fi
