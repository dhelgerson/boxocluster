#!/bin/bash

# setup env
# since we're forking subjobs, we need to export these
export LD_LIBRARY_PATH=/opt/qemu/lib64:/usr/lib64:/usr/lib64/pipewire-0.3/jack
export PATH=/opt/qemu/bin:$PATH

# start head node

echo "starting head node"
bash -c 'qemu-system-x86_64 \
-cpu host \
-smp sockets=1,cores=4,threads=1 \
-m 4G \
-enable-kvm \
-drive file=boxocluster-node-1.qcow2,media=disk,if=virtio \
-device virtio-net,netdev=n1 \
-netdev socket,id=n1,mcast=239.192.0.1:2224 \
-nic user,hostfwd=tcp:0.0.0.0:2222-:22 \
-nographic \
> headnode.out ' &

# give the head node ample time to come up

sleep 20

# tell user how to connect

echo "connect to the head node with 'ssh admin@localhost -p 2222'"
echo "the password is 'tuxcluster'"

# start compute nodes

echo "starting compute nodes"
for SLURM_LOCALID in {2..4};
do
export SLURM_LOCALID
bash -c 'qemu-system-x86_64 \
-cpu host \
-smp sockets=1,cores=4,threads=1 \
-m 4G \
-enable-kvm \
-device virtio-net,netdev=n3,mac=52:54:00:12:34:5$SLURM_LOCALID \
-netdev socket,id=n3,mcast=239.192.0.1:2224 \
-nographic \
> compute$SLURM_LOCALID.out ' &
done

# since all jobs are forked to background, we need to wait for them so the parent doesn't finish and kill the children

wait
