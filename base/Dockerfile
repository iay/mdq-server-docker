#
# mdq-server base dockerfile
#
FROM openjdk:8-slim

MAINTAINER Ian Young <ian@iay.org.uk>

WORKDIR /opt/mdq-server

ADD mdq-server.jar /opt/mdq-server/

EXPOSE 80

VOLUME ["/opt/mdq-server/logs", "/opt/mdq-server/creds"]

CMD ["java", "-jar", "mdq-server.jar"]
