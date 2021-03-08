ARG STEP_1_IMAGE=debian:10.8

FROM ${STEP_1_IMAGE} AS STEP_1

ENV OSQUERY_KEY=1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B
RUN apt-get update && \
    apt-get install -y \
        apt-transport-https \
        gnupg2 \
        software-properties-common && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $OSQUERY_KEY && \
    add-apt-repository 'deb [arch=amd64] https://pkg.osquery.io/deb deb main' && \
    apt-get update && \
    apt-get install -y \
        osquery && \
    apt-get remove --purge -y \
        apt-transport-https \
        gnupg2 \
        software-properties-common && \
    apt-get clean autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*
