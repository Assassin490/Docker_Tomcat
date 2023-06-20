FROM centos:latest
USER root
RUN mkdir -p /opt/Tomcat9
COPY apache-tomcat-9.0.75 /opt/Tomcat9
RUN mkdir -p /usr/java
COPY jdk1.8.0_202 /usr/java
RUN alternatives --install /usr/bin/java java /usr/java/bin/java 1; \
alternatives --install /usr/bin/javac javac /usr/java/bin/javac 1
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*; \
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*; \
yum install -y sudo ncurses vim telnet -y; \
yum update -y; \
echo "alias ll='ls -la'" >> /root/.bashrc; \
echo "export CATALINA_HOME='/opt/Tomcat9'" >> /root/.bashrc; \
echo "export Conf_Catalina='/opt/Tomcat9/conf'" >> /root/.bashrc; \
echo "export Bin_Catalina='/opt/Tomcat9/bin'" >> /root/.bashrc; \
echo "export JRE_HOME=/usr/java/jre/" >> /root/.bashrc; \
echo "export PATH=$PATH:$JRE_HOME/bin" >> /root/.bashrc; \
echo "export JAVA_HOME=/usr/java/bin" >> /root/.bashrc; \
echo "export PATH=$PATH:$JAVA_HOME/bin" >> /root/.bashrc; \
source /root/.bashrc; \
chmod 777 -R /opt/Tomcat9
WORKDIR /opt/Tomcat9/webapps
RUN curl -O -L https://github.com/AKSarav/SampleWebApp/raw/master/dist/SampleWebApp.war
RUN cd /opt/Tomcat9/bin
ENTRYPOINT ["/opt/Tomcat9/bin/catalina.sh", "run"]
EXPOSE 8080
# CMD ["/bin/bash"]
#docker exec -ti banregio-CommerceFiel-1 /bin/bash
#docker build -t centos8_tomcat9 .