FROM lpenz/ubuntu-maverick-i386

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://old-releases.ubuntu.com/ubuntu maverick main universe" > /etc/apt/sources.list && \
    apt-get update && apt-get -yy dist-upgrade && apt-get -y --no-install-recommends install apt-utils && \
    apt-get -y --no-install-recommends install psmisc sudo libopenal1 libsdl1.2debian libavcodec52 libavformat52 \
    libswscale0 libqt4-xml libqt4-opengl libqt4-webkit libqt4-script libqt4-scripttools libvdpau1 libhighgui2.1 \
    x11-utils libglu1-mesa xdg-utils gnome-icon-theme && rm -rf /var/lib/apt/lists/* && \
    export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown 1000:1000 -R /home/developer && \
    usermod -aG audio developer

COPY multivision2_2.0.0b69_i386_10.10.deb userconfig.tar.gz /home/developer/

RUN dpkg -i /home/developer/multivision2_2.0.0b69_i386_10.10.deb

USER developer

RUN cd /home/developer && tar -zxf userconfig.tar.gz

ENV HOME /home/developer

CMD ["/bin/bash"]
