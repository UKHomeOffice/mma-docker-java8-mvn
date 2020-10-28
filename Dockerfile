FROM centos:centos7

RUN echo "exclude=filesystem*" >> /etc/yum.conf

ENV	HOME /root
ENV	LANG en_US.UTF-8
ENV	LC_ALL en_US.UTF-8
ENV MVN_VERSION=3.6.3

 RUN yum clean all && \
    yum install yum-plugin-ovl -y && \
    yum update -y && \
    yum install -y git java-1.8.0-openjdk-devel && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    rpm --rebuilddb  

 ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk

 RUN yum update -y && \
    yum clean all && \
    rpm --rebuilddb  

 RUN mkdir -p ${HOME}/.m2/ && \
    curl -sS \
    http://www.mirrorservice.org/sites/ftp.apache.org/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz \
    -o /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz && \
    tar xvzf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz -C /tmp && \
    mv /tmp/apache-maven-${MVN_VERSION} /var/local/ && \
    ln -s /var/local/apache-maven-${MVN_VERSION}/bin/mvnyjp /usr/local/bin/mvnyjp && \
    ln -s /var/local/apache-maven-${MVN_VERSION}/bin/mvnDebug /usr/local/bin/mvnDebug && \
    ln -s /var/local/apache-maven-${MVN_VERSION}/bin/mvn /usr/local/bin/mvn

RUN mkdir /app

WORKDIR /app

COPY settings.xml ${HOME}/.m2/

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["mvn -v"]