#!/usr/bin/env bash

# check helm command
echo "[Step 1/3] Task [Check helm status]"
if [ ! -e "/usr/local/bin/helm" ]; then
  echo "[Step 1/4] helm not found"
  exit 1
fi
echo "[Step 1/3] ok"

# check metallb
echo "[Step 2/3] Task [Check MetalLB status]"
namespace=$(kubectl get namespace metallb-system -o jsonpath={.metadata.name} 2> /dev/null)
if [ "$namespace" == "" ]; then
  echo "[Step 2/3] metallb not found" 
  exit 1
fi
echo "[Step 2/3] ok"

# create nfs directory & change owner
nfsdir=/nfs_shared/grafana
echo "[Step 3/3] Task [Create NFS directory for grafana]"
if [ ! -e "$nfsdir"  ]; then
  ~/_Book_k8sInfra/ch6/6.4.1/nfs-exporter.sh grafana
  chown 1000:1000 $nfsdir
  echo "$nfsdir created"
  echo "[Step 3/3] Successfully completed"
else
  echo "[Step 3/3] failed: $nfsdir already exists"
  exit 1
fi
