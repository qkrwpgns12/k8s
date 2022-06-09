nfsdir=/nfs_shared/$1
if [ $# -eq 0 ]; then
  echo "usage: nfs-exporter.sh <name>"; exit 0
fi

if [[ ! -d $nfsdir ]]; then
  mkdir -p $nfsdir
  echo "$nfsdir 10.25.240.0/24(rw,sync,no_root_squash)" >> /etc/exports
  if [[ $(systemctl is-enabled nfs-server) -eq "disabled" ]]; then
    systemctl enable nfs-server
  fi
    systemctl restart nfs-server
fi
