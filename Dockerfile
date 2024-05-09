FROM centos:centos7
# MAINTAINER jincy <jincy@zenitera.com>

RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org/centos|baseurl=https://mirrors.ustc.edu.cn/centos|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-Base.repo && yum makecache && yum update -y && yum -y install git wget\
         && echo "zht_pkg" > /etc/yum/vars/signalwireusername \
         && echo "pat_Dn7AjMXzmgTYkAfugDCTL6Ys" > /etc/yum/vars/signalwiretoken\
         && yum install -y https://$(< /etc/yum/vars/signalwireusername):$(< /etc/yum/vars/signalwiretoken)@freeswitch.signalwire.com/repo/yum/centos-release/freeswitch-release-repo-0-1.noarch.rpm epel-release\
         && yum-builddep -y freeswitch\
         && yum install -y yum-plugin-ovl centos-release-scl yum-utils git\
         && yum install -y devtoolset-4-gcc*

#ADD libks.tar.gz /usr/src/libs/
#ADD sofia-sip.tar.gz /usr/src/libs/
#ADD spandsp.tar.gz /usr/src/libs/
#ADD signalwire-c.tar.gz /usr/src/libs/

#RUN cd /usr/src/libs/libks && cmake . -DCMAKE_INSTALL_PREFIX=/usr -DWITH_LIBBACKTRACE=1 && make install && make clean\
 #&& cd /usr/src/libs/sofia-sip &&./bootstrap.sh\
 #&& ./configure CFLAGS="-g -ggdb" --with-pic --with-glib=no --without-doxygen --disable-stun --prefix=/usr\
 #&& make -j`nproc --all` && make install && make clean\
 #&& cd /usr/src/libs/spandsp && ./bootstrap.sh\
 #&& ./configure CFLAGS="-g -ggdb" --with-pic --prefix=/usr && make -j`nproc --all`\
 #&& make install && make clean\
 #&& cd /usr/src/libs/signalwire-c && PKG_CONFIG_PATH=/usr/lib/pkgconfig cmake . -DCMAKE_INSTALL_PREFIX=/usr && make install && make clean

#RUN cd /usr/src/freeswitch && ./bootstrap.sh -j
#RUN cd /usr/src/freeswitch && ./configure
#RUN cd /usr/src/freeswitch && make -j`nproc` && make install

# Cleanup the image
#RUN apt-get clean

# Uncomment to cleanup even more
#RUN rm -rf /usr/src/*
