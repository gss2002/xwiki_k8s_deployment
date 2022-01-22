FROM centos:centos8

MAINTAINER greg@senia.org

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-9.0.56/* /opt/tomcat/.
RUN yum -y install java-11-openjdk
RUN yum -y install unzip
RUN java -version

WORKDIR /opt/tomcat/bin
COPY java_env .
RUN sed '1 a . /opt/tomcat/bin/java_env' -i catalina.sh

WORKDIR /opt/tomcat/lib
RUN curl -O -L https://search.maven.org/remotecontent?filepath=org/postgresql/postgresql/42.3.1/postgresql-42.3.1.jar

WORKDIR /opt/tomcat/webapps
RUN curl -O -L https://nexus.xwiki.org/nexus/content/groups/public/org/xwiki/platform/xwiki-platform-distribution-war/12.10.11/xwiki-platform-distribution-war-12.10.11.war
RUN mkdir xwiki
WORKDIR /opt/tomcat/webapps/xwiki
RUN unzip -x ../xwiki-platform-distribution-war-12.10.11.war
WORKDIR /opt/tomcat/webapps
RUN rm xwiki-platform-distribution-war-12.10.11.war

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
