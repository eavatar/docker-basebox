FROM eavatar/builder:0.1.7

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -q && apt-get install -qy busybox-static runit bash pwgen

RUN mkdir -p /dist
WORKDIR /dist

RUN mkdir -p bin etc etc/service dev dev/pts lib proc sys tmp var var/lib var/run var/log \
    usr usr/sbin usr/bin usr/lib root

RUN chmod a+w tmp &&\
    touch etc/resolv.conf &&\
    cp /etc/nsswitch.conf etc/nsswitch.conf &&\
    echo root:x:0:0:root:/root:/bin/sh > etc/passwd &&\
    echo root:x:0: > etc/group &&\
    echo ava:x:1000:1000::/home/ava:/bin/bash >> etc/passwd &&\
    echo ava:x:1000: >> etc/group &&\
    echo ava:x:1000:1000::/home/ava:/bin/bash >> /etc/passwd &&\
    echo ava:x:1000: >> /etc/group

RUN ln -s lib lib64 &&\
    ln -s bin sbin &&\
    cp /bin/busybox bin &&\
    /bin/busybox --install -s /dist/bin &&\
    bash -c "cp /lib/x86_64-linux-gnu/lib{c,m,dl,rt,nsl,nss_*,pthread,resolv}.so.* lib" &&\
    cp -a /root /dist/ &&\
    mkdir -p /dist/home/ava &&\
    chown -R ava:ava home/ava

RUN cp /usr/sbin/runsvdir-start usr/sbin/ &&\
    cp /usr/bin/runsvdir usr/bin/ &&\
    cp /usr/bin/runsv usr/bin/ &&\
    cp /usr/bin/chpst usr/bin/ &&\
    cp /usr/bin/sv usr/bin/ &&\
    cp /usr/bin/svlogd usr/bin/ &&\
    cp /usr/bin/pwgen usr/bin/ &&\
    cp /bin/bash bin/ &&\
    cp /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 lib/ &&\
    cp /lib/x86_64-linux-gnu/libtinfo.so.5 lib/ &&\
    cp /lib/x86_64-linux-gnu/libutil.so.1 lib/ &&\
    cp /lib/x86_64-linux-gnu/libz.so.1 lib/

RUN tar cf /overlayfs.tar .

RUN for X in null ptmx random stdin stdout stderr tty urandom zero ; do tar uf /overlayfs.tar -C/ ./dev/$X ; done
