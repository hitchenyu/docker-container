FROM centos:latest
MAINTAINER lujinbo

#RUN apt-get update
#设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#安装中文包
RUN yum install -y kde-l10n-Chinese
RUN yum reinstall -y glibc-common
ENV LANG=C.UTF-8
ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN:zh
#安装ifconfig
RUN yum install -y net-tools
#安装vim
RUN yum install -y vim
#安装ssh服务
RUN yum install -y openssh-server sudo
RUN sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
#安装openssh-clients
RUN yum  install -y openssh-clients
# 添加测试用户root，密码root，并且将此用户添加到sudoers里
RUN echo "root:root" | chpasswd
RUN echo "root   ALL=(ALL)       ALL" >> /etc/sudoers
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
