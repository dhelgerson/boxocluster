# Use Rocky Linux 9.5 as the base image
FROM rockylinux/rockylinux:9.5

# necessary deps
RUN dnf group install "Development Tools" -y
RUN dnf install -y glib2-devel pkgconf-pkg-config

# build qemu
WORKDIR /build
#COPY qemu-10.1.0.tar .
RUN bash -c 'curl -L https://download.qemu.org/qemu-10.1.0.tar.xz | tar xJ'
# RUN tar xf qemu-10.1.0.tar.xz

RUN python3 -m venv venv
RUN bash -c 'yes | /build/venv/bin/pip3 install tomli ninja'
WORKDIR /build/qemu-10.1.0
RUN bash -c 'source /build/venv/bin/activate && ./configure --prefix=/opt/qemu --enable-slirp --target-list=x86_64-softmmu'
RUN make -j install

# COPY make_qemu.sh .
# RUN bash make_qemu.sh

# Set working directory inside container
WORKDIR /app

# Copy files from host to container
COPY ./start_cluster.sh .

# Run the script when the container starts
CMD ["/bin/bash", "/app/start_cluster.sh"]
