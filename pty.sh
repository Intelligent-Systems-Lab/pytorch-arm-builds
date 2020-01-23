sudo apt-get update

sudo apt-get upgrade -y


wget http://cdimage.ubuntu.com/ubuntu-base/releases/18.04/release/ubuntu-base-18.04.1-base-arm64.tar.gz
mkdir rootfs
sudo tar xzvf ubuntu-base-18.04.1-base-arm64.tar.gz -C $HOME/rootfs

sudo apt-get install -y qemu-user-static
sudo cp /usr/bin/qemu-arm-static $HOME/rootfs/usr/bin/
sudo cp /usr/bin/qemu-aarch64-static $HOME/rootfs/usr/bin

sudo cp /etc/resolv.conf $HOME/rootfs/etc/resolv.conf

cd

wget https://raw.githubusercontent.com/psachin/bash_scripts/master/ch-mount.sh

sudo chmod +x ch-mount.sh

echo "=========="
uname -a
echo "=========="

sudo ./ch-mount.sh -m $HOME/rootfs

apt-get update

apt-get -y upgrade

apt install -y python3 python3-pip git

apt-get install -y \
  language-pack-en-base \
  sudo \
  ssh \
  net-tools \
  network-manager \
  iputils-ping \
  rsyslog \
  bash-completion \
  htop \

apt install -y libopenblas-dev libblas-dev m4 cmake cython python3-dev python3-yaml python3-setuptools python3-wheel python3-pillow python3-numpy

echo 'nameserver 8.8.8.8' > /etc/resolv.conf

echo "=========="
python3 -V
echo "=========="

git clone https://github.com/pytorch/pytorch && cd pytorch
git checkout v1.3.1
git submodule update --init --recursive


export NO_CUDA=1
export NO_DISTRIBUTED=1
export NO_MKLDNN=1 
export BUILD_TEST=0
export MAX_JOBS=8

python3 setup.py bdist_wheel


git clone https://github.com/pytorch/vision && cd vision
git checkout v0.4.0
git submodule update --init --recursive
python3 setup.py bdist_wheel



