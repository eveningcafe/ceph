
[core]
http://www.sebastien-han.fr/blog/2017/02/27/Containerize-Ceph-blueprint-store-ceph-options-in-monitor-kv-store/
ceph/daemon:v3.0.1-stable-3.0-luminous-ubuntu-16.04-x86_64 
[dowld va chay imange]
docker -d --net=host
-e enviroment-variable-vm ...
[list cac may ao dang chay]
docker ps
[lay vao terminal]
docker exec -it ten-mayao bash
[lay cac bien moi truong may ao]
export
[xoa imange, container]
docker stop ten-conterner
docker rm ten-container
[tao pool , quyen]
ceph auth get-or-create client.hadoop mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=hadoop' -o /etc/ceph/ceph.client.hadoop.keyring
ceph auth get-or-create cephfsdata mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=cephfs_metadata, allow rwx pool=cephfs_data' -o /etc/ceph/ceph.cephfsdata.keyring
ceph auth caps client.huser mds 'allow rw' mon 'allow r' osd 'allow class-read class-write object_prefix rbd_children, allow rwx pool=cephfs_metadata, allow rwx pool=cephfs_data, allow rwx pool=hadoop1'
ceph auth get-or-create client.clusterA mon 'allow r' mds 'allow rw, allow r path=/, allow rw path=/clusterA ' osd 'allow class-read class-write object_prefix rbd_children,  allow rwx pool=cephfs_metadata, allow rwx pool=cephfs_data'
[tao mds]
docker run -d --net=host MDS_NAME=mymds -e CEPHFS_CREATE=1 -e KV_TYPE=etcd -e KV_IP=10.0.3.139 ceph/daemon:v3.0.1-stable-3.0-luminous-ubuntu-16.04-x86_64 mds 
[mout vao ubuntu]
sudo mount -t ceph 10.0.3.135:6789:/ /mnt/mycep -o name=admin,secret=AQBECLJavl16GhAAva6ndvNIgr7RnFROnRRRtw==
sudo ceph-fuse -n client.huser --keyring=/etc/ceph/ceph.client.huser.keyring /mnt/cephfs/
[radosgw]
docker run -d --net=host -e KV_TYPE=etcd -e KV_IP=10.0.3.139 -e RGW_NAME=gate ceph/daemon: rgw
[swift-client]
swift -A http://192.168.2.140:8080/auth/1.0 -U testuser:swift -K 'Ub4WBBmOdGxsaeYAo2gbpUDXRhhQtA8hTc5YKDDD' list
[nat ra mang]
sudo iptables -t nat -A POSTROUTING -s 10.10.1.0/24 -o ens3 -j SNAT --to-source 192.168.2.54
RGW_CIVETWEB_PORT
