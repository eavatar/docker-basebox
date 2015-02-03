FROM ubuntu:14.04.1

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -q
RUN apt-get install -qy busybox-static runit bash pwgen

RUN mkdir -p /dist
WORKDIR /dist

RUN mkdir -p bin etc etc/service dev dev/pts lib proc sys tmp var var/lib var/run var/log \
    usr usr/sbin usr/bin usr/lib root

RUN chmod a+w tmp

RUN touch etc/resolv.conf
RUN cp /etc/nsswitch.conf etc/nsswitch.conf

RUN echo root:x:0:0:root:/root:/bin/sh > etc/passwd
RUN echo root:x:0: > etc/group

# the user in the builder for setting ownership.
RUN echo ava:x:1000:1000::/home/ava:/bin/bash >> etc/passwd &&\
    echo ava:x:1000: >> etc/group

# the user to run application
RUN echo ava:x:1000:1000::/home/ava:/bin/bash >> /etc/passwd &&\
    echo ava:x:1000: >> /etc/group

RUN ln -s lib lib64
RUN ln -s bin sbin
RUN cp /bin/busybox bin
RUN /bin/busybox --install -s /dist/bin
RUN bash -c "cp /lib/x86_64-linux-gnu/lib{c,m,dl,rt,nsl,nss_*,pthread,resolv}.so.* lib"

RUN cp -a /root /dist/
RUN mkdir -p /dist/home/ava
RUN chown -R ava:ava home/ava

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
