#
# mdq-server base dockerfile
#
FROM java:openjdk-8

MAINTAINER Ian Young <ian@iay.org.uk>

WORKDIR /opt/mdq-server

ADD mdq-server-0.0.1-SNAPSHOT.jar /opt/mdq-server/

EXPOSE 80

VOLUME ["/opt/mdq-server/logs", "/opt/mdq-server/creds"]

CMD ["java", "-jar", "mdq-server-0.0.1-SNAPSHOT.jar"]
