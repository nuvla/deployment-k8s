#!/bin/bash

set -xe
set -o errtrace

function cleanup() {
  echo "Running cleanup..."
  $DM_BIN rm -y "$($DM_BIN ls -q)"
  echo "Running cleanup... done."
}

trap cleanup ERR

action_err_msg="Action required: deploy|terminate"
ACTION=${1:?$action_err_msg}
WORKERS_COUNT=${2:-1}
WORKER_VM_PROFILE=${3:-'Large'}
WORKER_DISK_SIZE=${4:-100}
IMG_NAME=${5:-'Linux Ubuntu 18.04 LTS 64-bit'}

KUBERNETES_VER=1.19.5-00

MASTER_VM_PROFILE=$WORKER_VM_PROFILE

DM_VER=v0.16.2
DM_BIN=$HOME/docker-machine

if [ ! -f "$DM_BIN" ]; then
    base=https://github.com/docker/machine/releases/download/$DM_VER
    curl -L $base/docker-machine-"$(uname -s)"-"$(uname -m)" >"$DM_BIN"
fi
chmod +x "$DM_BIN"

SSH_KEY=${SSH_KEY:-${HOME}/.ssh/id_rsa}

if [ ! -f "${SSH_KEY}" ]; then
    echo "creating ${SSH_KEY}"
    yes y | ssh-keygen -q -t rsa -N '' -f ${SSH_KEY} &>/dev/null
fi

#
# A "docker-machine" security group will be created. Specify
# --exoscale-security-group if you need a specific one.
#
BNAME=dockermachine-$(date +%Y%m%d%H%M%S)-k8s
MNAME=${BNAME}-master
CREATE_CMD="create --driver exoscale
    --exoscale-security-group slipstream_managed
    --exoscale-ssh-user root
    --exoscale-ssh-key ${SSH_KEY}
    --exoscale-api-key ${EXOSCALE_API_KEY:?provide EXOSCALE_API_KEY value}
    --exoscale-api-secret-key ${EXOSCALE_API_SECRET:?provide EXOSCALE_API_SECRET value}
    --exoscale-availability-zone ${EXOSCALE_REGION:-CH-GVA-2}"

deploy_master() {
    echo "::: Provisioning master: $MNAME"
    $DM_BIN $CREATE_CMD --exoscale-instance-profile $MASTER_VM_PROFILE \
        --exoscale-image "$IMG_NAME" "$MNAME"
    ip=$($DM_BIN ip "$MNAME")
    $DM_BIN ssh "$MNAME" "sudo docker swarm init --force-new-cluster --advertise-addr $ip"
    $DM_BIN scp ./k8s-install.sh "$MNAME":~
    $DM_BIN ssh "$MNAME" ./k8s-install.sh master $KUBERNETES_VER
}

deploy_worker() {
    local WNAME=$1
    shift
    local joinTokenK8s=$@
    echo "::: Provisioning worker: $WNAME"
    $DM_BIN $CREATE_CMD --exoscale-instance-profile $WORKER_VM_PROFILE \
        --exoscale-disk-size "$WORKER_DISK_SIZE" \
        --exoscale-image "$IMG_NAME" "$WNAME"
    $DM_BIN scp ./k8s-install.sh "$WNAME":~
    $DM_BIN ssh "$WNAME" ./k8s-install.sh worker $KUBERNETES_VER
    $DM_BIN ssh "$WNAME" "sudo $joinTokenK8s"

    ip=$($DM_BIN ip "$MNAME")
    joinTokenDocker=$($DM_BIN ssh "$MNAME" "sudo docker swarm join-token worker -q" | tr -d '\r')
    $DM_BIN ssh "$WNAME" "sudo docker swarm join --token ${joinTokenDocker} ${ip}:2377"
}

deploy() {
    workers_count=${1:-1}

    deploy_master

    if [ "$workers_count" -ge 1 ]; then
        joinTokenK8s=$($DM_BIN ssh "$MNAME" "kubeadm token create --print-join-command" | tr -d '\r')
        for i in $(seq 1 $workers_count); do
            WNAME=${BNAME}-worker${i}
            deploy_worker $WNAME "$joinTokenK8s" &
        done
        wait
    fi

    ip=$($DM_BIN ip "$MNAME")
    echo "k8s master: $ip"

    $DM_BIN ssh "$MNAME" kubectl get nodes

    config=$(pwd)/kubeconfig.yaml
    echo ::: Copy admin config to $config
    $DM_BIN scp $MNAME:~/.kube/config $config

    echo "$ip" > "$HOME"/nuvla-test-host
    echo "$MNAME" > "$HOME"/docker-machine-master
}

terminate() {
    machines=()
    while read m;do machines+=( "$m" );done < <($DM_BIN ls -q)
    if [ "${#machines[@]}" -eq 0 ]; then
        echo "WARNING: no machines to terminate"
    else
        for m in ${machines[@]};do
            $DM_BIN rm -y "$m" &
        done
        wait
    fi
}

if [ "$ACTION" == "deploy" ]; then
    deploy "$WORKERS_COUNT"
elif [ "$ACTION" == "terminate" ]; then
    terminate
else
    echo "$action_err_msg"
    exit 1
fi
