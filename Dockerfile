FROM archlinux:base

RUN pacman -Syu --noconfirm
# RUN pacman -S --noconfirm --needed m4 gmp mpfr
RUN pacman -S --noconfirm --needed sudo fakeroot cmake make automake autoconf gcc libtool m4 git python-pip cddlib python-tensorflow python-pytorch cuda

RUN useradd -m notroot
RUN echo "notroot ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/notroot
USER notroot
WORKDIR /home/notroot

RUN git clone https://aur.archlinux.org/yay-bin.git && \
    cd yay-bin && \
    makepkg --noconfirm --syncdeps --rmdeps --install --clean && \
    rm -rf /home/notroot/yay-bin

RUN yay -S --noconfirm --needed gurobi

RUN yay -Scc --aur --noconfirm

USER root
WORKDIR /root

RUN python3 -m pip install tqdm onnx onnxruntime mpmath

ADD ./arch-install.sh ./arch-install.sh
RUN sh ./arch-install.sh
ADD ./gen_lic.sh ./gen_lic.sh

ADD ./eran_include ./eran_include

RUN echo "source ~/eran_include" > .bashrc

WORKDIR /root/ERAN

ADD https://files.sri.inf.ethz.ch/eran/nets/tensorflow/cifar/cifar_relu_4_100.tf .

ENTRYPOINT bash ../gen_lic.sh && bash -i
