FROM scratch

ADD overlayfs.tar /
ADD run.sh /run.sh
RUN chmod a+x /run.sh

ENV HOME /root
WORKDIR /root
CMD ["/run.sh"]