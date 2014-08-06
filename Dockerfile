#
# mdq-server dockerfile
#
# For now at least, base this on the library "java" image.
# This is based on Ubuntu Jessie, updated, with the provided
# Java 7 OpenJDK added.
#
FROM java:7

MAINTAINER Ian Young <ian@iay.org.uk>

WORKDIR /opt/mdq-server

ADD mdq-server-0.0.1-SNAPSHOT.jar /opt/mdq-server/
ADD application.properties        /opt/mdq-server/

EXPOSE 80

VOLUME ["/opt/mdq-server/logs", "/opt/mdq-server/creds"]

CMD ["java", "-jar", "mdq-server-0.0.1-SNAPSHOT.jar"]
