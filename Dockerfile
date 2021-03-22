FROM archlinux:base

RUN pacman -Syu --noconfirm
# RUN pacman -S --noconfirm --needed m4 gmp mpfr
RUN pacman -S --noconfirm --needed sudo fakeroot make automake autoconf gcc libtool m4 git python-pip cddlib

RUN useradd -m notroot
RUN echo "notroot ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/notroot
USER notroot
WORKDIR /home/notroot
RUN git clone https://aur.archlinux.org/gurobi.git && cd gurobi && \
    makepkg --noconfirm --syncdeps --rmdeps --install --clean && \
    rm -rf /home/notroot/gurobi

USER root

RUN pacman -Scc --noconfirm

WORKDIR /home/root
ADD ./arch-install.sh ./arch-install.sh
RUN sh ./arch-install.sh
ADD ./gen_lic.sh ./gen_lic.sh

ENTRYPOINT bash gen_lic.sh && bash
